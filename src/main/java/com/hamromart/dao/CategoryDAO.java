package com.hamromart.dao;

import com.hamromart.entity.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> getAll();
    Category getById(int id);
    boolean save(Category category);
    boolean update(Category category);
    boolean delete(int id);
}
