<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="model.Product" %>
<%@page import="data.ProductDAO" %>
<%@ page import="model.Cart" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    Product product = null;
    String errorMessage = null;
    String productIdParam = request.getParameter("id");

    HttpSession sessionObj = request.getSession(false);
    String role = (sessionObj != null) ? (String) sessionObj.getAttribute("role") : null;
    Cart headerCart = (Cart) sessionObj.getAttribute("cart");
    int cartCount = (headerCart != null) ? headerCart.getItems().size() : 0;

    if (productIdParam != null && !productIdParam.trim().isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdParam);
            ProductDAO productDAO = new ProductDAO();
            product = productDAO.getProductById(productId);
            if (product == null) {
                errorMessage = "Sản phẩm không tồn tại!";
            }
        } catch (NumberFormatException e) {
            errorMessage = "ID sản phẩm không hợp lệ!";
        } catch (Exception e) {
            errorMessage = "Lỗi hệ thống: " + e.getMessage();
        }
    } else {
        errorMessage = "Không tìm thấy ID sản phẩm!";
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .content {
            padding-top: 10px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 1200px;
            margin: 50px auto;
        }
        .info, .image, .details {
            flex: 1;
            padding: 20px;
        }
        .info {
            max-width: 250px;
            font-size: 14px;
            line-height: 1.6;
            overflow-y: auto;
            height: 400px;
            border-right: 1px solid #ccc;
        }
        .image {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Ngăn ảnh tràn ra ngoài khi zoom */
            position: relative; /* Đảm bảo ảnh được định vị tốt */
        }
        .image img {
            max-width: 100%;
            height: auto;
            transition: transform 0.3s ease; /* Hiệu ứng mượt mà */
        }
        .image img:hover {
            transform: scale(1.2); /* Zoom ảnh lên 120% */
            cursor: zoom-in; /* Đổi con trỏ thành biểu tượng zoom */
        }
        .details {
            max-width: 300px;
        }
        .details h1 {
            font-size: 20px;
            font-weight: bold;
        }
        .details .price {
            font-size: 24px;
            font-weight: bold;
            color: black;
            margin: 10px 0;
        }
        .buttons {
            margin-top: 20px;
        }
        .buttons button {
            width: 100%;
            padding: 10px;
            border: 1px solid black;
            background: white;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .buttons .buy-now {
            background: black;
            color: white;
        }
        .size-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 50%;
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            z-index: 1001;
            text-align: center;
        }
        .size-popup img {
            width: 80%;
            max-width: 400px;
            height: auto;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }
        .close-btn {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 20px;
            cursor: pointer;
        }
        .size-text {
            font-size: 18px;
            font-weight: bold;
            font-family: Arial, sans-serif;
            color: #333;
        }
        .size-link {
            margin-left: 105px;
            color: #000;
            font-size: 10px;
            font-family: Arial, sans-serif;
            text-decoration: underline;
            cursor: pointer;
        }
        .size-link:hover {
            color: #ccc;
        }
        .details .size-options {
            display: flex;
            margin: 10px 0;
        }
        .details .size-options div {
            width: 50px;
            height: 50px;
            border: 1px solid black;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 10px;
            cursor: pointer;
        }
        .details .size-box:hover {
            background: black;
            color: white;
        }
        .details .size-box.selected {
            background: black;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-left">
            <a href="index.jsp#home-section" class="logo">davadoi.clo</a>
            <a href="index.jsp#tops-section">TOPS</a>
            <a href="index.jsp#bottoms-section">BOTTOMS</a>
            <a href="index.jsp#jew-section">JEWELRY</a>
            <a href="index.jsp#acc-section">ACCESSORIES</a>
        </div>
        <div class="nav-right">
            <a href="cart.jsp">GIỎ HÀNG (<span id="cart-count"><%= cartCount %></span>)</a>
        </div>
    </nav>

    <!-- Nội dung chi tiết sản phẩm -->
    <div class="content">
        <div class="container">
            <% if (errorMessage != null) { %>
                <h2 class="text-center text-danger"><%= errorMessage %></h2>
            <% } else { %>
                <!-- Thông tin sản phẩm (trái) -->
                <div class="info">
                    <h3>THÔNG TIN</h3>
                    <ul>
                        <li>Tên sản phẩm: <%= product.getProductName() %></li>
                        <li>Mã sản phẩm: <%= product.getCodeProduct() %></li>
                        <li>Màu sắc: <%= product.getColor() %></li>
                    </ul>
                    <p><b>Mô tả:</b> <%= product.getDescription() %></p>
                    <p><b>Lưu ý:</b> Màu sắc có thể khác do điều kiện ánh sáng.</p>
                    <p>Vận chuyển từ 2-3 ngày.</p>
                </div>

                <!-- Hình ảnh sản phẩm (giữa) -->
                <div class="image">
                    <img src="images/<%= product.getProductID() %>.png" 
                         alt="<%= product.getProductName() %>"
                         onerror="this.src='images/default.png';">
                </div>

                <!-- Chi tiết mua hàng (phải) -->
                <div class="details">
                    <h1><%= product.getProductName() %></h1>
                    <p>SKU: <%= product.getProductID() %></p>
                    <p class="price"><%= String.format("%,.0f", product.getPrice()) %>₫</p>

                    <%
                        String colorCode;
                        switch (product.getColor().toLowerCase().trim()) {
                            case "red":
                                colorCode = "#FE2020";
                                break;
                            case "black":
                                colorCode = "#000000";
                                break;
                            case "blue":
                                colorCode = "#0000FF";
                                break;
                            case "white":
                                colorCode = "#FFFFFF";
                                break;
                            case "pink":
                                colorCode = "#FFC0CB";
                                break;
                            case "green":
                                colorCode = "#008000";
                                break;
                            case "yellow":
                            case "YELLOW":
                            case "Yellow":
                                colorCode = "#FFFF00";
                                break;
                            default:
                                colorCode = "#000000";
                                break;
                        }
                    %>

                    <p><b>Màu sắc:</b> <%= product.getColor() %></p>
                    <div style="width: 20px; height: 20px; background: <%= colorCode %>; border: 1px solid #000;"></div>

                    <p><span class="size-text">Kích thước</span> 
                        <a href="#" class="size-link" onclick="openSizeChart()">BẢNG SIZE</a>
                    </p>
                    <div class="size-options">
                        <div class="size-box">S</div>
                        <div class="size-box">M</div>
                        <div class="size-box">L</div>
                    </div>

                    <div class="buttons">
                        <button onclick="addToCart()">THÊM VÀO GIỎ</button>
                        <form id="buyNowForm" action="customerpay.jsp" method="GET">
                            <input type="hidden" name="name" value="<%= product.getProductName() %>">
                            <input type="hidden" name="color" value="<%= product.getColor() %>">
                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                            <input type="hidden" name="size" id="selectedSize" value="">
                            <button type="button" class="buy-now" onclick="submitBuyNow()">MUA NGAY</button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Nền mờ -->
    <div id="overlay" class="overlay" onclick="closeSizeChart()"></div>

    <!-- Popup bảng size -->
    <div id="sizePopup" class="size-popup">
        <span class="close-btn" onclick="closeSizeChart()">×</span>
        <img src="images/size.png" alt="Bảng Size">
    </div>

    <!-- JavaScript -->
    <script>
        function openSizeChart() {
            document.getElementById("sizePopup").style.display = "block";
            document.getElementById("overlay").style.display = "block";
        }

        function closeSizeChart() {
            document.getElementById("sizePopup").style.display = "none";
            document.getElementById("overlay").style.display = "none";
        }

        document.addEventListener("DOMContentLoaded", function () {
            let sizeBoxes = document.querySelectorAll(".details .size-box");
            sizeBoxes.forEach(box => {
                box.addEventListener("click", function () {
                    sizeBoxes.forEach(b => b.classList.remove("selected"));
                    this.classList.add("selected");
                });
            });
        });

        function addToCart() {
            let selectedSize = document.querySelector(".details .size-box.selected");
            if (!selectedSize) {
                alert("Vui lòng chọn kích thước trước khi thêm vào giỏ hàng!");
                return;
            }

            fetch('cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=<%= product.getProductID() %>&size=' + selectedSize.innerText
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById("cart-count").innerText = data.cartCount;
                    alert("Đã thêm vào giỏ hàng!");
                } else {
                    alert("Có lỗi xảy ra: " + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Có lỗi xảy ra khi thêm vào giỏ hàng!");
            });
        }

        function submitBuyNow() {
            let selectedSize = document.querySelector(".details .size-box.selected");
            if (!selectedSize) {
                alert("Vui lòng chọn kích thước trước khi mua!");
                return;
            }
            
            document.getElementById("selectedSize").value = selectedSize.innerText;
            document.getElementById("buyNowForm").action = "customerpay.jsp";
            document.getElementById("buyNowForm").submit();
        }
    </script>

    <%@ include file="footer.jsp" %>
</body>
</html>