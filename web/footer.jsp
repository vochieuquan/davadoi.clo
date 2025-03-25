<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
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
        
        .footer-elegant {
            padding: 70px 0 40px;
            color: var(--dark-gray);
            background-color: var(--off-white);
            font-family: 'Montserrat', sans-serif;
            letter-spacing: 0.02em;
            font-weight: 300;
        }
        
        .footer-elegant h3 {
            margin-top: 0;
            margin-bottom: 20px;
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 1.5rem;
            letter-spacing: 0.05em;
            color: var(--black);
        }
        
        .footer-elegant ul {
            padding: 0;
            list-style: none;
            line-height: 2;
            font-size: 0.9rem;
            margin-bottom: 0;
        }
        
        .footer-elegant ul a {
            color: var(--medium-gray);
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            display: inline-block;
        }
        
        .footer-elegant ul a::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -2px;
            left: 0;
            background-color: var(--black);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .footer-elegant ul a:hover {
            color: var(--black);
        }
        
        .footer-elegant ul a:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        .footer-elegant .item.text {
            margin-bottom: 36px;
        }
        
        .footer-elegant .item.text p {
            color: var(--medium-gray);
            line-height: 1.8;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }
        
        .footer-elegant .divider {
            width: 40px;
            height: 1px;
            background-color: var(--black);
            margin: 30px 0;
        }
        
        .footer-elegant .item.social {
            text-align: left;
            margin-top: 20px;
        }
        
        .footer-elegant .item.social > a {
            font-size: 16px;
            width: 36px;
            height: 36px;
            line-height: 36px;
            display: inline-block;
            text-align: center;
            border-radius: 50%;
            border: 1px solid var(--medium-gray);
            margin-right: 10px;
            color: var(--medium-gray);
            transition: all 0.3s ease;
        }
        
        .footer-elegant .item.social > a:hover {
            color: var(--black);
            border-color: var(--black);
        }
        
        .footer-elegant .copyright {
            text-align: center;
            padding-top: 40px;
            color: var(--medium-gray);
            font-size: 0.8rem;
            letter-spacing: 0.05em;
            margin-top: 40px;
            border-top: 1px solid var(--light-gray);
        }
        
        .footer-elegant .newsletter-form {
            position: relative;
            margin-top: 20px;
        }
        
        .footer-elegant .newsletter-input {
            width: 100%;
            padding: 12px 15px;
            background-color: transparent;
            border: 1px solid var(--medium-gray);
            color: var(--dark-gray);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.9rem;
            letter-spacing: 0.05em;
        }
        
        .footer-elegant .newsletter-input:focus {
            outline: none;
            border-color: var(--black);
        }
        
        .footer-elegant .newsletter-button {
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            background: transparent;
            border: none;
            padding: 0 15px;
            color: var(--medium-gray);
            transition: all 0.3s ease;
        }
        
        .footer-elegant .newsletter-button:hover {
            color: var(--black);
        }
        
        .footer-elegant .contact-info {
            margin-top: 20px;
            font-size: 0.9rem;
            color: var(--medium-gray);
            line-height: 1.8;
        }
        
        .footer-elegant .contact-info i {
            width: 20px;
            margin-right: 5px;
        }
        
        @media (max-width: 767px) {
            .footer-elegant .item:not(.social) {
                text-align: center;
                padding-bottom: 20px;
            }
            
            .footer-elegant .item.social {
                text-align: center;
            }
            
            .footer-elegant .divider {
                margin: 20px auto;
            }
        }
    </style>
</head>

<body>
    <div class="footer-elegant">
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-md-3 item">
                        <h3>Bộ Sưu Tập</h3>
                        <ul>
                            <li><a href="#tops-section">T-Shirts</a></li>
                            <li><a href="#bottoms-section">Bottoms</a></li>
                            <li><a href="#jew-section">Jewelry</a></li>
                            <li><a href="#acc-section">Accessories</a></li>
                        </ul>
                    </div>
                    <div class="col-sm-6 col-md-3 item">
                        <h3>Thông Tin</h3>
                        <ul>
                            <li><a href="blog.jsp">Về Chúng Tôi</a></li>
                            <li><a href="#">Chính Sách Đổi Trả</a></li>
                            <li><a href="#">Hướng Dẫn Mua Hàng</a></li>
                            <li><a href="#">Liên Hệ</a></li>
                        </ul>
                    </div>
                    <div class="col-md-6 item text">
                        <h3>DAVADOI.CLO</h3>
                        <p>Davadoi được sinh ra với một tầm nhìn: không chỉ là thời trang, mà còn là biểu tượng của sự bền bỉ và kiên trì. Chúng tôi bắt đầu với đam mê và không ngừng đổi mới để mang đến những sản phẩm kết hợp giữa phong cách và sự linh hoạt, phù hợp với mọi thử thách của cuộc sống.</p>
                        
                        <div class="divider"></div>
                        
                        <h3>Đăng Ký Nhận Tin</h3>
                        <p>Đăng ký để nhận thông tin về bộ sưu tập mới và ưu đãi đặc biệt.</p>
                        
                        <form class="newsletter-form">
                            <input type="email" class="newsletter-input" placeholder="Email của bạn">
                            <button type="submit" class="newsletter-button">
                                <i class="fas fa-arrow-right"></i>
                            </button>
                        </form>
                        
                        <div class="contact-info">
                            <p><i class="fas fa-map-marker-alt"></i> 2222 Nguyễn Văn Linh, TP. Quảng Ngãi</p>
                            <p><i class="fas fa-phone"></i> +84 123 456 789</p>
                            <p><i class="fas fa-envelope"></i> info@davadoi.clo</p>
                        </div>
                        
                        <div class="item social">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-tiktok"></i></a>
                            <a href="#"><i class="fab fa-pinterest-p"></i></a>
                        </div>
                    </div>
                </div>
                <p class="copyright">DAVADOI.CLO © 2025 | Timeless Elegance, Modern Expression</p>
            </div>
        </footer>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
</body>

</html>