<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Cart" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;
    Cart headerCart = (Cart) sessionObj.getAttribute("cart");
    int cartCount = (headerCart != null) ? headerCart.getItems().size() : 0;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #000000;
            --secondary-color: #ffffff;
            --accent-color: #f5f5f5;
            --text-color: #333333;
            --border-color: #e0e0e0;
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: var(--text-color);
            background-color: var(--secondary-color);
        }
        
        /* Header styles */
        .announcement-bar {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            text-align: center;
            padding: 8px 0;
            font-size: 12px;
            letter-spacing: 1px;
        }
        
        .header {
            position: sticky;
            top: 0;
            background-color: var(--secondary-color);
            z-index: 1000;
            border-bottom: 1px solid var(--border-color);
        }
        
        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            position: relative;
        }
        
        .logo {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 2px;
            text-decoration: none;
            color: var(--primary-color);
        }
        
        .nav-left, .nav-right {
            display: flex;
            align-items: center;
        }
        
        .nav-left a, .nav-right a, .nav-right span {
            margin: 0 15px;
            text-decoration: none;
            color: var(--text-color);
            font-size: 13px;
            letter-spacing: 1px;
            font-weight: 500;
            transition: var(--transition);
            text-transform: uppercase;
        }
        
        .nav-left a:hover, .nav-right a:hover {
            opacity: 0.7;
        }
        
        .nav-right span {
            font-style: italic;
        }
        
        .cart-icon {
            position: relative;
        }
        
        .cart-count {
            display: inline-block;
        }
        
        /* Mobile menu */
        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 24px;
        }
        
        /* Slider styles */
        .slider-container {
            width: 100%;
            overflow: hidden;
            position: relative;
            height: 80vh;
        }
        
        .slider {
            display: flex;
            transition: transform 0.5s ease-in-out;
            height: 100%;
        }
        
        .slider img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            flex-shrink: 0;
        }
        
        /* Responsive styles */
        @media (max-width: 992px) {
            .nav-left {
                display: none;
            }
            
            .mobile-menu-toggle {
                display: block;
            }
            
            .logo {
                position: static;
                transform: none;
            }
            
            .navbar {
                justify-content: space-between;
            }
            
            .slider-container {
                height: 50vh;
            }
        }
        
        @media (max-width: 576px) {
            .nav-right span {
                display: none;
            }
            
            .slider-container {
                height: 40vh;
            }
        }
    </style>
</head>
<body>
    <div class="announcement-bar">
        Chào mừng quý khách đã đến với DAVADOI.CLO
    </div>
    
    <header class="header">
        <div class="header-container">
            <nav class="navbar">
                <button class="mobile-menu-toggle">☰</button>
                
                <div class="nav-left">
                    <a href="index.jsp#tops-section">TOPS</a>
                    <a href="index.jsp#bottoms-section">BOTTOMS</a>
                    <a href="index.jsp#jew-section">JEWELRY</a>
                    <a href="index.jsp#acc-section">ACCESSORIES</a>
                    <a href="blog.jsp">ABOUT US</a>
                </div>
                
                <a href="index.jsp#home-section" class="logo">davadoi.clo</a>
                
                <div class="nav-right">
                    <% if (username != null) { %>
                        <span>Xin chào, <%= username %></span>
                        <a href="LogoutServlet">ĐĂNG XUẤT</a>
                    <% } else { %>
                        <a href="login.jsp">ĐĂNG NHẬP</a>
                    <% } %>
                    <a href="cart.jsp" class="cart-icon">GIỎ HÀNG <span class="cart-count">(<%= cartCount %>)</span></a>
                </div>
            </nav>
        </div>
    </header>
    
    <!--=============================== Slider -->

    
    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slider img');
        const slideCount = slides.length;
        
        function showSlide(index) {
            document.querySelector('.slider').style.transform = `translateX(-${index * 100}%)`;
        }
        
        function nextSlide() {
            currentSlide = (currentSlide + 1) % slideCount;
            showSlide(currentSlide);
        }
        
        setInterval(nextSlide, 5000);
        
        
    </script>
</body>
</html>