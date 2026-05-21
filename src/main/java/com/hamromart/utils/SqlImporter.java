package com.hamromart.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.stream.Collectors;

public class SqlImporter {

    /**
     * Bootstraps the database by executing setup_schema.sql and seed.sql if tables do not exist.
     */
    public static void initializeDatabase() {
        boolean FORCE_RECREATE = false; // Set to true to seed our massive new product catalog!
        
        // Step 1: Create database if not exists using base connection
        try (Connection conn = DatabaseConnection.getBootstrappingConnection();
             Statement stmt = conn.createStatement()) {
            if (FORCE_RECREATE) {
                System.out.println("Forcing drop and recreation of hamromart_db for catalog seeding...");
                stmt.execute("DROP DATABASE IF EXISTS hamromart_db");
            }
            System.out.println("Creating database hamromart_db if it does not exist...");
            stmt.execute("CREATE DATABASE IF NOT EXISTS hamromart_db");
        } catch (Exception e) {
            System.err.println("Failed to create database hamromart_db: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Step 2: Populate tables inside database
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if users table already exists
            boolean tablesExist = false;
            try (ResultSet rs = conn.getMetaData().getTables("hamromart_db", null, "users", null)) {
                if (rs.next()) {
                    tablesExist = true;
                }
            }

            if (tablesExist) {
                System.out.println("Hamromart Database tables already exist. Skipping initialization.");
                return;
            }

            System.out.println("Initializing Hamromart Database schema...");
            executeSqlResource(conn, "/setup_schema.sql");
            
            System.out.println("Seeding Hamromart Database data...");
            executeSqlResource(conn, "/seed.sql");

            System.out.println("Hamromart Database bootstrapped successfully!");
        } catch (Exception e) {
            System.err.println("Failed to initialize database: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void executeSqlResource(Connection conn, String resourcePath) throws Exception {
        InputStream in = SqlImporter.class.getResourceAsStream(resourcePath);
        if (in == null) {
            // Fallback: try reading relative to webapp or classpath roots
            System.err.println("SQL Resource not found: " + resourcePath + ". Skipping execution.");
            return;
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(in));
             Statement stmt = conn.createStatement()) {
            
            String sql = reader.lines().collect(Collectors.joining("\n"));
            // Split SQL file contents by semicolon, ignoring comments
            String[] queries = sql.split(";");
            
            for (String query : queries) {
                String trimmedQuery = query.trim();
                // Skip comments and empty queries
                if (!trimmedQuery.isEmpty() && !trimmedQuery.startsWith("--") && !trimmedQuery.startsWith("/*")) {
                    stmt.execute(trimmedQuery);
                }
            }
        }
    }
}
