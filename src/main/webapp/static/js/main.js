// Hamromart Grocery Client Utilities

document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initCart();
});

// Theme Management (Dark / Light Mode)
function initTheme() {
    const themeToggle = document.getElementById('theme-toggle');
    if (!themeToggle) return;

    // Check saved theme
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    updateThemeIcon(savedTheme);

    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeIcon(newTheme);
    });
}

function updateThemeIcon(theme) {
    const themeIcon = document.querySelector('#theme-toggle i');
    if (!themeIcon) return;
    
    if (theme === 'dark') {
        themeIcon.className = 'fas fa-sun';
    } else {
        themeIcon.className = 'fas fa-moon';
    }
}

// Shopping Cart Management (LocalStorage-based)
let cart = [];

function initCart() {
    // Load cart items
    const savedCart = localStorage.getItem('hamromart_cart');
    if (savedCart) {
        try {
            cart = JSON.parse(savedCart);
        } catch (e) {
            cart = [];
        }
    }
    // Check if user is logged in
    const isLoggedIn =
        document.body.getAttribute('data-logged-in') === 'true';

    updateCartBadge();
    
    // Bind Add to Cart buttons
    const addButtons = document.querySelectorAll('.btn-add-to-cart');
    addButtons.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const id = parseInt(btn.getAttribute('data-id'));
            const name = btn.getAttribute('data-name');
            const price = parseFloat(btn.getAttribute('data-price'));
            const image = btn.getAttribute('data-image');
            const unit = btn.getAttribute('data-unit');
            
            addToCart(id, name, price, image, unit);
        });
    });

    // Populate Cart view if on the cart page
    if (document.getElementById('cart-items-container')) {
        renderCartPage();
    }
}

function addToCart(id, name, price, image, unit) {

    // Prevent guest users
    if (!isLoggedIn) {

        alert("Please login first to add items to cart!");

        // Redirect to login page
        window.location.href = "/Hamro-Mart/auth/login.jsp";

        return;
    }

    const existing = cart.find(item => item.id === id);

    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({
            id,
            name,
            price,
            image,
            unit,
            quantity: 1
        });
    }

    saveCart();
    updateCartBadge();
    showToast(`${name} added to cart!`);
}

function updateCartBadge() {
    const badges = document.querySelectorAll('.cart-badge');
    const totalCount = cart.reduce((sum, item) => sum + item.quantity, 0);
    
    badges.forEach(badge => {
        badge.textContent = totalCount;
        if (totalCount === 0) {
            badge.style.display = 'none';
        } else {
            badge.style.display = 'flex';
        }
    });
}

function saveCart() {
    localStorage.setItem('hamromart_cart', JSON.stringify(cart));
}

// Render Cart Page
function renderCartPage() {
    const container = document.getElementById('cart-items-container');
    const summaryContainer = document.getElementById('cart-summary-container');
    
    if (!container || !summaryContainer) return;
    
    if (cart.length === 0) {
        container.innerHTML = `
            <div style="text-align: center; padding: 40px;">
                <i class="fas fa-shopping-basket" style="font-size: 64px; color: var(--text-muted); margin-bottom: 20px;"></i>
                <h3>Your cart is empty</h3>
                <p style="color: var(--text-muted); margin-bottom: 24px;">Add some fresh items to get started!</p>
                <a href="products" class="btn btn-primary">Shop Now</a>
            </div>
        `;
        summaryContainer.style.display = 'none';
        return;
    }
    
    summaryContainer.style.display = 'block';
    container.innerHTML = '';
    
    let subtotal = 0;
    
    cart.forEach((item, index) => {
        const itemTotal = item.price * item.quantity;
        subtotal += itemTotal;
        
        const itemHtml = `
            <div class="cart-item">
                <img src="${item.image}" alt="${item.name}" class="cart-item-img">
                <div class="cart-item-info">
                    <h4 class="cart-item-title">${item.name}</h4>
                    <p class="cart-item-meta">Rs. ${item.price} / ${item.unit}</p>
                </div>
                <div class="quantity-control">
                    <button class="quantity-btn dec-btn" onclick="updateQty(${item.id}, -1)">-</button>
                    <span class="quantity-value">${item.quantity}</span>
                    <button class="quantity-btn inc-btn" onclick="updateQty(${item.id}, 1)">+</button>
                </div>
                <div style="text-align: right; min-width: 100px;">
                    <p style="font-weight: 700; font-size: 16px;">Rs. ${itemTotal.toFixed(2)}</p>
                    <a href="#" style="color: #ef4444; font-size: 13px; font-weight: 600;" onclick="removeCartItem(event, ${item.id})">Remove</a>
                </div>
            </div>
        `;
        container.insertAdjacentHTML('beforeend', itemHtml);
    });
    
    // Summary calculations
    const delivery = subtotal > 1000 ? 0 : 100;
    const total = subtotal + delivery;
    
    document.getElementById('summary-subtotal').textContent = `Rs. ${subtotal.toFixed(2)}`;
    document.getElementById('summary-delivery').textContent = delivery === 0 ? 'FREE' : `Rs. ${delivery.toFixed(2)}`;
    document.getElementById('summary-total').textContent = `Rs. ${total.toFixed(2)}`;
    
    // Prepare checkout fields
    const checkoutItemsInput = document.getElementById('checkout-items-json');
    const checkoutTotalInput = document.getElementById('checkout-total');
    if (checkoutItemsInput && checkoutTotalInput) {
        checkoutItemsInput.value = JSON.stringify(cart);
        checkoutTotalInput.value = total.toFixed(2);
    }
}

window.updateQty = function(id, delta) {
    const item = cart.find(item => item.id === id);
    if (!item) return;
    
    item.quantity += delta;
    if (item.quantity <= 0) {
        cart = cart.filter(item => item.id !== id);
    }
    
    saveCart();
    updateCartBadge();
    renderCartPage();
};

window.removeCartItem = function(e, id) {
    e.preventDefault();
    cart = cart.filter(item => item.id !== id);
    saveCart();
    updateCartBadge();
    renderCartPage();
};

window.clearCart = function() {
    cart = [];
    saveCart();
    updateCartBadge();
    renderCartPage();
};

// Toast Notifications
function showToast(message) {
    let container = document.getElementById('toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        container.style.position = 'fixed';
        container.style.bottom = '24px';
        container.style.right = '24px';
        container.style.zIndex = '10000';
        container.style.display = 'flex';
        container.style.flexDirection = 'column';
        container.style.gap = '8px';
        document.body.appendChild(container);
    }
    
    const toast = document.createElement('div');
    toast.style.backgroundColor = 'var(--secondary)';
    toast.style.color = '#ffffff';
    toast.style.padding = '14px 24px';
    toast.style.borderRadius = '8px';
    toast.style.fontSize = '14px';
    toast.style.fontWeight = '600';
    toast.style.boxShadow = 'var(--shadow-lg)';
    toast.style.display = 'flex';
    toast.style.alignItems = 'center';
    toast.style.gap = '10px';
    toast.style.transform = 'translateY(100px)';
    toast.style.opacity = '0';
    toast.style.transition = 'all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
    
    toast.innerHTML = `<i class="fas fa-check-circle" style="color: var(--primary);"></i> ${message}`;
    container.appendChild(toast);
    
    // Trigger transition
    setTimeout(() => {
        toast.style.transform = 'translateY(0)';
        toast.style.opacity = '1';
    }, 10);
    
    // Remove toast
    setTimeout(() => {
        toast.style.transform = 'translateY(100px)';
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}
