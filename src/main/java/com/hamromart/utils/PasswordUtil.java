package com.hamromart.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {
    
    /**
     * Hashes a plain-text password using SHA-256 and returns its hex representation.
     * @param password Plain-text password to hash.
     * @return Hexadecimal SHA-256 hash string.
     */
    public static String hashPassword(String password) {
        if (password == null) return null;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password with SHA-256", e);
        }
    }

    /**
     * Checks if a plain-text password matches a hashed password.
     * @param plainPassword Plain-text input password.
     * @param hashedPassword Hashed password stored in database.
     * @return true if matches, false otherwise.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        return hashPassword(plainPassword).equals(hashedPassword);
    }
}
