package com.hamromart.dao;

import java.util.List;
import com.hamromart.entity.Product;

public interface ProductDAO {
    List<Product> getAllProducts();
    Product getProductById(int id);
    void insertProduct(Product p);
    void updateProduct(Product p);
    void deleteProduct(int id);
}