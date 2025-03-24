<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Product" %>
<%@page import="data.ProductDAO" %>

<% 
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
    if (products == null) {
        products = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --black: #000000;
            --white: #ffffff;
            --off-white: #f5f5f5;
            --light-gray: #e0e0e0;
            --medium-gray: #767676;
            --dark-gray: #333333;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--white);
            color: var(--black);
            min-height: 100vh;
            font-weight: 300;
            letter-spacing: 0.02em;
        }
        
        /* Brand statement section */
        .brand-statement {
            text-align: center;
            padding: 5rem 1rem;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .brand-statement h1 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            letter-spacing: 0.05em;
        }
        
        .brand-statement p {
            font-size: 1rem;
            line-height: 1.8;
            color: var(--medium-gray);
            margin-bottom: 2rem;
        }
        
        .divider {
            width: 50px;
            height: 1px;
            background-color: var(--black);
            margin: 0 auto 2rem;
        }
        
        /* Category navigation */
        .category-nav {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            max-width: 1400px;
            margin: 0 auto 5rem;
            padding: 0 2rem;
        }
        
        .category-nav-item {
            position: relative;
            overflow: hidden;
            aspect-ratio: 1/1;
        }
        
        .category-nav-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }
        
        .category-nav-item:hover img {
            transform: scale(1.05);
        }
        
        .category-nav-item .overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: rgba(0, 0, 0, 0.3);
            padding: 1.5rem;
            color: var(--white);
            text-align: center;
        }
        
        .category-nav-item h3 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 1.5rem;
            letter-spacing: 0.05em;
            margin-bottom: 0.5rem;
        }
        
        .category-nav-item a {
            color: var(--white);
            text-decoration: none;
            font-size: 0.8rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
        }
        
        .category-nav-item a::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -4px;
            left: 0;
            background-color: var(--white);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .category-nav-item a:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        /* Featured collection */
        .featured-collection {
            background-color: var(--off-white);
            padding: 5rem 2rem;
            margin-bottom: 5rem;
        }
        
        .featured-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 2rem;
            text-align: center;
            margin-bottom: 3rem;
            letter-spacing: 0.05em;
        }
        
        .featured-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* Category title and product grid */
        .category-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 1.8rem;
            color: var(--black);
            text-align: center;
            letter-spacing: 0.05em;
            margin: 4rem 0 3rem;
            text-transform: uppercase;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 5rem;
        }
        
        .product-card {
            display: flex;
            flex-direction: column;
            position: relative;
            background: transparent;
            border: none;
            overflow: hidden;
        }
        
        .product-image-container {
            position: relative;
            overflow: hidden;
            aspect-ratio: 3/4;
            margin-bottom: 1rem;
            background-color: var(--off-white);
        }
        
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 1s ease;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.03);
        }
        
        .product-info {
            padding: 0.5rem 0;
            text-align: center;
        }
        
        .product-name {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: var(--black);
            letter-spacing: 0.05em;
        }
        
        .product-price {
            font-family: 'Montserrat', sans-serif;
            font-weight: 400;
            font-size: 0.9rem;
            color: var(--medium-gray);
            margin-bottom: 0.5rem;
        }
        
        .product-color {
            font-size: 0.8rem;
            color: var(--medium-gray);
            font-weight: 300;
            margin-bottom: 1rem;
        }
        
        .btn-view {
            font-family: 'Montserrat', sans-serif;
            background-color: transparent;
            border: none;
            color: var(--black);
            font-size: 0.8rem;
            font-weight: 400;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            padding: 0;
            margin: 0 auto;
            display: inline-block;
            position: relative;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-view::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -4px;
            left: 0;
            background-color: var(--black);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .btn-view:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        .category-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .empty-category {
            text-align: center;
            padding: 5rem 0;
        }
        
        .empty-category p {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.2rem;
            color: var(--medium-gray);
            font-style: italic;
        }
        
        .category-divider {
            width: 100%;
            height: 1px;
            background-color: var(--light-gray);
            margin: 5rem 0;
        }
        
        @media (max-width: 992px) {
            .category-nav {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .brand-statement {
                padding: 4rem 1rem;
            }
            
            .brand-statement h1 {
                font-size: 2rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 1.5rem;
            }
            
            .category-title {
                font-size: 1.5rem;
                margin: 3rem 0 2rem;
            }
            
            .category-container {
                padding: 0 1rem;
            }
            
            .featured-collection {
                padding: 3rem 1rem;
            }
            
            .brand-statement {
                padding: 3rem 1rem;
            }
            
            .brand-statement h1 {
                font-size: 1.8rem;
            }
        }
        .slider-container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  overflow: hidden;
  position: relative;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.slider {
  display: flex;
  width: 300%; /* 3 images */
  animation: slide 15s infinite ease-in-out;
}

.slider img {
  width: 33.333%; /* Each image takes up 1/3 of the slider width */
  height: auto;
  object-fit: cover;
  flex-shrink: 0;
}

@keyframes slide {
  0%,
  30% {
    transform: translateX(0);
  }
  33%,
  63% {
    transform: translateX(-33.333%);
  }
  66%,
  96% {
    transform: translateX(-66.666%);
  }
  100% {
    transform: translateX(0);
  }
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .slider-container {
    border-radius: 6px;
  }
}

/* Pause animation on hover */
.slider-container:hover .slider {
  animation-play-state: paused;
}


    </style>
</head>
<body>
    <!-- Header and Slider would be here (from your header.jsp) -->
    <div class="slider-container">
    <div class="slider">
        <img src="images/nen12.png" alt="Slider Image">
        <img src="images/nen13.png" alt="Slider Image">
        <img src="images/nen12.png" alt="Slider Image">

    </div>
</div>
    <!-- Brand Statement Section -->
    <section class="brand-statement">
        <h1>Timeless Elegance, Modern Expression</h1>
                <h1>DAVADOI.CLO</h1>

        <div class="divider"></div>
        <p>
            Davadoi được sinh ra với một tầm nhìn: không chỉ là thời trang, mà còn 
            là biểu tượng của sự bền bỉ và kiên trì. Chúng tôi bắt đầu với đam mê và
            không ngừng đổi mới để mang đến những sản phẩm kết hợp giữa
            phong cách và sự linh hoạt, phù hợp với mọi thử thách của cuộc sống.
        </p>
    </section>
    
    <!-- Category Navigation -->
    <section class="category-nav">
        <div class="category-nav-item">
            <a href="index.jsp#tops-section">
                <img src="images/category-tops.jpg" alt="Tops Category" onerror="this.src='images/p1.png'">
                <div class="overlay">
                    <h3>Tops</h3>
                    <a href="index.jsp#tops-section"></a>
                </div>
            </a>
        </div>
        <div class="category-nav-item">
            <a href="index.jsp#bottoms-section">
                <img src="images/category-bottoms.jpg" alt="Bottoms Category" onerror="this.src='images/p2.png'">
                <div class="overlay">
                    <h3>Bottoms</h3>
                    <a href="index.jsp#bottoms-section"></a>
                </div>
            </a>
        </div>
        <div class="category-nav-item">
            <a href="index.jsp#jew-section">
                <img src="images/category-jewelry.jpg" alt="Jewelry Category" onerror="this.src='images/p3.png'">
                <div class="overlay">
                    <h3>Jewelry</h3>
                    <a href="index.jsp#jew-section"></a>
                </div>
            </a>
        </div>
        <div class="category-nav-item">
            <a href="index.jsp#acc-section">
                <img src="images/category-accessories.jpg" alt="Accessories Category" onerror="this.src='images/p4.png'">
                <div class="overlay">
                    <h3>Accessories</h3>
                    <a href="index.jsp#acc-section"></a>
                </div>
            </a>
        </div>
    </section>
    
    <!-- Featured Collection -->
    <section class="featured-collection">
        <h2 class="featured-title">Bộ Sưu Tập Nổi Bật</h2>
        <div class="featured-grid">
            <% 
            // Display 3 random products as featured items
            int featuredCount = 0;
            List<Product> shuffledProducts = new ArrayList<>(products);
            java.util.Collections.shuffle(shuffledProducts);
            
            for (Product p : shuffledProducts) {
                if (featuredCount >= 4) break;
                featuredCount++;
            %>
                <div class="product-card">
                    <a href="productdetails.jsp?id=<%= p.getProductID() %>" class="text-decoration-none">
                        <div class="product-image-container">
                            <img src="images/<%= p.getProductID() %>.png" class="product-image" alt="<%= p.getProductName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-name"><%= p.getProductName() %></h3>
                            <p class="product-price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                            <p class="product-color"><%= p.getColor() %></p>
                            <span class="btn-view">Xem chi tiết</span>
                        </div>
                    </a>
                </div>
            <% } %>
        </div>
    </section>
    
    <!-- T-SHIRTS Section -->
    <div id="tops-section" class="category-container">
        <h2 class="category-title">T-Shirts</h2>
        <div class="product-grid">
            <% 
            boolean hasTshirts = false;
            for (Product p : products) { 
                if (p.getCodeProduct() != null && p.getCodeProduct().startsWith("TS")) { 
                    hasTshirts = true;
            %>
                <div class="product-card">
                    <a href="productdetails.jsp?id=<%= p.getProductID() %>" class="text-decoration-none">
                        <div class="product-image-container">
                            <img src="images/<%= p.getProductID() %>.png" class="product-image" alt="<%= p.getProductName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-name"><%= p.getProductName() %></h3>
                            <p class="product-price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                            <p class="product-color"><%= p.getColor() %></p>
                            <span class="btn-view">Xem chi tiết</span>
                        </div>
                    </a>
                </div>
            <%  
                } 
            }
            if (!hasTshirts) { 
            %>
                <div class="empty-category col-12">
                    <p>Không có sản phẩm T-Shirt nào.</p>
                </div>
            <% } %>
        </div>
    </div>

    <div class="category-divider"></div>

    <!-- BOTTOMS Section -->
    <div id="bottoms-section" class="category-container">
        <h2 class="category-title">Bottoms</h2>
        <div class="product-grid">
            <% 
            boolean hasBottoms = false;
            for (Product p : products) { 
                if (p.getCodeProduct() != null && p.getCodeProduct().startsWith("BT")) { 
                    hasBottoms = true;
            %>
                <div class="product-card">
                    <a href="productdetails.jsp?id=<%= p.getProductID() %>" class="text-decoration-none">
                        <div class="product-image-container">
                            <img src="images/<%= p.getProductID() %>.png" class="product-image" alt="<%= p.getProductName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-name"><%= p.getProductName() %></h3>
                            <p class="product-price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                            <p class="product-color"><%= p.getColor() %></p>
                            <span class="btn-view">Xem chi tiết</span>
                        </div>
                    </a>
                </div>
            <%  
                } 
            }
            if (!hasBottoms) { 
            %>
                <div class="empty-category col-12">
                    <p>Không có sản phẩm Bottoms nào.</p>
                </div>
            <% } %>
        </div>
    </div>

    <div class="category-divider"></div>

    <!-- JEWELRY Section -->
    <div id="jew-section" class="category-container">
        <h2 class="category-title">Jewelry</h2>
        <div class="product-grid">
            <% 
            boolean hasJewelry = false;
            for (Product p : products) {
                if (p.getCodeProduct() != null && p.getCodeProduct().startsWith("JE")) {
                    hasJewelry = true;
            %>
                <div class="product-card">
                    <a href="productdetails.jsp?id=<%= p.getProductID() %>" class="text-decoration-none">
                        <div class="product-image-container">
                            <img src="images/<%= p.getProductID() %>.png" class="product-image" alt="<%= p.getProductName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-name"><%= p.getProductName() %></h3>
                            <p class="product-price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                            <p class="product-color"><%= p.getColor() %></p>
                            <span class="btn-view">Xem chi tiết</span>
                        </div>
                    </a>
                </div>
            <%  
                } 
            }
            if (!hasJewelry) { 
            %>
                <div class="empty-category col-12">
                    <p>Không có sản phẩm Jewelry nào.</p>
                </div>
            <% } %>
        </div>
    </div>

    <div class="category-divider"></div>
    
    <!-- ACCESSORIES Section -->
    <div id="acc-section" class="category-container">
        <h2 class="category-title">Accessories</h2>
        <div class="product-grid">
            <% 
            boolean hasAccessories = false;
            for (Product p : products) {
                if (p.getCodeProduct() != null && p.getCodeProduct().startsWith("AC")) {
                    hasAccessories = true;
            %>
                <div class="product-card">
                    <a href="productdetails.jsp?id=<%= p.getProductID() %>" class="text-decoration-none">
                        <div class="product-image-container">
                            <img src="images/<%= p.getProductID() %>.png" class="product-image" alt="<%= p.getProductName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-name"><%= p.getProductName() %></h3>
                            <p class="product-price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                            <p class="product-color"><%= p.getColor() %></p>
                            <span class="btn-view">Xem chi tiết</span>
                        </div>
                    </a>
                </div>
            <%  
                } 
            }
            if (!hasAccessories) { 
            %>
                <div class="empty-category col-12">
                    <p>Không có sản phẩm Accessories nào.</p>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>