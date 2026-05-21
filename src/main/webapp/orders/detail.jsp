<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hamromart.entity.User" %>
<%@ page import="com.hamromart.utils.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        session.setAttribute("authError", "Please log in to view order details.");
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    String orderIdStr = request.getParameter("id");
    if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
        response.sendRedirect("list.jsp");
        return;
    }

    int orderId = Integer.parseInt(orderIdStr.trim());
    Map<String, Object> orderDetails = new HashMap<String, Object>();
    List<Map<String, Object>> orderItems = new ArrayList<Map<String, Object>>();

    // Query main Order (guarding with user_id for security!)
    String orderSql = "SELECT * FROM orders WHERE id = ? AND user_id = ?";
    String itemsSql = "SELECT oi.*, p.name AS product_name, p.image_url, p.unit FROM order_items oi " +
                      "JOIN products p ON oi.product_id = p.id " +
                      "WHERE oi.order_id = ?";

    Connection conn = null;
    PreparedStatement psOrder = null;
    ResultSet rsOrder = null;
    PreparedStatement psItems = null;
    ResultSet rsItems = null;

    try {
        conn = DatabaseConnection.getConnection();
        psOrder = conn.prepareStatement(orderSql);
        psOrder.setInt(1, orderId);
        psOrder.setInt(2, currentUser.getId());
        rsOrder = psOrder.executeQuery();
        if (rsOrder.next()) {
            orderDetails.put("id", rsOrder.getInt("id"));
            orderDetails.put("totalAmount", rsOrder.getDouble("total_amount"));
            orderDetails.put("status", rsOrder.getString("status"));
            orderDetails.put("paymentMethod", rsOrder.getString("payment_method"));
            orderDetails.put("address", rsOrder.getString("address"));
            orderDetails.put("phone", rsOrder.getString("phone"));
            orderDetails.put("createdAt", rsOrder.getTimestamp("created_at"));
        } else {
            // Order not found or not owned by user
            response.sendRedirect("list.jsp");
            return;
        }

        psItems = conn.prepareStatement(itemsSql);
        psItems.setInt(1, orderId);
        rsItems = psItems.executeQuery();
        while (rsItems.next()) {
            Map<String, Object> item = new HashMap<String, Object>();
            item.put("productName", rsItems.getString("product_name"));
            item.put("imageUrl", rsItems.getString("image_url"));
            item.put("unit", rsItems.getString("unit"));
            item.put("price", rsItems.getDouble("price"));
            item.put("quantity", rsItems.getInt("quantity"));
            item.put("subtotal", rsItems.getDouble("price") * rsItems.getInt("quantity"));
            orderItems.add(item);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rsItems != null) { try { rsItems.close(); } catch (Exception e) {} }
        if (psItems != null) { try { psItems.close(); } catch (Exception e) {} }
        if (rsOrder != null) { try { rsOrder.close(); } catch (Exception e) {} }
        if (psOrder != null) { try { psOrder.close(); } catch (Exception e) {} }
        if (conn != null) { try { conn.close(); } catch (Exception e) {} }
    }

    request.setAttribute("order", orderDetails);
    request.setAttribute("items", orderItems);
%>

<jsp:include page="../layout/header.jsp"/>

<section style="padding: 40px 0;">
    <div class="container" style="max-width: 900px;">
        
        <!-- Header -->
        <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 30px; border-bottom: 1px solid var(--border); padding-bottom: 20px;">
            <div>
                <a href="list.jsp" style="color: var(--primary); font-weight: 700; font-size: 14px;"><i class="fas fa-arrow-left"></i> Back to Orders</a>
                <h2 style="font-size: 32px; margin-top: 8px;">Order Details</h2>
                <p style="color: var(--text-muted); font-size: 14px; font-weight: 600; margin-top: 4px;">
                    Order Reference: <strong style="color: var(--primary);">HM-ORD-${order.id}</strong> | Placed on ${order.createdAt}
                </p>
            </div>
            <div>
                <span class="badge badge-${order.status.toLowerCase()}" style="font-size: 13px; padding: 6px 16px;">
                    Status: <c:out value="${order.status}"/>
                </span>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1.8fr 1fr; gap: 40px; align-items: flex-start;">
            
            <!-- Left: Order Items list -->
            <div class="cart-items-card" style="padding: 0 30px;">
                <c:forEach var="item" items="${items}">
                    <div class="cart-item" style="padding: 20px 0;">
                        <img src="<c:out value="${item.imageUrl}"/>" alt="<c:out value="${item.productName}"/>" class="cart-item-img">
                        <div class="cart-item-info">
                            <h4 class="cart-item-title"><c:out value="${item.productName}"/></h4>
                            <p class="cart-item-meta">Rs. <c:out value="${item.price}"/> / <c:out value="${item.unit}"/></p>
                        </div>
                        <div style="font-weight: 600; font-size: 14px; color: var(--text-muted); text-align: center; min-width: 80px;">
                            Qty: <c:out value="${item.quantity}"/>
                        </div>
                        <div style="text-align: right; min-width: 100px; font-weight: 700; font-size: 16px; color: var(--secondary);">
                            Rs. <c:out value="${item.subtotal}"/>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Right: Delivery Details & Total -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); display: flex; flex-direction: column; gap: 20px;">
                <h3 style="font-size: 18px; border-bottom: 1px solid var(--border); padding-bottom: 12px;">Delivery Specifications</h3>
                
                <div style="display: flex; flex-direction: column; gap: 12px; font-size: 14px; line-height: 1.6;">
                    <div>
                        <strong style="display: block; color: var(--text-muted); font-size: 12px; text-transform: uppercase;">Shipping Address:</strong>
                        <span><c:out value="${order.address}"/></span>
                    </div>
                    <div>
                        <strong style="display: block; color: var(--text-muted); font-size: 12px; text-transform: uppercase;">Contact Phone:</strong>
                        <span><c:out value="${order.phone}"/></span>
                    </div>
                    <div>
                        <strong style="display: block; color: var(--text-muted); font-size: 12px; text-transform: uppercase;">Payment Mode:</strong>
                        <span><c:out value="${order.paymentMethod}"/></span>
                    </div>
                </div>

                <div style="border-top: 1px dashed var(--border); padding-top: 20px; display: flex; justify-content: space-between; align-items: center; font-size: 20px; font-weight: 800; color: var(--secondary);">
                    <span>Total Bill:</span>
                    <span style="color: var(--primary);">Rs. ${order.totalAmount}</span>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
