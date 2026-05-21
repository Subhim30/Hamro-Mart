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

    // Stats variables
    double totalRevenue = 0.0;
    int totalOrders = 0;
    int totalUsers = 0;
    int totalProducts = 0;

    List<Map<String, Object>> categoriesList = new ArrayList<Map<String, Object>>();
    
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement ps = null;
    ResultSet rsRevenue = null;
    ResultSet rsOrders = null;
    ResultSet rsUsers = null;
    ResultSet rsProducts = null;
    ResultSet rsCategories = null;

    try {
        conn = DatabaseConnection.getConnection();
        stmt = conn.createStatement();

        // Revenue
        rsRevenue = stmt.executeQuery("SELECT SUM(total_amount) FROM orders WHERE status = 'DELIVERED'");
        if (rsRevenue.next()) {
            totalRevenue = rsRevenue.getDouble(1);
        }

        // Orders
        rsOrders = stmt.executeQuery("SELECT COUNT(*) FROM orders");
        if (rsOrders.next()) {
            totalOrders = rsOrders.getInt(1);
        }

        // Users
        rsUsers = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role = 'CUSTOMER'");
        if (rsUsers.next()) {
            totalUsers = rsUsers.getInt(1);
        }

        // Products
        rsProducts = stmt.executeQuery("SELECT COUNT(*) FROM products");
        if (rsProducts.next()) {
            totalProducts = rsProducts.getInt(1);
        }

        // Fetch Categories
        String catSql = "SELECT * FROM categories ORDER BY name ASC";
        ps = conn.prepareStatement(catSql);
        rsCategories = ps.executeQuery();
        while (rsCategories.next()) {
            Map<String, Object> cat = new HashMap<String, Object>();
            cat.put("id", rsCategories.getInt("id"));
            cat.put("name", rsCategories.getString("name"));
            cat.put("description", rsCategories.getString("description"));
            cat.put("icon", rsCategories.getString("icon"));
            categoriesList.add(cat);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rsRevenue != null) { try { rsRevenue.close(); } catch (SQLException e) {} }
        if (rsOrders != null) { try { rsOrders.close(); } catch (SQLException e) {} }
        if (rsUsers != null) { try { rsUsers.close(); } catch (SQLException e) {} }
        if (rsProducts != null) { try { rsProducts.close(); } catch (SQLException e) {} }
        if (rsCategories != null) { try { rsCategories.close(); } catch (SQLException e) {} }
        if (stmt != null) { try { stmt.close(); } catch (SQLException e) {} }
        if (ps != null) { try { ps.close(); } catch (SQLException e) {} }
        if (conn != null) { try { conn.close(); } catch (SQLException e) {} }
    }

    request.setAttribute("revenue", totalRevenue);
    request.setAttribute("orders", totalOrders);
    request.setAttribute("users", totalUsers);
    request.setAttribute("products", totalProducts);
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
            <h4 style="font-size: 16px;"><c:out value="${sessionScope.currentUser.name}"/></h4>
            <span class="badge badge-admin" style="margin-top: 6px;">Administrator</span>
        </div>
        
        <ul class="sidebar-menu">
            <li class="sidebar-item active">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-chart-pie"></i> Overview</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/products.jsp"><i class="fas fa-boxes"></i> Products</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp"><i class="fas fa-shopping-bag"></i> Orders</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/users.jsp"><i class="fas fa-users"></i> Customers</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/messages.jsp"><i class="fas fa-envelope-open-text"></i> Messages</a>
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        
        <!-- Welcome Header -->
        <div class="admin-header">
            <div>
                <h2 style="font-size: 32px;">Overview Dashboard</h2>
            </div>

        </div>

        <!-- Alert messages -->
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

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background-color: #d1fae5; color: #059669;"><i class="fas fa-wallet"></i></div>
                <div>
                    <div class="stat-value">Rs. ${revenue}</div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background-color: #e0f2fe; color: #0284c7;"><i class="fas fa-shopping-basket"></i></div>
                <div>
                    <div class="stat-value">${orders}</div>
                    <div class="stat-label">Total Orders</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background-color: #f3e8ff; color: #7c3aed;"><i class="fas fa-users"></i></div>
                <div>
                    <div class="stat-value">${users}</div>
                    <div class="stat-label">Active Customers</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background-color: #fee2e2; color: #dc2626;"><i class="fas fa-box"></i></div>
                <div>
                    <div class="stat-value">${products}</div>
                    <div class="stat-label">Grocery Items</div>
                </div>
            </div>
        </div>

        <!-- Category addition form & Active Categories list -->
        <div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 40px; margin-top: 40px;">
            <!-- Category List -->
            <div class="table-card" style="padding: 24px;">
                <h3 style="font-size: 20px; margin-bottom: 20px;"><i class="fas fa-tags" style="color: var(--primary);"></i> Active Categories</h3>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Icon</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>
                                        <div style="width: 32px; height: 32px; border-radius: 8px; background-color: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 14px;">
                                            <i class="fas ${cat.icon}"></i>
                                        </div>
                                    </td>
                                    <td style="font-weight: 700;"><c:out value="${cat.name}"/></td>
                                    <td style="color: var(--text-muted); font-size: 13px;"><c:out value="${cat.description}"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/categories/delete?id=${cat.id}" class="btn btn-secondary" style="padding: 6px 10px; color: #ef4444; border-color: rgba(239, 68, 68, 0.2); font-size: 12px;" onclick="return confirm('Are you sure you want to delete this category?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Add Category Form -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); height: fit-content;">
                <h3 style="font-size: 20px; margin-bottom: 20px;"><i class="fas fa-plus-circle" style="color: var(--primary);"></i> Add New Category</h3>
                
                <form action="${pageContext.request.contextPath}/admin/categories/add" method="POST">
                    <div class="form-group">
                        <label class="form-label" for="cat-name">Category Name</label>
                        <input type="text" id="cat-name" name="name" class="form-control" placeholder="e.g. Beverages, Fruits" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="cat-desc">Description</label>
                        <textarea id="cat-desc" name="description" class="form-control" rows="3" placeholder="Slight description..."></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="cat-icon">FontAwesome Icon Class</label>
                        <input type="text" id="cat-icon" name="icon" class="form-control" placeholder="e.g. fa-coffee, fa-carrot">
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px; margin-top: 10px;">
                        <i class="fas fa-plus"></i> Save Category
                    </button>
                </form>
            </div>
        </div>
    </main>
</div>

<jsp:include page="../layout/footer.jsp"/>
