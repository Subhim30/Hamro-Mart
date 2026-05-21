package com.hamromart.dao;

import com.hamromart.entity.Product;
import java.util.List;

public interface ProductDAO {
    List<Product> getAll();
    List<Product> getByCategory(int categoryId);
    List<Product> searchByName(String keyword);
    Product getById(int id);
    boolean save(Product product);
    boolean update(Product product);
    boolean delete(int id);
    boolean updateStock(int id, int newStock);
}
