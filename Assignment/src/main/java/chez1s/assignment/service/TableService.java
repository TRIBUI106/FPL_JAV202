package chez1s.assignment.service;

import chez1s.assignment.entity.CoffeeTable;
import chez1s.assignment.repository.TableRepository;
import java.util.List;

public class TableService {
    private final TableRepository tableRepo;

    public TableService() {
        this.tableRepo = new TableRepository();
    }

    public TableService(TableRepository tableRepo) {
        this.tableRepo = tableRepo;
    }

    public List<CoffeeTable> getAllTables() {
        return tableRepo.findAll();
    }

    public CoffeeTable getTableById(Integer id) {
        return tableRepo.findById(id);
    }

    public CoffeeTable getTableByCode(String code) {
        return tableRepo.findByCode(code);
    }

    public void createTable(String name, String code) {
        CoffeeTable table = new CoffeeTable();
        table.setTableNumber(name);
        table.setCode(code.toUpperCase());
        table.setActive(true);
        tableRepo.save(table);
    }

    public void updateTable(Integer id, String name, String code) {
        CoffeeTable table = tableRepo.findById(id);
        if (table != null) {
            table.setTableNumber(name);
            table.setCode(code.toUpperCase());
            tableRepo.save(table);
        }
    }

    public void deleteTable(Integer id) {
        tableRepo.delete(id);
    }
}
