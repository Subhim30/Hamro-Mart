<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hamro-Mart</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f4f4;
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 40px;
    background: #fff;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    color: #d32f2f;
}

nav a {
    margin: 0 15px;
    text-decoration: none;
    color: #333;
}

nav a.active {
    color: red;
    font-weight: bold;
}

/* MAIN */
.container {
    display: flex;
    padding: 20px;
    gap: 20px;
}

/* SIDEBAR */
.sidebar {
    width: 250px;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
}

.sidebar h3 {
    margin-bottom: 10px;
}

.sidebar p {
    margin: 8px 0;
    color: #555;
}

.sidebar p.active {
    color: red;
    font-weight: bold;
}

.price-box {
    display: flex;
    gap: 10px;
}

.price-box input {
    width: 80px;
    padding: 5px;
}

.clear-btn {
    background: red;
    color: #fff;
    border: none;
    padding: 10px;
    margin-top: 10px;
    width: 100%;
    border-radius: 5px;
}

/* PRODUCTS */
.products {
    flex: 1;
}

/* TOP BAR */
.top-bar {
    background: #fff;
    padding: 10px 20px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

/* GRID */
.grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

/* CARD */
.card {
    background: #fff;
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
}

.card h4 {
    margin: 10px 0 5px;
}

.price {
    color: #555;
}

.btn {
    background: #e53935;
    color: white;
    border: none;
    padding: 10px;
    width: 100%;
    border-radius: 5px;
    margin-top: 10px;
    cursor: pointer;
}
</style>

</head>

<body>

<header>
    <div class="logo">Hamro-Mart</div>
    <nav>
        <a href="/index.html">Home</a>
        <a href="#">Shop</a>
        <a href="#">Contact</a>
    </nav>


    <div>

    <input class="search-box" type="text" placeholder="Search products">

     <div class="">
        <a href="">cart</a>
        <a href="">user</a>
    </div>
    </div>
   
</header>

<div class="container">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <h3>Categories</h3>
        <p>Starters</p>
        <p class="active">Main Course</p>
        <p>Deserts</p>
        <p>Beverages</p>

  
        <button class="clear-btn">Clear</button>
    </div>

    <!-- PRODUCTS -->
    <div class="products">

        <div class="grid">

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Kimbap</h4>
                <div class="price">300 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Ramen noodle</h4>
                <div class="price">500 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Cheese Burger</h4>
                <div class="price">300 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Fried Chicken</h4>
                <div class="price">400 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Chicken Fried Rice</h4>
                <div class="price">200 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>French Fries</h4>
                <div class="price">200 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Chicken Chow Mein</h4>
                <div class="price">150 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

            <div class="card">
                <img src="https://via.placeholder.com/200">
                <h4>Spaghetti Bolognese</h4>
                <div class="price">450 NPR</div>
                <button class="btn">Add to Cart</button>
            </div>

        </div>

    </div>

</div>

</body>
</html>