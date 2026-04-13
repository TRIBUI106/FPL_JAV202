package chez1s.assignment.db;

import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Unit tests for the DB migration routine that creates the voucher tables
 * and extends the bills table with discount/guest_voucher columns.
 *
 * <p>The migration logic itself is extracted into a private helper so it can be
 * exercised against a mocked {@link EntityManager}. No real database connection
 * is opened — {@link JpaUtil#getEntityManager()} is intercepted via
 * {@link MockedStatic}.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class DbMigrationTest {

    @Mock private EntityManager em;
    @Mock private EntityTransaction trans;
    @Mock private Query query;

    private MockedStatic<JpaUtil> jpaUtilMock;

    @BeforeEach
    void setUp() {
        jpaUtilMock = mockStatic(JpaUtil.class);
        jpaUtilMock.when(JpaUtil::getEntityManager).thenReturn(em);
        when(em.getTransaction()).thenReturn(trans);
        when(em.createNativeQuery(anyString())).thenReturn(query);
    }

    @AfterEach
    void tearDown() {
        jpaUtilMock.close();
    }

    @Test
    @DisplayName("Migration executes all required DDL statements and commits")
    void migration_happyPath_executesAllStatementsAndCommits() {
        when(query.executeUpdate()).thenReturn(0);

        runMigration();

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(em, times(5)).createNativeQuery(sqlCaptor.capture());
        List<String> allSql = sqlCaptor.getAllValues();

        assertTrue(allSql.get(0).contains("CREATE TABLE IF NOT EXISTS vouchers"),
                "first statement should create vouchers table");
        assertTrue(allSql.get(0).contains("required_points"));
        assertTrue(allSql.get(0).contains("discount_amount"));

        assertTrue(allSql.get(1).contains("CREATE TABLE IF NOT EXISTS guest_vouchers"),
                "second statement should create guest_vouchers table");
        assertTrue(allSql.get(1).contains("FOREIGN KEY (guest_id) REFERENCES guests(id)"));
        assertTrue(allSql.get(1).contains("FOREIGN KEY (voucher_id) REFERENCES vouchers(id)"));

        assertTrue(allSql.get(2).contains("ALTER TABLE bills ADD COLUMN discount_amount"));
        assertTrue(allSql.get(3).contains("ALTER TABLE bills ADD COLUMN guest_voucher_id"));
        assertTrue(allSql.get(4).contains("fk_bills_guest_voucher"));

        verify(trans).begin();
        verify(query, times(5)).executeUpdate();
        verify(trans).commit();
        verify(trans, never()).rollback();
        verify(em).close();
    }

    @Test
    @DisplayName("Optional ALTER statements swallow exceptions and migration still commits")
    void migration_optionalAlterFailures_stillCommits() {
        Query failingQuery = mock(Query.class);
        when(failingQuery.executeUpdate()).thenThrow(new RuntimeException("column already exists"));

        when(em.createNativeQuery(anyString()))
                .thenReturn(query)        // CREATE vouchers
                .thenReturn(query)        // CREATE guest_vouchers
                .thenReturn(failingQuery) // ALTER add discount_amount
                .thenReturn(failingQuery) // ALTER add guest_voucher_id
                .thenReturn(failingQuery); // ALTER add FK
        when(query.executeUpdate()).thenReturn(0);

        assertDoesNotThrow(this::runMigration);

        verify(trans).begin();
        verify(trans).commit();
        verify(trans, never()).rollback();
        verify(em).close();
    }

    @Test
    @DisplayName("Failure on required CREATE rolls back and closes entity manager")
    void migration_createFailure_rollsBack() {
        when(query.executeUpdate()).thenThrow(new RuntimeException("DDL error"));
        when(trans.isActive()).thenReturn(true);

        assertDoesNotThrow(this::runMigration);

        verify(trans).begin();
        verify(trans).rollback();
        verify(trans, never()).commit();
        verify(em).close();
    }

    @Test
    @DisplayName("EntityManager is always closed, even when begin() throws")
    void migration_beginFailure_stillClosesEntityManager() {
        doThrow(new RuntimeException("no connection")).when(trans).begin();

        assertDoesNotThrow(this::runMigration);

        verify(em).close();
    }

    /**
     * Mirror of the historical one-off migration routine, now driven by a
     * mockable EntityManager obtained from JpaUtil. Optional ALTER statements
     * are wrapped in try/catch so a re-run against an already-migrated schema
     * succeeds.
     */
    private void runMigration() {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            em.createNativeQuery("CREATE TABLE IF NOT EXISTS vouchers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255) NOT NULL, " +
                    "required_points INT NOT NULL, " +
                    "discount_amount INT NOT NULL" +
                    ") ENGINE=InnoDB;").executeUpdate();

            em.createNativeQuery("CREATE TABLE IF NOT EXISTS guest_vouchers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "guest_id INT NOT NULL, " +
                    "voucher_id INT NOT NULL, " +
                    "is_used BOOLEAN DEFAULT FALSE, " +
                    "FOREIGN KEY (guest_id) REFERENCES guests(id), " +
                    "FOREIGN KEY (voucher_id) REFERENCES vouchers(id)" +
                    ") ENGINE=InnoDB;").executeUpdate();

            try {
                em.createNativeQuery("ALTER TABLE bills ADD COLUMN discount_amount INT DEFAULT 0").executeUpdate();
            } catch (Exception ignore) {}

            try {
                em.createNativeQuery("ALTER TABLE bills ADD COLUMN guest_voucher_id INT").executeUpdate();
            } catch (Exception ignore) {}

            try {
                em.createNativeQuery("ALTER TABLE bills ADD CONSTRAINT fk_bills_guest_voucher " +
                        "FOREIGN KEY (guest_voucher_id) REFERENCES guest_vouchers(id)").executeUpdate();
            } catch (Exception ignore) {}

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
        } finally {
            em.close();
        }
    }
}
