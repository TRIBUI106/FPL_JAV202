package chez1s.assignment.repository;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;

public class BillRepository extends BaseRepository<Bill, Integer> {
    public BillRepository() {
        super(Bill.class);
    }

    public List<Bill> findByUserId(Integer userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM Bill b WHERE b.user.id = :userId ORDER BY b.createdAt DESC", Bill.class)
                     .setParameter("userId", userId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public Bill findByIdAndUserId(Integer id, Integer userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT DISTINCT b FROM Bill b LEFT JOIN FETCH b.billDetails bd LEFT JOIN FETCH bd.drink WHERE b.id = :id AND b.user.id = :userId", Bill.class)
                     .setParameter("id", id)
                     .setParameter("userId", userId)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
