<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<h2>Add / Edit Product</h2>

<form action="product" method="post">
    <input type="hidden" name="productId" value="${product.productId}">

    Name: <input type="text" name="name" value="${product.name}"><br>
    Price: <input type="text" name="price" value="${product.price}"><br>
    Image: <input type="text" name="image" value="${product.productImage}"><br>
    Category ID: <input type="text" name="categoryId" value="${product.categoryId}"><br>

    <button type="submit">Save</button>
</form>

<hr>

<h2>Product List</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Action</th>
    </tr>

    <c:forEach var="p" items="${list}">
        <tr>
            <td>${p.productId}</td>
            <td>${p.name}</td>
            <td>${p.price}</td>
            <td>
                <a href="product?action=edit&id=${p.productId}">Edit</a>
                <a href="product?action=delete&id=${p.productId}">Delete</a>
            </td>
        </tr>
    </c:forEach>

</table>