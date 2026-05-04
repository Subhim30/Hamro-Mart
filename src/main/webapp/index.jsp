<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        /* HEADER */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: #fff;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #2e7d32;
        }

        nav a {
            margin: 0 15px;
            text-decoration: none;
            color: #333;
        }

        .search-box {
            padding: 8px;
            border-radius: 20px;
            border: 1px solid #ccc;
        }

        /* HERO */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #0b3d2e;
            color: #fff;
            padding: 60px;
            border-radius: 20px;
            margin: 20px;
        }

        .hero-text h1 {
            font-size: 40px;
        }

        .hero-text span {
            color: #a5d6a7;
        }

        .hero button {
            padding: 10px 20px;
            margin-right: 10px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        .btn-primary {
            background: #66bb6a;
            color: white;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid #fff;
            color: white;
        }

        .hero img {
            width: 300px;
        }

        /* CATEGORIES */
        .categories {
            display: flex;
            justify-content: space-around;
            margin: 20px;
        }

        .cat {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 100px;
        }

        /* BANNERS */
        .banners {
            display: flex;
            gap: 20px;
            margin: 20px;
        }

        .banner {
            flex: 1;
            padding: 20px;
            border-radius: 15px;
            color: #fff;
        }

        .banner.green { background: #2e7d32; }
        .banner.red { background: #d84315; }
        .banner.yellow { background: #fbc02d; color: #000; }

        /* PRODUCTS */
        .products {
            margin: 20px;
        }

        .products h2 {
            margin-bottom: 10px;
        }

        .product-grid {
            display: flex;
            gap: 20px;
        }

        .product {
            background: #fff;
            padding: 15px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
        }

        .product img {
            width: 100%;
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


    <div>

        <input class="search-box" type="text" placeholder="Search products">

        <div class="">
            <a href="">cart</a>
            <a href="/login.html">user</a>
        </div>
    </div>

</header>

<section class="hero">
    <div class="hero-text">
        <h1>Your Trusted Source for <span>Fresh & Healthy</span> Foods</h1>
        <p>Experience hassle-free shopping with quick delivery.</p>
        <button class="btn-primary">Shop Now</button>
        <button class="btn-outline">Explore Offers</button>
    </div>
    <img src="https://via.placeholder.com/300" alt="Hero Image">
</section>

<section class="categories">
    <div class="cat">Vegetables</div>
    <div class="cat">Dairy</div>
    <div class="cat">Breads</div>
    <div class="cat">Seafood</div>
    <div class="cat">Meat</div>
    <div class="cat">Fruits</div>
</section>

<section class="banners">
    <div class="banner green">
        <h3>Free Delivery</h3>
        <p>On orders over $50</p>
    </div>
    <div class="banner red">
        <h3>Ready To Check Out?</h3>
        <p>Fresh ingredients delivered fast</p>
    </div>
    <div class="banner yellow">
        <h3>40% OFF</h3>
        <p>Grab the offer now</p>
    </div>
</section>

<section class="products">
    <h2>Feature Products</h2>
    <div class="product-grid">
        <div class="product">
            <img src="https://via.placeholder.com/150">
            <p>Fresh Meat</p>
        </div>
        <div class="product">
            <img src="https://via.placeholder.com/150">
            <p>Onion</p>
        </div>
        <div class="product">
            <img src="https://via.placeholder.com/150">
            <p>Potato</p>
        </div>
        <div class="product">
            <img src="https://via.placeholder.com/150">
            <p>Ginger</p>
        </div>
    </div>
</section>

</body>
</html>