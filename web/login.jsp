<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Kiểm tra nếu user đã đăng nhập, chuyển hướng về index.jsp
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null && sessionObj.getAttribute("username") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Nhận lỗi từ Servlet (nếu có)
    String errorMessage = (String) request.getAttribute("error");
    String usernameValue = (String) request.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập | DAVADOI.CLO</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --black: #000000;
            --white: #ffffff;
            --off-white: #f5f5f5;
            --light-gray: #e0e0e0;
            --medium-gray: #767676;
            --dark-gray: #333333;
            --soft-beige: #f8f7f5;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            margin: 0;
            padding: 0;
            background: url('images/nen2.png') no-repeat center center/cover;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            letter-spacing: 0.02em;
            color: var(--dark-gray);
        }
        
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: center; /* Center the logo */
            align-items: center;
            z-index: 1000;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
        }
        
        .logo {
            font-family: 'Montserrat', serif;
            font-size: 24px;
            font-weight: 300; /* Lighter font weight */
            text-transform: uppercase;
            letter-spacing: 0.15em; /* Increased letter spacing for elegance */
            color: var(--black);
            text-decoration: none;
            transition: opacity 0.3s ease;
        }
        
        .logo:hover {
            opacity: 0.8;
        }
        
        .login-container {
            position: relative;
            width: 400px;
            max-width: 90%;
            margin: auto;
            padding: 40px;
            background: rgba(248, 247, 245, 0.85); /* Softer beige color with transparency */
            text-align: center;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.05); /* Lighter shadow */
            border: 1px solid rgba(224, 224, 224, 0.3); /* Very subtle border */
        }
        
        .login-container h2 {
            font-family: 'Montserrat', serif;
            font-size: 26px;
            font-weight: 300; /* Lighter font weight */
            margin-bottom: 25px;
            letter-spacing: 0.12em;
            color: var(--dark-gray); /* Slightly softer than black */
        }
        
        .divider {
            width: 30px; /* Slightly smaller divider */
            height: 1px;
            background-color: var(--medium-gray); /* Lighter color for the divider */
            margin: 0 auto 30px;
        }
        
        .login-container label {
            display: block;
            text-align: left;
            font-size: 11px; /* Smaller text */
            margin-bottom: 8px;
            font-weight: 300; /* Lighter weight */
            letter-spacing: 0.05em;
            text-transform: uppercase;
            color: var(--medium-gray);
        }
        
        .login-container input {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 1px solid var(--light-gray);
            background-color: rgba(255, 255, 255, 0.7); /* Slightly transparent white */
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            font-weight: 300; /* Lighter weight */
            transition: border-color 0.3s ease;
        }
        
        .login-container input:focus {
            outline: none;
            border-color: var(--medium-gray); /* Softer focus color */
            background-color: rgba(255, 255, 255, 0.9); /* More opaque on focus */
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: var(--dark-gray); /* Softer than pure black */
            color: var(--white);
            font-family: 'Montserrat', sans-serif;
            font-weight: 300; /* Lighter weight */
            font-size: 11px;
            letter-spacing: 0.12em;
            border: none;
            cursor: pointer;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
        }
        
        .btn-login:hover {
            background-color: var(--black);
        }
        
        .register-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: var(--medium-gray);
            font-size: 12px;
            font-weight: 300; /* Lighter weight */
            letter-spacing: 0.05em;
            position: relative;
            transition: color 0.3s ease;
        }
        
        .register-link::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -2px;
            left: 0;
            background-color: var(--medium-gray); /* Lighter underline */
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .register-link:hover {
            color: var(--dark-gray);
        }
        
        .register-link:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        .error-message {
            color: #d32f2f;
            font-size: 12px;
            font-weight: 300; /* Lighter weight */
            margin-bottom: 20px;
            padding: 10px;
            background-color: rgba(211, 47, 47, 0.05); /* Very subtle background */
            border-left: 2px solid #d32f2f; /* Thinner border */
            text-align: left;
        }
        
        @media (max-width: 768px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .navbar {
                padding: 15px 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar with centered logo -->
    <nav class="navbar">
        <a href="index.jsp" class="logo">davadoi.clo</a>
    </nav>

    <!-- Form đăng nhập with softer styling -->
    <div class="login-container">
        <h2>ĐĂNG NHẬP</h2>
        <div class="divider"></div>

        <% if (errorMessage != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="<%= usernameValue != null ? usernameValue : "" %>" required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
        </form>
        <a href="register.jsp" class="register-link">Chưa có tài khoản? Đăng ký ngay</a>
    </div>

</body>
</html>