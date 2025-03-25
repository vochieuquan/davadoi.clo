<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Davadoi</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #000000;
            --secondary-color: #ffffff;
            --accent-color: #d4a373;
            --text-color: #333333;
            --light-bg: #f8f8f8;
            --medium-gray: #767676;
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
            line-height: 1.6;
            font-weight: 300;
            letter-spacing: 0.02em;
        }

        /* Header */
        header {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 50px;
            background-color: var(--primary-color);
            color: var(--secondary-color);
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 4px;
            color: var(--secondary-color);
            cursor: pointer;
            transition: var(--transition);
        }
        
        .logo:hover {
            opacity: 0.8;
        }

        /* Hero Section with YouTube Video */
        .hero {
            height: 100vh;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: var(--secondary-color);
            overflow: hidden;
            margin-top: 0;
        }
        
        .hero iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none; /* Prevents clicks on the video */
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }
        
        .hero-text {
            z-index: 1;
            padding: 60px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            background: rgba(0, 0, 0, 0.9);
            max-width: 700px;
            width: 90%;
        }
        
        .hero-text h1 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 72px;
            margin-bottom: 30px;
            font-weight: 400;
            letter-spacing: 0.05em;
        }
        
        .hero-text p {
            font-size: 18px;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        /* About Content */
        .about-content {
            padding: 120px 50px;
            background-color: var(--light-bg);
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .about-section {
            margin-bottom: 80px;
            position: relative;
        }
        
        .about-section:last-child {
            margin-bottom: 0;
        }
        
        .about-content h2 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 42px;
            margin-bottom: 40px;
            color: var(--primary-color);
            font-weight: 400;
            text-align: center;
            letter-spacing: 0.05em;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .about-content h2::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 1px;
            background-color: var(--accent-color);
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .about-content p {
            font-size: 16px;
            line-height: 1.8;
            color: var(--text-color);
            margin-bottom: 25px;
            text-align: justify;
        }
        
        .about-content p:last-child {
            margin-bottom: 0;
        }
        
        .about-content p strong {
            font-weight: 500;
            color: var(--primary-color);
        }
        
        .founder-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }
        
        .founder-card {
            text-align: center;
            padding: 30px;
            background-color: var(--secondary-color);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .founder-card h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            margin-bottom: 10px;
            font-weight: 500;
        }
        
        .founder-card p {
            font-size: 14px;
            color: var(--medium-gray);
            text-align: center;
            margin-bottom: 0;
        }
        
        .mission-statement {
            font-size: 20px;
            line-height: 1.8;
            font-style: italic;
            text-align: center;
            max-width: 800px;
            margin: 0 auto 40px;
            color: var(--medium-gray);
            font-family: 'Cormorant Garamond', serif;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-top: 50px;
        }
        
        .value-item {
            text-align: center;
            padding: 30px;
        }
        
        .value-item h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            margin-bottom: 15px;
            font-weight: 400;
        }
        
        .value-item p {
            font-size: 15px;
            text-align: center;
        }

        /* Footer */
        footer {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            text-align: center;
            padding: 40px 20px;
        }
        
        footer p {
            font-size: 14px;
            letter-spacing: 1px;
        }
        
        /* Responsive styles */
        @media (max-width: 992px) {
            .hero-text h1 {
                font-size: 60px;
            }
            
            .about-content {
                padding: 80px 40px;
            }
            
            .values-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .hero-text {
                padding: 40px;
            }
            
            .hero-text h1 {
                font-size: 48px;
            }
            
            .about-content h2 {
                font-size: 36px;
            }
            
            .founder-grid {
                grid-template-columns: 1fr;
            }
            
            .values-grid {
                grid-template-columns: 1fr;
            }
            
            .about-content {
                padding: 60px 30px;
            }
        }
        
        @media (max-width: 576px) {
            .hero-text h1 {
                font-size: 36px;
            }
            
            .hero-text p {
                font-size: 16px;
            }
            
            .about-content {
                padding: 50px 20px;
            }
            
            .about-content h2 {
                font-size: 30px;
            }
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Điều hướng logo về index.jsp
            document.querySelector(".logo").addEventListener("click", function() {
                window.location.href = "index.jsp";
            });

            
            // Kiểm tra nếu nhạc không phát
            setTimeout(() => {
                if (!document.querySelector("iframe[src*='j3KCob5TbMk']").contentWindow) {
                    console.log("Nhạc nền có thể bị chặn. Vui lòng nhấp vào trang để bật âm thanh.");
                }
            }, 2000);
        });
    </script>
</head>
<body>
    <header>
        <div class="logo">DAVADOI</div>
    </header>
    
    <%@ include file="sss.jsp" %>

    <section class="hero">
        <iframe src="https://www.youtube.com/embed/H-xkOv4b6bY?autoplay=1&mute=1&loop=1&playlist=H-xkOv4b6bY&controls=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        <div class="hero-text">
            <h1>About Us</h1>
            <p>Stand strong, adapt, and never give up.</p>
        </div>
    </section>
    
    <section class="about-content">
        <div class="container">
            <div class="about-section">
                <h2>Our Story</h2>
                <p>Davadoi được sinh ra với một tầm nhìn: không chỉ là thời trang, mà còn là biểu tượng của sự bền bỉ và kiên trì. Chúng tôi bắt đầu với đam mê và không ngừng đổi mới để mang đến những sản phẩm kết hợp giữa phong cách và sự linh hoạt, phù hợp với mọi thử thách của cuộc sống.</p>
            </div>
            
            <div class="about-section">
                <h2>Meet Our Founders</h2>
                <div class="founder-grid">
                    <div class="founder-card">
                        <h3>Võ Chiêu Quân</h3>
                        <p>CEO & Founder</p>
                        <p>Người đặt nền móng cho davadoi, với tầm nhìn nhỏ và niềm đam mê không không có.</p>
                    </div>
                    <div class="founder-card">
                        <h3>Khánh Dương</h3>
                        <p>Creative Director</p>
                        <p>Đầu tàu sáng tạo, mang đến những thiết kế đột phá và đầy cảm hứng.</p>
                    </div>
                    <div class="founder-card">
                        <h3>Nguyễn Phong</h3>
                        <p>COO</p>
                        <p>Điều phối mọi hoạt động để đảm bảo Davadoi luôn phát triển mạnh mẽ.</p>
                    </div>
                    <div class="founder-card">
                        <h3>Đức Duy</h3>
                        <p>Head of Marketing</p>
                        <p>Xây dựng chiến lược truyền thông và kết nối thương hiệu với khách hàng.</p>
                    </div>
                    <div class="founder-card">
                        <h3>Anh Khoa</h3>
                        <p>Lead Designer</p>
                        <p>Chịu trách nhiệm sáng tạo những bộ sưu tập độc đáo, mang đậm dấu ấn riêng.</p>
                    </div>
                </div>
            </div>
            
            <div class="about-section">
                <h2>Our Mission</h2>
                <p class="mission-statement">"Chúng tôi tin rằng quần áo không chỉ là thứ bạn mặc, mà là cách bạn thể hiện cá tính và tinh thần của mình."</p>
                <p>Davadoi cam kết đồng hành cùng bạn, giúp bạn tạo dựng phong cách riêng biệt, mạnh mẽ và luôn thích nghi với mọi hoàn cảnh.</p>
                <p>Với cam kết về chất lượng, sự sáng tạo và tính bền vững, Davadoi mong muốn trở thành thương hiệu đồng hành cùng bạn trên mọi chặng đường.</p>
            </div>
            
            <div class="about-section">
                <h2>Why Choose Us?</h2>
                <p>Chúng tôi không chỉ đơn thuần bán quần áo, mà còn mang đến một triết lý sống: mạnh mẽ, bền bỉ và không ngừng phát triển. Chất liệu cao cấp, thiết kế sáng tạo, và sự chú trọng đến từng chi tiết giúp chúng tôi khác biệt. Hãy để Davadoi cùng bạn chinh phục mọi giới hạn!</p>
                <p>Với những bộ sưu tập độc đáo và dịch vụ tận tâm, chúng tôi luôn mong muốn mang đến trải nghiệm tốt nhất cho khách hàng. Chọn Davadoi là chọn sự khác biệt, phong cách và chất lượng.</p>
                
                <div class="values-grid">
                    <div class="value-item">
                        <h3>Chất Lượng</h3>
                        <p>Chúng tôi không ngừng theo đuổi sự hoàn hảo trong từng đường kim mũi chỉ.</p>
                    </div>
                    <div class="value-item">
                        <h3>Sáng Tạo</h3>
                        <p>Luôn đổi mới và mang đến những thiết kế độc đáo, phá cách.</p>
                    </div>
                    <div class="value-item">
                        <h3>Bền Vững</h3>
                        <p>Cam kết với các giá trị bền vững và trách nhiệm với môi trường.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <footer>
        <p>© 2025 Davadoi. All Rights Reserved.</p>
    </footer>
</body>
</html>