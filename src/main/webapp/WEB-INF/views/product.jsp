<%@ page import="java.util.*, com.hamromart.entity.Product, com.hamromart.entity.Category" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Hamro-Mart</title>

  <style>
    body { margin: 0; font-family: Arial; background: #f4f4f4; }
    header { display: flex; justify-content: space-between; padding: 15px 40px; background: #fff; }
    .logo { font-size: 24px; font-weight: bold; color: #d32f2f; }
    nav a { margin: 0 15px; text-decoration: none; color: #333; }

    .container { display: flex; padding: 20px; gap: 20px; }

    .sidebar { width: 250px; background: #fff; padding: 20px; border-radius: 10px; }

    .products { flex: 1; }

    .grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }

    .card {
      background: #fff;
      border-radius: 10px;
      padding: 10px;
    }

    .card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }

    .btn {
      background: red;
      color: white;
      padding: 10px;
      width: 100%;
      border: none;
    }
  </style>
</head>

<body>

<header>
  <div class="logo">Hamro-Mart</div>
  <nav>
    <a href="#">Home</a>
    <a href="${pageContext.request.contextPath}/product">Shop</a>
    <a href="#">Contact</a>
  </nav>

  <input type="text" placeholder="Search products">
</header>

<div class="container">

  <!-- SIDEBAR -->
  <div class="sidebar">
    <h3>Categories</h3>

    <%
      List<Category> categories = (List<Category>) request.getAttribute("categories");

      for(Category c : categories){
    %>
    <p>
      <a href="product?category=<%=c.getCategoryId()%>">
        <%= c.getName() %>
      </a>
    </p>
    <% } %>

    <button onclick="window.location='product'">Clear</button>
  </div>

  <!-- PRODUCTS -->
  <div class="products">

    <div class="grid">

      <%
        List<Product> list = (List<Product>) request.getAttribute("list");

        for(Product p : list){
      %>

      <div class="card">
        <img src="<%= p.getProductImage() %>">

        <h4><%= p.getName() %></h4>

        <div><%= p.getPrice() %> NPR</div>

        <form action="${pageContext.request.contextPath}/cart" method="post">
          <input type="hidden" name="productId" value="<%= p.getProductId() %>">
          <button class="btn">Add to Cart</button>
        </form>
      </div>

      <% } %>

    </div>

  </div>

</div>

</body>
</html>