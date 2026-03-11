package chez1s.assignment.service;

import chez1s.assignment.dto.BestSellingDrinkDTO;
import chez1s.assignment.dto.RevenueByDayDTO;
import chez1s.assignment.repository.StatisticRepository;
import java.util.Date;
import java.util.List;

public class StatisticService {
    private final StatisticRepository statisticRepository = new StatisticRepository();

    public List<BestSellingDrinkDTO> getTopSellingDrinks(Date from, Date to) {
        return statisticRepository.getTop5BestSellingDrinks(from, to);
    }

    public List<RevenueByDayDTO> getRevenueReport(Date from, Date to) {
        return statisticRepository.getRevenueByDay(from, to);
    }
}
