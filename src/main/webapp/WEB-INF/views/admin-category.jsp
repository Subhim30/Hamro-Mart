<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<h2>Add / Edit Category</h2>

<form action="category" method="post">
    <input type="hidden" name="categoryId" value="${category.categoryId}">

    Name: <input type="text" name="name" value="${category.name}">
    <button type="submit">Save</button>
</form>

<hr>

<h2>Category List</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Action</th>
    </tr>

    <c:forEach var="c" items="${list}">
        <tr>
            <td>${c.categoryId}</td>
            <td>${c.name}</td>
            <td>
                <a href="category?action=edit&id=${c.categoryId}">Edit</a>
                <a href="category?action=delete&id=${c.categoryId}">Delete</a>
            </td>
        </tr>
    </c:forEach>

</table>