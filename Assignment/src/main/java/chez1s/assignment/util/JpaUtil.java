package chez1s.assignment.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * JPA Utility — singleton EntityManagerFactory.
 * Call {@link #getEntityManager()} to obtain a new EntityManager per request/operation.
 */
public final class JpaUtil {

    private static volatile EntityManagerFactory EMF;

    private JpaUtil() {}

    private static EntityManagerFactory getFactory() {
        EntityManagerFactory local = EMF;
        if (local == null) {
            synchronized (JpaUtil.class) {
                local = EMF;
                if (local == null) {
                    local = Persistence.createEntityManagerFactory("default");
                    EMF = local;
                }
            }
        }
        return local;
    }

    public static EntityManager getEntityManager() {
        return getFactory().createEntityManager();
    }

    public static void close() {
        EntityManagerFactory local = EMF;
        if (local != null && local.isOpen()) {
            local.close();
        }
    }
}
