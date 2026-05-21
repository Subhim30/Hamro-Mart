# HamroMart Runnable IntelliJ/Tomcat/Maven Version

This copy is prepared for **JDK 17 + Maven + Apache Tomcat 10.1 + Jakarta Servlet/JSP/JSTL**.

Open `RUN_IN_INTELLIJ_TOMCAT_MAVEN.txt` first for exact setup steps.

**URL:** `http://localhost:8080/hamromart/`

**Admin login:** `admin@hamromart.com` / `admin123`

**Customer login:** `rubina@gmail.com` / `user123`

Important: the login page uses **email**, not username.

---

# Hamromart Grocery - Setup & Execution Guide

Hamromart is a premium, fully featured Java Web Application developed using the **Maven** build system, **Java Servlets**, **Java Server Pages (JSP)**, and standard JDBC with **MySQL**. It implements the architectural DAO pattern with full session control, transaction checkouts, dynamic LocalStorage baskets, and a complete administrative CRUD control center.

## Prerequisites

Before starting, make sure you have the following installed on your machine:
1. **Java Development Kit (JDK) 17** or above.
2. **Apache Maven 3.8+**.
3. **MySQL Server 8.0+** running locally on port `3306`.

---

## Database Configuration

1. Log into your local MySQL CLI or a client like DBeaver / MySQL Workbench:
   ```bash
   mysql -u root -p
   ```
2. Run the database schema initialization script:
   - Execute the SQL file found in `sql/setup_schema.sql` to initialize the database `hamromart_db` and all mandatory tables (`users`, `categories`, `products`, `orders`, `order_items`, and `messages`).
   - Execute the seed data file found in `sql/seed.sql` to populate initial products, food categories, and admin credentials.
   
> [!NOTE]
> **Auto-Bootstrap Database:**
> We have implemented a dynamic startup listener `DatabaseBootstrapListener`. As long as you have MySQL running locally with user `root` and an empty password, the application will **automatically create the database, tables, and seed all sample grocery items** upon startup! You don't have to execute SQL commands manually if your local server matches these credentials.

---

## Folder Architecture

The project matches the standard Java Web enterprise structure:
- `src/main/java/com/hamromart/entity/`: POJO database mappings (`User`, `Category`, `Product`).
- `src/main/java/com/hamromart/dao/`: Data Access Object interfaces and JDBC implementations.
- `src/main/java/com/hamromart/controller/`: Java Servlets handling web routes (Login, Products, Cart Checkout, Categories, Admin controls).
- `src/main/java/com/hamromart/filter/`: `AuthFilter` securing administration dashboard endpoints.
- `src/main/java/com/hamromart/utils/`: JDBC connection pools, SHA-256 password hash security, and schema bootstrappers.
- `src/main/webapp/`: Customer views, checkout baskets, shared layout files (`header.jsp`, `footer.jsp`), and administrative CRUD panels.
- `src/main/webapp/static/`: Premium custom HSL-based stylesheets (`style.css`) and client shopping cart engines (`main.js`).

---

## Building the Project

Open your terminal in the root directory `c:\Users\rubina gurung\Desktop\hamromart\` and execute the following Maven packaging command:

```bash
mvn clean package
```

This compiles all Java source files, executes resource bindings, and generates a deployable enterprise Web Archive file:
`target/hamromart.war`

---

## Running the Web Application

### Method 1: Using Apache Tomcat (Recommended)
1. Download **Apache Tomcat 9.0** or **Tomcat 10.0** (if using modern servlet packages).
2. Copy the generated `target/hamromart.war` file.
3. Paste it inside Tomcat's `webapps/` folder.
4. Run Tomcat (`bin/startup.bat` on Windows).
5. Open your browser and navigate to:
   `http://localhost:8080/hamromart`

### Method 2: Integrated IDE Execution (IntelliJ IDEA / Eclipse)
1. Open IntelliJ IDEA and choose **Open Project**, select `c:\Users\rubina gurung\Desktop\hamromart\`.
2. Configure a local Tomcat Server Run Configuration:
   - Go to **Run > Edit Configurations**.
   - Click the **+** button, select **Tomcat Server > Local**.
   - In the **Deployment** tab, add `hamromart:war` or the exploded directory.
   - Run the configuration.

---

## Demo Credentials

You can test the application using these seeded accounts:

### 1. Customer Account
- **Email:** `rubina@gmail.com`
- **Password:** `user123`

### 2. Administrator Account
- **Email:** `admin@hamromart.com`
- **Password:** `admin123`
