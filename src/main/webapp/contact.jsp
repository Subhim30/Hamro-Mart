<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="layout/header.jsp"/>

<section style="padding: 60px 0; background: linear-gradient(135deg, var(--primary-light) 0%, rgba(255,255,255,0) 100%);">
    <div class="container" style="text-align: center; max-width: 800px;">
        <span style="color: var(--primary); font-weight: 700; text-transform: uppercase; font-size: 14px; letter-spacing: 0.5px;">Contact Us</span>
        <h1 style="font-size: 44px; margin: 12px 0 20px 0;">We'd Love To Hear From You</h1>
        <p style="color: var(--text-muted); font-size: 16px;">
            Have questions about our sourcing, bulk orders, delivery timelines, or partnership opportunities? Reach out using the details below or drop us a quick query.
        </p>
    </div>
</section>

<section style="padding: 60px 0;">
    <div class="container" style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 48px;">
        <!-- Contact Details -->
        <div style="display: flex; flex-direction: column; gap: 24px;">
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); display: flex; gap: 20px; align-items: flex-start;">
                <div style="background-color: var(--primary-light); color: var(--primary); width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div>
                    <h4 style="font-size: 16px; margin-bottom: 4px;">Main Office</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">Chakupat, Lalitpur, Nepal</p>
                </div>
            </div>
            
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); display: flex; gap: 20px; align-items: flex-start;">
                <div style="background-color: var(--primary-light); color: var(--primary); width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div>
                    <h4 style="font-size: 16px; margin-bottom: 4px;">Helpline</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">+977-9801234567, 01-5544321</p>
                </div>
            </div>
            
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-sm); display: flex; gap: 20px; align-items: flex-start;">
                <div style="background-color: var(--primary-light); color: var(--primary); width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-envelope"></i>
                </div>
                <div>
                    <h4 style="font-size: 16px; margin-bottom: 4px;">Email Contacts</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">support@hamromart.com, info@hamromart.com</p>
                </div>
            </div>
        </div>

        <!-- Contact Form -->
        <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 40px; box-shadow: var(--shadow-md);">
            <h3 style="font-size: 24px; margin-bottom: 24px;">Send A Message</h3>
            
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

            <form action="${pageContext.request.contextPath}/contact/submit" method="POST">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label" for="contact-name">Your Name</label>
                        <input type="text" id="contact-name" name="name" class="form-control" placeholder="e.g. John Doe" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label" for="contact-email">Email Address</label>
                        <input type="email" id="contact-email" name="email" class="form-control" placeholder="e.g. john@gmail.com" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="contact-subject">Subject</label>
                    <input type="text" id="contact-subject" name="subject" class="form-control" placeholder="e.g. Wholesale inquiry, Delivery issues" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="contact-message">Message Details</label>
                    <textarea id="contact-message" name="message" class="form-control" rows="5" placeholder="Write your feedback or queries here..." required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 14px;">
                    <i class="fas fa-paper-plane"></i> Submit Feedback
                </button>
            </form>
        </div>
    </div>
</section>

<jsp:include page="layout/footer.jsp"/>
