package com.hamromart.dao;

import com.hamromart.entity.User;
import java.util.List;

public interface UserDAO {
    boolean register(User user);
    User authenticate(String email, String password);
    User findById(int id);
    User findByEmail(String email);
    List<User> getAllUsers();
}
