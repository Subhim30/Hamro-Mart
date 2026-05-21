<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="layout/header.jsp"/>

<!-- Load Bootstrap Icons dynamically for the custom vector icon layout -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    /* Scoped container to avoid global pollution while layouting Bootstrap grids */
    .about-page-container {
        display: block;
        width: 100%;
        color: var(--text);
    }
    
    /* Grid system */
    .about-page-container .row {
        display: flex;
        flex-wrap: wrap;
        margin-right: -12px;
        margin-left: -12px;
    }
    
    .about-page-container .row > [class*="col-"] {
        flex-shrink: 0;
        width: 100%;
        max-width: 100%;
        padding-right: 12px;
        padding-left: 12px;
    }
    
    /* Gaps & gutters */
    .about-page-container .g-4 {
        margin-top: -12px;
    }
    .about-page-container .g-4 > [class*="col-"] {
        margin-top: 24px;
    }
    
    .about-page-container .g-5 {
        margin-top: -24px;
    }
    .about-page-container .g-5 > [class*="col-"] {
        margin-top: 48px;
    }
    
    /* Columns system */
    .about-page-container .col-6 {
        flex: 0 0 auto;
        width: 50%;
    }
    
    @media (min-width: 768px) {
        .about-page-container .col-md-6 {
            flex: 0 0 auto;
            width: 50%;
        }
        .about-page-container .col-md-4 {
            flex: 0 0 auto;
            width: 33.333333%;
        }
        .about-page-container .col-md-3 {
            flex: 0 0 auto;
            width: 25%;
        }
    }
    
    @media (min-width: 992px) {
        .about-page-container .col-lg {
            flex: 1 0 0%;
            width: auto;
        }
    }
    
    /* Utility Helpers */
    .about-page-container .align-items-center { align-items: center; }
    .about-page-container .text-center { text-align: center; }
    .about-page-container .py-5 { padding-top: 48px; padding-bottom: 48px; }
    .about-page-container .py-4 { padding-top: 32px; padding-bottom: 32px; }
    .about-page-container .py-3 { padding-top: 24px; padding-bottom: 24px; }
    .about-page-container .px-4 { padding-left: 32px; padding-right: 32px; }
    .about-page-container .px-3 { padding-left: 20px; padding-right: 20px; }
    .about-page-container .py-2 { padding-top: 8px; padding-bottom: 8px; }
    .about-page-container .mb-5 { margin-bottom: 48px; }
    .about-page-container .mb-4 { margin-bottom: 32px; }
    .about-page-container .mb-3 { margin-bottom: 24px; }
    .about-page-container .mb-2 { margin-bottom: 12px; }
    .about-page-container .mb-1 { margin-bottom: 6px; }
    .about-page-container .mb-0 { margin-bottom: 0; }
    .about-page-container .d-block { display: block; }
    .about-page-container .d-flex { display: flex; }
    .about-page-container .justify-content-center { justify-content: center; }
    .about-page-container .gap-3 { gap: 16px; }
    .about-page-container .h-100 { height: 100%; }
    .about-page-container .rounded-4 { border-radius: 16px; }
    .about-page-container .rounded-circle { border-radius: 50%; }
    .about-page-container .img-fluid { max-width: 100%; height: auto; }
    .about-page-container .opacity-75 { opacity: 0.75; }
    .about-page-container .fw-bold { font-weight: 700; }
    .about-page-container .lead { font-size: 18px; line-height: 1.6; }
    
    /* Card design matched to premium theme variables */
    .about-page-container .card {
        background-color: var(--card-bg);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 24px;
        transition: var(--transition);
        box-shadow: var(--shadow-sm);
    }
    .about-page-container .card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-md);
    }
    .about-page-container .border-0 { border: 0 !important; }
    .about-page-container .shadow-sm { box-shadow: var(--shadow-sm); }
    .about-page-container .shadow { box-shadow: var(--shadow-lg); }
    
    /* Badges adapted to HSL primary scheme */
    .about-page-container .badge {
        display: inline-block;
        padding: 6px 12px;
        font-size: 12px;
        font-weight: 700;
        border-radius: 20px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .about-page-container .bg-success.bg-opacity-10 {
        background-color: hsla(var(--primary-hsl), 0.1) !important;
        color: var(--primary) !important;
    }
    .about-page-container .bg-warning.bg-opacity-10 {
        background-color: rgba(245, 158, 11, 0.1) !important;
        color: var(--accent) !important;
    }
    .about-page-container .bg-danger.bg-opacity-10 {
        background-color: rgba(239, 68, 68, 0.1) !important;
        color: #ef4444 !important;
    }
    .about-page-container .bg-primary.bg-opacity-10 {
        background-color: rgba(59, 130, 246, 0.1) !important;
        color: #3b82f6 !important;
    }
    .about-page-container .bg-info.bg-opacity-10 {
        background-color: rgba(6, 182, 212, 0.1) !important;
        color: #06b6d4 !important;
    }
    .about-page-container .bg-purple.bg-opacity-10 {
        background-color: rgba(142, 36, 170, 0.1) !important;
        color: #8e24aa !important;
    }
    
    /* Colors */
    .about-page-container .text-success { color: var(--primary) !important; }
    .about-page-container .text-secondary { color: var(--text-muted) !important; }
    .about-page-container .text-muted { color: var(--text-muted) !important; }
    .about-page-container .text-warning { color: var(--accent) !important; }
    .about-page-container .text-danger { color: #ef4444 !important; }
    .about-page-container .text-primary { color: #3b82f6 !important; }
    .about-page-container .text-info { color: #06b6d4 !important; }
    .about-page-container .text-white { color: #ffffff !important; }
    
    /* Typography sizing */
    .about-page-container .display-3 { font-size: 42px; font-weight: 800; }
    .about-page-container .display-5 { font-size: 32px; font-weight: 800; }
    .about-page-container .fs-1 { font-size: 36px; }
    .about-page-container .fs-2 { font-size: 28px; }
    
    /* Custom buttons styled for theme variables */
    .about-page-container .btn-success {
        background-color: var(--primary);
        color: #ffffff;
        box-shadow: 0 4px 14px 0 rgba(16, 185, 129, 0.4);
    }
    .about-page-container .btn-success:hover {
        background-color: var(--primary-hover);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px 0 rgba(16, 185, 129, 0.6);
    }
    
    .about-page-container .btn-outline-success {
        background-color: transparent;
        border: 2px solid var(--primary);
        color: var(--primary);
    }
    .about-page-container .btn-outline-success:hover {
        background-color: var(--primary-light);
        transform: translateY(-2px);
    }
</style>

<div class="about-page-container">
    <!-- Hero banner -->
    <div style="background: linear-gradient(135deg, #1b5e20 0%, #2e7d32 60%, #388e3c 100%);" class="text-white py-5">
        <div class="container py-3 text-center">
            <i class="bi bi-basket3-fill display-3 mb-3 d-block"></i>
            <h1 class="fw-bold display-5 mb-2">About HarmoMart</h1>
            <p class="lead mb-0 opacity-75">Fresh groceries, delivered with care — right to your door.</p>
        </div>
    </div>

    <div class="container py-5">

        <!-- Our Story -->
        <div class="row align-items-center g-5 mb-5">
            <div class="col-md-6">
                <span class="badge bg-success bg-opacity-10 text-success mb-2">Our Story</span>
                <h2 class="fw-bold mb-3">We started with a simple idea</h2>
                <p class="text-secondary mb-3">
                    HarmoMart was born out of a desire to make grocery shopping effortless and affordable.
                    Founded in 2024, we set out to bridge the gap between local farmers and busy households —
                    delivering the freshest produce without the hassle of crowded markets.
                </p>
                <p class="text-secondary mb-0">
                    Today, we proudly serve thousands of customers, offering a wide range of fruits,
                    vegetables, dairy, snacks, and household essentials — all at competitive prices
                    with guaranteed freshness.
                </p>
            </div>
            <div class="col-md-6 text-center">
                <img src="https://images.unsplash.com/photo-1542838132-92c53300491e?w=600&q=80"
                     alt="Fresh groceries" class="img-fluid rounded-4 shadow"
                     style="max-height:320px; object-fit:cover; width:100%;"
                     onerror="this.src='https://placehold.co/600x320?text=HarmoMart'">
            </div>
        </div>

        <!-- Stats row -->
        <div class="row g-4 text-center mb-5">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm h-100 py-4">
                    <div class="display-5 fw-bold text-success mb-1">10K+</div>
                    <div class="text-muted small">Happy Customers</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm h-100 py-4">
                    <div class="display-5 fw-bold text-success mb-1">500+</div>
                    <div class="text-muted small">Products Listed</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm h-100 py-4">
                    <div class="display-5 fw-bold text-success mb-1">50+</div>
                    <div class="text-muted small">Local Farmers</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm h-100 py-4">
                    <div class="display-5 fw-bold text-success mb-1">24h</div>
                    <div class="text-muted small">Delivery Promise</div>
                </div>
            </div>
        </div>

        <!-- Values -->
        <div class="text-center mb-4">
            <span class="badge bg-success bg-opacity-10 text-success mb-2">Why Choose Us</span>
            <h2 class="fw-bold">Our Core Values</h2>
        </div>
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-leaf-fill"></i></div>
                    <h5 class="fw-bold mb-2">Farm Fresh</h5>
                    <p class="text-muted small mb-0">We source directly from local farms to ensure every product reaches you at peak freshness — no middlemen, no compromises.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-shield-check-fill"></i></div>
                    <h5 class="fw-bold mb-2">Quality Guaranteed</h5>
                    <p class="text-muted small mb-0">Every item is inspected before packing. Not happy? We'll replace it or refund — no questions asked.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-truck-front-fill"></i></div>
                    <h5 class="fw-bold mb-2">Fast Delivery</h5>
                    <p class="text-muted small mb-0">Order before noon and get same-day delivery. Our fleet of refrigerated vehicles keeps produce fresh during transit.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-currency-rupee"></i></div>
                    <h5 class="fw-bold mb-2">Best Prices</h5>
                    <p class="text-muted small mb-0">By cutting out the supply chain middlemen, we pass the savings directly to you with competitive everyday prices.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-recycle"></i></div>
                    <h5 class="fw-bold mb-2">Eco Friendly</h5>
                    <p class="text-muted small mb-0">We use biodegradable packaging and run an electric delivery fleet — because we care about the planet as much as your pantry.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4 text-center">
                    <div class="text-success fs-1 mb-3"><i class="bi bi-headset"></i></div>
                    <h5 class="fw-bold mb-2">24/7 Support</h5>
                    <p class="text-muted small mb-0">Our friendly support team is always a message away — whether it's a missing item or a general question, we've got you covered.</p>
                </div>
            </div>
        </div>

        <!-- Team -->
        <div class="text-center mb-4">
            <span class="badge bg-success bg-opacity-10 text-success mb-2">The Team</span>
            <h2 class="fw-bold">Meet the People Behind HarmoMart</h2>
            <p class="text-muted">Five focused contributors, one great product.</p>
        </div>
        <div class="row g-4 justify-content-center mb-5">

            <!-- Rubina -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-success bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-database-fill text-success fs-2"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Rubina</h6>
                    <span class="badge bg-success bg-opacity-10 text-success small mb-2">Data &amp; Schema</span>
                    <p class="text-muted" style="font-size:.78rem;">MySQL / Java Models</p>
                </div>
            </div>

            <!-- Kumari -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-warning bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-shield-lock-fill text-warning fs-2"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Kumari</h6>
                    <span class="badge bg-warning bg-opacity-10 text-warning small mb-2">Security &amp; Flow</span>
                    <p class="text-muted" style="font-size:.78rem;">Servlets / Filters</p>
                </div>
            </div>

            <!-- Sushant -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-danger bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-gear-fill text-danger fs-2"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Sushant</h6>
                    <span class="badge bg-danger bg-opacity-10 text-danger small mb-2">Admin Operations</span>
                    <p class="text-muted" style="font-size:.78rem;">CRUD / Business Logic</p>
                </div>
            </div>

            <!-- Subhim -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-primary bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-palette-fill text-primary fs-2"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Subhim</h6>
                    <span class="badge bg-primary bg-opacity-10 text-primary small mb-2">Presentation</span>
                    <p class="text-muted" style="font-size:.78rem;">JSP / CSS Layouts</p>
                </div>
            </div>

            <!-- Pranjal -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-info bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-check2-circle text-info fs-2"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Pranjal</h6>
                    <span class="badge bg-info bg-opacity-10 text-info small mb-2">Interaction &amp; QA</span>
                    <p class="text-muted" style="font-size:.78rem;">User Features / Testing</p>
                </div>
            </div>

            <!-- Sushank -->
            <div class="col-6 col-md-4 col-lg text-center">
                <div class="card border-0 shadow-sm h-100 py-4 px-3">
                    <div class="rounded-circle bg-purple bg-opacity-10 mx-auto mb-3 d-flex align-items-center justify-content-center"
                         style="width:72px;height:72px;">
                        <i class="bi bi-headset text-purple fs-2" style="color:#8e24aa;"></i>
                    </div>
                    <h6 class="fw-bold mb-1">Sushank</h6>
                    <span class="badge bg-purple bg-opacity-10 text-purple small mb-2" style="color:#8e24aa;">Customer Support</span>
                    <p class="text-muted" style="font-size:.78rem;">User Help / Feedback</p>
                </div>
            </div>

        </div>

        <!-- CTA -->
        <div class="card border-0 shadow-sm text-center p-5"
             style="background: linear-gradient(135deg, var(--primary-light), rgba(255,255,255,0));">
            <h3 class="fw-bold mb-2">Ready to shop fresh?</h3>
            <p class="text-muted mb-4">Browse our full catalogue of farm-fresh groceries and household essentials.</p>
            <div class="d-flex gap-3 justify-content-center">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-success px-4" id="about-shop-now-btn">
                    <i class="bi bi-grid me-1"></i>Shop Now
                </a>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-outline-success px-4" id="about-contact-btn">
                    <i class="bi bi-envelope me-1"></i>Get in Touch
                </a>
            </div>
        </div>

    </div>
</div>

<jsp:include page="layout/footer.jsp"/>
