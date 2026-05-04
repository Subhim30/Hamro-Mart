package com.hamromart.dao;

import com.hamromart.entity.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> getAllCategories();
    Category getCategoryById(int id);
    void insertCategory(Category c);
    void updateCategory(Category c);
    void deleteCategory(int id);
}