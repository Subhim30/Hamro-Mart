package com.hamromart.entity;

public class Product {
    private int productId;
    private String name;
    private double price;
    private String productImage;
    private int categoryId;

    public Product() {}

    public Product(int productId, String name, double price, String productImage, int categoryId) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.productImage = productImage;
        this.categoryId = categoryId;
    }

    // Getters & Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}