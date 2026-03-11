package chez1s.assignment.repository;

import chez1s.assignment.entity.Drink;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class DrinkRepository extends BaseRepository<Drink, Integer> {
    public DrinkRepository() {
        super(Drink.class);
    }

    public List<Drink> findByActive(boolean active) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Drink d WHERE d.active = :active", Drink.class)
                     .setParameter("active", active)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}
