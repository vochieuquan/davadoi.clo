<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    font-family: 'Montserrat', sans-serif;
    font-weight: 600; /* Hoặc 700 để đậm hơn */
    letter-spacing: 0.02em;
    color: var(--dark-gray);
    
    background: url('images/nen2.png') no-repeat center center/cover;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
}

        
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
        }
        
        .logo {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
    font-weight: 600; /* Hoặc 700 để đậm hơn */
            text-transform: uppercase;
            letter-spacing: 0.15em;
            color: var(--black);
            text-decoration: none;
            transition: opacity 0.3s ease;
        }
        
        .logo:hover {
            opacity: 0.8;
        }
        
        .register-container {
            width: 100%;
            max-width: 500px;
            padding: 40px;
            background: rgba(248, 247, 245, 0.85);
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.05);
            text-align: center;
            border: 1px solid rgba(224, 224, 224, 0.3);
        }
        
        .register-container h2 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 26px;
    font-weight: 600; /* Hoặc 700 để đậm hơn */
            margin-bottom: 25px;
            letter-spacing: 0.12em;
            color: var(--dark-gray);
        }
        
        .divider {
            width: 30px;
            height: 1px;
            background-color: var(--medium-gray);
            margin: 0 auto 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .register-container label {
            display: block;
            text-align: left;
            font-size: 11px;
            margin-bottom: 8px;
            font-weight: 300;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            color: var(--medium-gray);
        }
        
        .register-container input,
        .register-container select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            background-color: rgba(255, 255, 255, 0.7);
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            font-weight: 300;
            color: var(--dark-gray);
            transition: border-color 0.3s ease;
        }
        
        .register-container input:focus,
        .register-container select:focus {
            outline: none;
            border-color: var(--medium-gray);
            background-color: rgba(255, 255, 255, 0.9);
        }
        
        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: var(--dark-gray);
            color: var(--white);
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            font-size: 11px;
            letter-spacing: 0.12em;
            border: none;
            cursor: pointer;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-register:hover {
            background-color: var(--black);
        }
        
        .error-message {
            color: #d32f2f;
            font-size: 12px;
            font-weight: 300;
            margin-bottom: 20px;
            padding: 10px;
            background-color: rgba(211, 47, 47, 0.05);
            border-left: 2px solid #d32f2f;
            text-align: left;
        }
        
        .success-message {
            color: #155724;
            font-size: 12px;
            font-weight: 300;
            margin-bottom: 20px;
            padding: 10px;
            background-color: rgba(21, 87, 36, 0.05);
            border-left: 2px solid #155724;
            text-align: left;
        }
        
        .login-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: var(--medium-gray);
            font-size: 12px;
            font-weight: 300;
            letter-spacing: 0.05em;
            position: relative;
            transition: color 0.3s ease;
        }
        
        .login-link::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -2px;
            left: 0;
            background-color: var(--medium-gray);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .login-link:hover {
            color: var(--dark-gray);
        }
        
        .login-link:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(3px);
        }
        
        .modal-content {
            background: var(--white);
            padding: 40px;
            text-align: center;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            border: 1px solid var(--light-gray);
        }
        
        .modal-content p {
            font-family: 'Cormorant Garamond', serif;
            font-size: 20px;
    font-weight: 600; /* Hoặc 700 để đậm hơn */
            color: var(--dark-gray);
            margin-bottom: 30px;
            letter-spacing: 0.05em;
        }
        
        .modal-content a {
            display: inline-block;
            padding: 12px 25px;
            background-color: var(--dark-gray);
            color: var(--white);
            text-decoration: none;
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            font-size: 11px;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
        }
        
        .modal-content a:hover {
            background-color: var(--black);
        }
        
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 0;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        @media (max-width: 768px) {
            .register-container {
                padding: 30px 20px;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .navbar {
                padding: 15px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar with centered logo -->
    

    <div class="register-container">
        <h2>ĐĂNG KÝ</h2>
        <div class="divider"></div>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <p class="error-message"><i class="fas fa-exclamation-circle"></i> <%= error %></p>
        <% } %>

        <form action="RegisterServlet" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="lastname">Họ</label>
                    <input type="text" id="lastname" name="lastname" required>
                </div>

                <div class="form-group">
                    <label for="firstname">Tên</label>
                    <input type="text" id="firstname" name="firstname" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="gender">Giới tính</label>
                    <select id="gender" name="gender" required>
                        <option value="Male">Nam</option>
                        <option value="Female">Nữ</option>
                        <option value="Other">Khác</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="dob">Ngày sinh</label>
                    <input type="date" id="dob" name="dob" required>
                </div>
            </div>

            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="confirm_password">Nhập lại mật khẩu</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
            </div>

            <button type="submit" class="btn-register">ĐĂNG KÝ</button>
        </form>

        <a href="login.jsp" class="login-link">Đã có tài khoản? Đăng nhập</a>
    </div>

    <!-- Modal đăng ký thành công -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <p>Đăng ký tài khoản thành công!</p>
            <a href="index.jsp">VỀ TRANG CHỦ</a>
        </div>
    </div>

    <!-- Script kiểm tra trạng thái đăng ký -->
    <script>
        <% String success = (String) request.getAttribute("success");
           if (success != null) { %>
            document.getElementById("successModal").style.display = "flex";
        <% } %>
    </script>
</body>
</html>