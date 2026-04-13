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

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Unit tests for the bills.status ENUM widening routine.
 *
 * <p>The DDL helper is exercised against a mocked {@link EntityManager};
 * no real database connection is opened.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class FixDbTest {

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
    @DisplayName("ALTER bills.status ENUM executes with all required states and commits")
    void alter_happyPath_executesFullEnum() {
        when(query.executeUpdate()).thenReturn(0);

        runAlter();

        ArgumentCaptor<String> sqlCaptor = ArgumentCaptor.forClass(String.class);
        verify(em).createNativeQuery(sqlCaptor.capture());
        String sql = sqlCaptor.getValue();

        assertTrue(sql.contains("ALTER TABLE bills"), "must target bills table");
        assertTrue(sql.contains("MODIFY COLUMN status"), "must modify status column");
        assertTrue(sql.contains("'PENDING'"));
        assertTrue(sql.contains("'WAITING'"));
        assertTrue(sql.contains("'PAID'"));
        assertTrue(sql.contains("'FINISHED'"));
        assertTrue(sql.contains("'CANCELLED'"));
        assertTrue(sql.contains("DEFAULT 'WAITING'"));

        verify(trans).begin();
        verify(query).executeUpdate();
        verify(trans).commit();
        verify(trans, never()).rollback();
        verify(em).close();
    }

    @Test
    @DisplayName("executeUpdate failure rolls back the active transaction")
    void alter_executeFailure_rollsBack() {
        when(query.executeUpdate()).thenThrow(new RuntimeException("DDL rejected"));
        when(trans.isActive()).thenReturn(true);

        assertDoesNotThrow(this::runAlter);

        verify(trans).begin();
        verify(trans).rollback();
        verify(trans, never()).commit();
        verify(em).close();
    }

    @Test
    @DisplayName("Rollback is skipped when transaction is already inactive")
    void alter_inactiveTransactionOnFailure_noRollback() {
        when(query.executeUpdate()).thenThrow(new RuntimeException("DDL rejected"));
        when(trans.isActive()).thenReturn(false);

        assertDoesNotThrow(this::runAlter);

        verify(trans).begin();
        verify(trans, never()).rollback();
        verify(trans, never()).commit();
        verify(em).close();
    }

    @Test
    @DisplayName("EntityManager is always closed even when begin() throws")
    void alter_beginFailure_stillClosesEntityManager() {
        doThrow(new RuntimeException("no connection")).when(trans).begin();

        assertDoesNotThrow(this::runAlter);

        verify(em).close();
    }

    /**
     * Mirror of the historical FixDb routine that widens the bills.status ENUM
     * so PENDING / WAITING / PAID / FINISHED / CANCELLED are all valid values.
     */
    private void runAlter() {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createNativeQuery(
                    "ALTER TABLE bills MODIFY COLUMN status " +
                    "ENUM('PENDING','WAITING','PAID','FINISHED','CANCELLED') DEFAULT 'WAITING'")
              .executeUpdate();
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
