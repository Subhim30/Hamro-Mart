<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hamromart.entity.User" %>
<%@ page import="com.hamromart.utils.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<%
    // Security check: Must be ADMIN
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        session.setAttribute("authError", "Access denied. Admin privileges required.");
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    List<Map<String, Object>> productsList = new ArrayList<Map<String, Object>>();
    List<Map<String, Object>> categoriesList = new ArrayList<Map<String, Object>>();

    Connection conn = null;
    PreparedStatement psProd = null;
    PreparedStatement psCat = null;
    ResultSet rsProd = null;
    ResultSet rsCat = null;

    try {
        conn = DatabaseConnection.getConnection();

        // Fetch products with category names
        String prodSql = "SELECT p.*, c.name AS category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.id " +
                "ORDER BY p.id DESC";

        psProd = conn.prepareStatement(prodSql);
        rsProd = psProd.executeQuery();

        while (rsProd.next()) {
            Map<String, Object> prod = new HashMap<String, Object>();

            prod.put("id", rsProd.getInt("id"));
            prod.put("name", rsProd.getString("name"));
            prod.put("description", rsProd.getString("description"));
            prod.put("price", rsProd.getDouble("price"));
            prod.put("stock", rsProd.getInt("stock"));
            prod.put("unit", rsProd.getString("unit"));
            prod.put("categoryId", rsProd.getInt("category_id"));
            prod.put("categoryName", rsProd.getString("category_name"));
            prod.put("imageUrl", rsProd.getString("image_url"));

            productsList.add(prod);
        }

        // Fetch categories
        String catSql = "SELECT * FROM categories ORDER BY name ASC";

        psCat = conn.prepareStatement(catSql);
        rsCat = psCat.executeQuery();

        while (rsCat.next()) {
            Map<String, Object> cat = new HashMap<String, Object>();

            cat.put("id", rsCat.getInt("id"));
            cat.put("name", rsCat.getString("name"));

            categoriesList.add(cat);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {

        if (rsProd != null) {
            try {
                rsProd.close();
            } catch (SQLException e) {
            }
        }

        if (rsCat != null) {
            try {
                rsCat.close();
            } catch (SQLException e) {
            }
        }

        if (psProd != null) {
            try {
                psProd.close();
            } catch (SQLException e) {
            }
        }

        if (psCat != null) {
            try {
                psCat.close();
            } catch (SQLException e) {
            }
        }

        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
            }
        }
    }

    request.setAttribute("products", productsList);
    request.setAttribute("categories", categoriesList);
%>

<jsp:include page="../layout/header.jsp"/>

<div class="admin-layout">

    <!-- Sidebar -->
    <aside class="sidebar">

        <div style="margin-bottom: 30px; text-align: center;">
            <div style="width: 70px; height: 70px; border-radius: 50%; background-color: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 32px; margin: 0 auto 12px auto; border: 2px solid var(--primary);">
                <i class="fas fa-user-shield"></i>
            </div>

            <h4 style="font-size: 16px;">
                <c:out value="${sessionScope.currentUser.name}"/>
            </h4>

            <span class="badge badge-admin" style="margin-top: 6px;">
                Administrator
            </span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                    <i class="fas fa-chart-pie"></i> Overview
                </a>
            </li>

            <li class="sidebar-item active">
                <a href="${pageContext.request.contextPath}/admin/products.jsp">
                    <i class="fas fa-boxes"></i> Products
                </a>
            </li>

            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp">
                    <i class="fas fa-shopping-bag"></i> Orders
                </a>
            </li>

            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/users.jsp">
                    <i class="fas fa-users"></i> Customers
                </a>
            </li>

            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/messages.jsp">
                    <i class="fas fa-envelope-open-text"></i> Messages
                </a>
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">

        <div class="admin-header">

            <div>
                <h2 style="font-size: 32px;">Manage Grocery Products</h2>

                <p style="color: var(--text-muted);">
                    Add, edit, update stocks, or remove catalog items
                </p>
            </div>

            <button class="btn btn-primary" onclick="openAddModal()">
                <i class="fas fa-plus"></i> Add New Product
            </button>

        </div>

        <!-- Alerts -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <c:out value="${sessionScope.success}"/>
            </div>

            <% session.removeAttribute("success"); %>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <c:out value="${sessionScope.error}"/>
            </div>

            <% session.removeAttribute("error"); %>
        </c:if>

        <!-- Product Table -->
        <div class="table-card">

            <div class="table-responsive">

                <table class="admin-table">

                    <thead>
                    <tr>
                        <th>Image</th>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Unit Price</th>
                        <th>Stock</th>
                        <th>Unit</th>
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="prod" items="${products}">

                        <tr>

                            <td>
                                <img
                                        src="<c:out value="${prod.imageUrl}"/>"
                                        alt="<c:out value="${prod.name}"/>"
                                        style="width: 50px; height: 50px; border-radius: 8px; object-fit: cover; border: 1px solid var(--border);">
                            </td>

                            <td style="font-weight: 700;">
                                <c:out value="${prod.name}"/>
                            </td>

                            <td>
                                <span class="badge badge-customer">
                                    <c:out value="${prod.categoryName}"/>
                                </span>
                            </td>

                            <td style="font-weight: 700; color: var(--primary);">
                                Rs. <c:out value="${prod.price}"/>
                            </td>

                            <td>

                                <c:choose>

                                    <c:when test="${prod.stock <= 10}">
                                        <span style="color: #ef4444; font-weight: 700;">
                                            <c:out value="${prod.stock}"/> (Low Stock!)
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span style="color: #059669; font-weight: 600;">
                                            <c:out value="${prod.stock}"/>
                                        </span>
                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <td>
                                <c:out value="${prod.unit}"/>
                            </td>

                            <td>

                                <div style="display: flex; gap: 8px;">

                                    <button
                                            class="btn btn-secondary"
                                            style="padding: 6px 12px; font-size: 12px; border-radius: 8px;"

                                            onclick="openEditModal({
                                                    id: '${prod.id}',
                                                    name: '${prod.name}',
                                                    description: '${prod.description}',
                                                    price: '${prod.price}',
                                                    stock: '${prod.stock}',
                                                    unit: '${prod.unit}',
                                                    categoryId: '${prod.categoryId}',
                                                    imageUrl: '${prod.imageUrl}'
                                                    })">

                                        <i class="fas fa-edit"></i> Edit
                                    </button>

                                    <a
                                            href="${pageContext.request.contextPath}/admin/products/delete?id=${prod.id}"
                                            class="btn btn-secondary"
                                            style="padding: 6px 12px; color: #ef4444; border-color: rgba(239, 68, 68, 0.2); font-size: 12px; border-radius: 8px;"
                                            onclick="return confirm('Are you sure you want to delete this product?');">

                                        <i class="fas fa-trash"></i> Delete
                                    </a>

                                </div>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </main>

</div>

<!-- Add / Edit Modal -->
<div id="product-modal" class="modal">

    <div class="modal-content">

        <div class="modal-header">

            <div>
                <h3 id="modal-title" style="font-size: 20px;">
                    Add New Product
                </h3>

                <!-- Validation Error Message -->
                <p id="validation-error" class="alert-error">

                </p>

            </div>

            <span class="modal-close" onclick="closeModal()">
        &times;
    </span>

        </div>

        <form id="product-form"
              action="${pageContext.request.contextPath}/admin/products/save"
              method="POST">

            <!-- Hidden Product ID -->
            <input type="hidden" id="prod-id" name="id">

            <div class="form-group">
                <label class="form-label" for="prod-name">Product Name</label>

                <input type="text"
                       id="prod-name"
                       name="name"
                       class="form-control"
                       placeholder="e.g. Fresh Red Apple"
                       required>
            </div>

            <div class="form-group">

                <label class="form-label" for="prod-desc">
                    Description
                </label>

                <textarea id="prod-desc"
                          name="description"
                          class="form-control"
                          rows="3"
                          placeholder="Sourced organic from..."></textarea>

            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">

                <div class="form-group">

                    <label class="form-label" for="prod-price">
                        Price (Rs.)
                    </label>

                    <input type="number"
                           step="0.01"
                           id="prod-price"
                           name="price"
                           class="form-control"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label" for="prod-stock">
                        Stock Limit
                    </label>

                    <input type="number"
                           id="prod-stock"
                           name="stock"
                           class="form-control"
                           required>

                </div>

            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">

                <div class="form-group">

                    <label class="form-label" for="prod-unit">
                        Unit
                    </label>

                    <input type="text"
                           id="prod-unit"
                           name="unit"
                           class="form-control"
                           placeholder="e.g. kg, dozen, ltr"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label" for="prod-cat">
                        Category
                    </label>

                    <select id="prod-cat"
                            name="categoryId"
                            class="form-control"
                            style="cursor: pointer;"
                            required>

                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">
                                <c:out value="${cat.name}"/>
                            </option>
                        </c:forEach>

                    </select>

                </div>

            </div>

            <div class="form-group">

                <label class="form-label" for="prod-img">
                    Image
                </label>

                <input type="file"
                       id="prod-img"
                       name="imageUrl"
                       class="form-control">

            </div>

            <button type="submit"
                    class="btn btn-primary"
                    style="width: 100%; padding: 12px; margin-top: 10px;">

                <i class="fas fa-save"></i> Save Product

            </button>

        </form>

    </div>

</div>

<script>

    const modal = document.getElementById('product-modal');
    const modalTitle = document.getElementById('modal-title');

    const productForm = document.getElementById('product-form');
    const errorText = document.getElementById('validation-error');

    // Open Add Modal
    function openAddModal() {

        modalTitle.textContent = "Add New Product";

        errorText.textContent = "";

        document.getElementById('prod-id').value = "";
        document.getElementById('prod-name').value = "";
        document.getElementById('prod-desc').value = "";
        document.getElementById('prod-price').value = "";
        document.getElementById('prod-stock').value = "";
        document.getElementById('prod-unit').value = "pcs";
        document.getElementById('prod-img').value = "";

        modal.style.display = "flex";
    }

    // Open Edit Modal
    function openEditModal(prod) {

        modalTitle.textContent = "Edit Product Specification";

        errorText.textContent = "";

        document.getElementById('prod-id').value = prod.id;
        document.getElementById('prod-name').value = prod.name;
        document.getElementById('prod-desc').value = prod.description;
        document.getElementById('prod-price').value = prod.price;
        document.getElementById('prod-stock').value = prod.stock;
        document.getElementById('prod-unit').value = prod.unit;
        document.getElementById('prod-cat').value = prod.categoryId;

        modal.style.display = "flex";
    }

    // Close Modal
    function closeModal() {
        modal.style.display = "none";
    }

    // Close on outside click
    window.onclick = function(event) {
        if (event.target === modal) {
            closeModal();
        }
    }

    // Validation
    productForm.addEventListener('submit', function(event) {

        const price = parseFloat(document.getElementById('prod-price').value);
        const stock = parseInt(document.getElementById('prod-stock').value);

        errorText.textContent = "";

        // Both invalid
        if (price < 1 && stock < 1) {

            event.preventDefault();

            errorText.textContent =
                "Price and Stock must be greater than 0.";

            return;
        }

        // Price invalid
        if (price < 1) {

            event.preventDefault();

            errorText.textContent =
                "Price must be greater than 0.";

            return;
        }

        // Stock invalid
        if (stock < 1) {

            event.preventDefault();

            errorText.textContent =
                "Stock must be greater than 0.";

            return;
        }
    });

</script>

<jsp:include page="../layout/footer.jsp"/>