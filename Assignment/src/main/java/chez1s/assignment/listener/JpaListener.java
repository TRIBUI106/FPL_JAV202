package chez1s.assignment.listener;

import chez1s.assignment.util.JpaUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Closes the JPA EntityManagerFactory when the application shuts down.
 */
@WebListener
public class JpaListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaUtil.close();
    }
}
