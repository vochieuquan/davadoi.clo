<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị | DAVADOI.CLO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            --soft-beige: #f8f7f5;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            letter-spacing: 0.02em;
            color: var(--dark-gray);
            background-color: var(--white);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            padding: 20px 0;
            margin-bottom: 40px;
        }
        
        .brand {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 24px;
            letter-spacing: 0.1em;
            color: var(--black);
        }
        
        .user-nav {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .welcome-text {
            font-size: 14px;
            font-weight: 300;
            color: var(--dark-gray);
        }
        
        .logout-btn {
            text-decoration: none;
            color: var(--dark-gray);
            font-size: 13px;
            font-weight: 300;
            letter-spacing: 0.05em;
            padding: 8px 20px;
            border: 1px solid var(--dark-gray);
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background-color: var(--dark-gray);
            color: var(--white);
        }
        
        /* Main Content */
        .container {
            width: 100%;
            max-width: 1200px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .dashboard-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 28px;
            letter-spacing: 0.1em;
            color: var(--black);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
        }
        
        .dashboard-title::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 1px;
            background-color: var(--black);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .dashboard-subtitle {
            font-size: 14px;
            font-weight: 300;
            color: var(--medium-gray);
            margin-bottom: 40px;
            text-align: center;
            max-width: 600px;
        }
        
        .admin-menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            width: 100%;
        }
        
        .admin-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 30px;
            background-color: var(--white);
            border: 1px solid var(--light-gray);
            transition: all 0.3s ease;
        }
        
        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
        }
        
        .card-icon {
            font-size: 24px;
            color: var(--dark-gray);
            margin-bottom: 20px;
        }
        
        .card-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 20px;
            letter-spacing: 0.05em;
            color: var(--black);
            margin-bottom: 15px;
            text-align: center;
        }
        
        .card-description {
            font-size: 13px;
            color: var(--medium-gray);
            text-align: center;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        
        .card-link {
            display: inline-block;
            text-decoration: none;
            color: var(--dark-gray);
            font-size: 13px;
            font-weight: 300;
            letter-spacing: 0.05em;
            padding: 10px 25px;
            border: 1px solid var(--dark-gray);
            transition: all 0.3s ease;
            text-transform: uppercase;
        }
        
        .card-link:hover {
            background-color: var(--dark-gray);
            color: var(--white);
        }
        
        /* Footer */
        .footer {
            margin-top: 60px;
            text-align: center;
            font-size: 12px;
            color: var(--medium-gray);
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .admin-menu {
                grid-template-columns: 1fr;
            }
            
            .dashboard-title {
                font-size: 24px;
            }
            
            .admin-card {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="brand">DAVADOI.CLO</div>
        <div class="user-nav">
            <% String username = (String) session.getAttribute("username"); %>
            <% if (username != null) { %>
                <span class="welcome-text">Xin chào, <%= username %></span>
                <a href="LogoutServlet" class="logout-btn">ĐĂNG XUẤT</a>
            <% } %>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container">
        <h1 class="dashboard-title">TRANG QUẢN TRỊ</h1>
        <p class="dashboard-subtitle">Quản lý sản phẩm, mã giảm giá và đơn hàng của cửa hàng DAVADOI.CLO</p>
        
        <div class="admin-menu">
            <div class="admin-card">
                <i class="fas fa-box card-icon"></i>
                <h2 class="card-title">Quản Lý Sản Phẩm</h2>
                <p class="card-description">Thêm, chỉnh sửa và xóa sản phẩm trong danh mục cửa hàng. Cập nhật thông tin và hình ảnh sản phẩm.</p>
                <a href="admin.jsp" class="card-link">Quản lý sản phẩm</a>
            </div>
            
            <div class="admin-card">
                <i class="fas fa-tags card-icon"></i>
                <h2 class="card-title">Quản Lý Giảm Giá</h2>
                <p class="card-description">Tạo và quản lý mã giảm giá cho khách hàng. Thiết lập giá trị giảm giá và thời hạn sử dụng.</p>
                <a href="discount.jsp" class="card-link">Quản lý giảm giá</a>
            </div>
            
            <div class="admin-card">
                <i class="fas fa-clipboard-list card-icon"></i>
                <h2 class="card-title">Kiểm Tra Đơn Hàng</h2>
                <p class="card-description">Xem và cập nhật trạng thái đơn hàng. Theo dõi thông tin khách hàng và chi tiết đơn hàng.</p>
                <a href="orders.jsp" class="card-link">Kiểm tra đơn hàng</a>
            </div>
        </div>
    </main>
    
    <!-- Footer -->
    <footer class="footer">
        <p>&copy; <%= new java.util.Date().getYear() + 1900 %> DAVADOI.CLO. Tất cả quyền được bảo lưu.</p>
    </footer>
</body>
</html>