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

    List<Map<String, Object>> messagesList = new ArrayList<Map<String, Object>>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();
        String msgSql = "SELECT * FROM messages ORDER BY id DESC";
        ps = conn.prepareStatement(msgSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> msg = new HashMap<String, Object>();
            msg.put("id", rs.getInt("id"));
            msg.put("name", rs.getString("name"));
            msg.put("email", rs.getString("email"));
            msg.put("subject", rs.getString("subject"));
            msg.put("message", rs.getString("message"));
            msg.put("createdAt", rs.getTimestamp("created_at"));
            messagesList.add(msg);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) { try { rs.close(); } catch (SQLException e) {} }
        if (ps != null) { try { ps.close(); } catch (SQLException e) {} }
        if (conn != null) { try { conn.close(); } catch (SQLException e) {} }
    }

    request.setAttribute("messages", messagesList);
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
            <li class="sidebar-item">
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
            <li class="sidebar-item active">
                <a href="${pageContext.request.contextPath}/admin/messages.jsp"><i class="fas fa-envelope-open-text"></i> Messages</a>
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        
        <div class="admin-header">
            <div>
                <h2 style="font-size: 32px;">Customer Inquiries</h2>
                <p style="color: var(--text-muted);">Read contact messages and user feedback logged in the store</p>
            </div>
        </div>

        <!-- Messages Table / List -->
        <c:choose>
            <c:when test="${empty messages}">
                <div style="text-align: center; padding: 60px 24px; background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius);">
                    <i class="fas fa-mail-bulk" style="font-size: 48px; color: var(--text-muted); margin-bottom: 20px;"></i>
                    <h3>No Messages Found</h3>
                    <p style="color: var(--text-muted); margin-top: 8px;">No customer feedback or inquiries have been received yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div style="display: flex; flex-direction: column; gap: 24px;">
                    <c:forEach var="msg" items="${messages}">
                        <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); display: flex; flex-direction: column; gap: 14px;">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 1px solid var(--border); padding-bottom: 14px;">
                                <div>
                                    <h4 style="font-size: 18px; color: var(--secondary);"><c:out value="${msg.subject}"/></h4>
                                    <span style="font-size: 13px; color: var(--text-muted); font-weight: 600; margin-top: 4px; display: block;">
                                        From: <strong style="color: var(--primary);"><c:out value="${msg.name}"/></strong> (<c:out value="${msg.email}"/>)
                                    </span>
                                </div>
                                <span style="font-size: 12px; color: var(--text-muted); font-weight: 600;"><i class="far fa-clock"></i> <c:out value="${msg.createdAt}"/></span>
                            </div>
                            <div>
                                <p style="line-height: 1.8; color: var(--text);"><c:out value="${msg.message}"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<jsp:include page="../layout/footer.jsp"/>
