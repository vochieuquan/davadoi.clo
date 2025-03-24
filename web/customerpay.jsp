<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Discount, data.DiscountDAO" %>
<%
    String productName = request.getParameter("name");
    String productColor = request.getParameter("color");
    String productSize = request.getParameter("size");
    String productPrice = request.getParameter("price");

    if (productName == null) {
        productName = (String) session.getAttribute("productName");
        productColor = (String) session.getAttribute("productColor");
        productSize = (String) session.getAttribute("productSize");
        productPrice = (String) session.getAttribute("productPrice");
    }

    // Debug giá trị nhận được
    out.println("<!-- Debug - productPrice nhận được: " + productPrice + " -->");

    int basePrice;
    try {
        if (productPrice != null && !productPrice.trim().isEmpty()) {
            productPrice = productPrice.replaceAll("[^0-9]", ""); // Loại bỏ ký tự không phải số
            basePrice = Integer.parseInt(productPrice);
        } else {
            basePrice = 0;
        }
        if (basePrice > 10000) {
            basePrice = basePrice / 10;
            out.println("<!-- Debug - Giá bị x10, đã chia lại: " + basePrice + " -->");
        }
    } catch (NumberFormatException e) {
        basePrice = 0;
        out.println("<!-- Debug - Lỗi parse, gán basePrice = 0 -->");
    }

    // Lấy danh sách discount từ Servlet hoặc trực tiếp từ DAO
    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    if (discounts == null) {
        DiscountDAO discountDAO = new DiscountDAO();
        discounts = discountDAO.getAllDiscounts();
    }

    // Debug danh sách discount
    if (discounts != null) {
        for (Discount d : discounts) {
            out.println("<!-- Debug - Discount: " + d.getCode() + ", Counter: " + d.getCounter() + ", MaxUsage: " + d.getMaxUsage() + " -->");
        }
    } else {
        out.println("<!-- Debug - Không có discount nào được tải -->");
    }

    // Chuẩn bị các giá trị để truyền vào JavaScript
    String safeProductName = productName != null ? productName : "Không có dữ liệu";
    String safeProductColor = productColor != null ? productColor : "Không có dữ liệu";
    String safeProductSize = productSize != null ? productSize : "Không có dữ liệu";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - davadoi.clo</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        :root {
            --primary-color: #000000;
            --secondary-color: #ffffff;
            --accent-color: #f5f5f5;
            --text-color: #333333;
            --border-color: #e0e0e0;
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: var(--text-color);
            background-color: var(--accent-color);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px 0;
        }
        
        .brand-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 15px 0;
            position: relative;
        }
        
        .brand-header a {
            font-size: 36px;
            font-weight: 600;
            color: var(--primary-color);
            text-decoration: none;
            letter-spacing: 2px;
            font-family: 'Cormorant Garamond', serif;
            transition: var(--transition);
            display: inline-block;
            position: relative;
        }
        
        .brand-header a::after {
            content: "";
            display: block;
            width: 0;
            height: 3px;
            background: var(--primary-color);
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            transition: width 0.3s ease-in-out;
        }
        
        .brand-header a:hover {
            transform: scale(1.05);
        }
        
        .brand-header a:hover::after {
            width: 100%;
        }
        
        .container {
            display: flex;
            flex-direction: column;
            background: var(--secondary-color);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1000px;
            padding: 20px;
        }
        
        @media (min-width: 768px) {
            .container {
                flex-direction: row;
            }
        }
        
        .left-section, .right-section {
            flex: 1;
            padding: 20px;
        }
        
        @media (min-width: 768px) {
            .right-section {
                border-left: 1px solid var(--border-color);
            }
        }
        
        h2 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        h3 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        p {
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            font-weight: 500;
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            transition: var(--transition);
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .btn-complete {
            background: var(--primary-color);
            color: var(--secondary-color);
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .btn-complete:hover {
            opacity: 0.9;
        }
        
        .promo-code {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .promo-code input {
            flex: 1;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
        }
        
        .promo-code button {
            background: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            transition: var(--transition);
        }
        
        .promo-code button:hover {
            opacity: 0.9;
        }
        
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: var(--secondary-color);
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 400px;
            z-index: 1000;
            text-align: center;
            font-family: 'Montserrat', sans-serif;
        }
        
        .popup h3 {
            margin-bottom: 15px;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .popup-content {
            font-size: 14px;
            margin-bottom: 15px;
            text-align: left;
        }
        
        .popup button {
            width: 100%;
            padding: 12px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            margin-top: 15px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            transition: var(--transition);
            background: var(--primary-color);
            color: var(--secondary-color);
        }
        
        .popup button:hover {
            opacity: 0.9;
        }
        
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        
        #bankTransferPopup img {
            width: 100%;
            max-width: 300px;
            margin-top: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
        }
        
        #successPopup button {
            background: var(--primary-color);
        }
        
        #successPopup button:hover {
            opacity: 0.9;
        }
        
        #bankTransferPopup .popup-content {
            text-align: center;
        }
        
        /* Add font imports */
        @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap');
    </style>
    <script>
        let appliedPromoDiscount = 0;
        let basePrice = <%= basePrice %>;
        let appliedPromoCode = ""; // Lưu mã giảm giá đã áp dụng
        // Truyền các giá trị từ JSP sang JavaScript
        let productName = "<%= safeProductName.replace("\"", "\\\"") %>";
        let productColor = "<%= safeProductColor.replace("\"", "\\\"") %>";
        let productSize = "<%= safeProductSize.replace("\"", "\\\"") %>";

        function updateShippingFee() {
            const city = document.getElementById("city").value;
            let shippingFee = (city === "HCM" || city === "HN" || city === "DN") ? 0 : 20000;
            document.getElementById("shippingFee").innerText = shippingFee.toLocaleString() + "₫";
            updateTotal();
        }

        function updateTotal() {
            let shippingFee = parseInt(document.getElementById("shippingFee").innerText.replace(/[^0-9]/g, ''));
            let total = basePrice + shippingFee - appliedPromoDiscount;
            
            document.getElementById("discountAmount").innerText = appliedPromoDiscount.toLocaleString() + "₫";
            document.getElementById("totalPrice").innerText = total.toLocaleString() + "₫";
        }

        function applyPromoCode() {
    let promoCode = document.getElementById("promoCode").value.toUpperCase().trim();
    let discountApplied = false;

    console.log("Applying promo code: " + promoCode); // Debug
    <% for (Discount discount : discounts) { %>
        if (promoCode === "<%= discount.getCode() %>") {
            console.log("Found matching code: <%= discount.getCode() %>, Active: <%= discount.isActive() %>, Counter: <%= discount.getCounter() %>, MaxUsage: <%= discount.getMaxUsage() %>"); // Debug
            if (!<%= discount.isActive() %>) {
                appliedPromoDiscount = 0;
            } else if (<%= discount.getCounter() %> >= <%= discount.getMaxUsage() %>) {
                appliedPromoDiscount = 0;
                alert("Mã giảm giá " + promoCode + " đã hết lượt sử dụng (" + <%= discount.getCounter() %> + "/" + <%= discount.getMaxUsage() %> + ")!");
            } else {
                <% if (discount.isPercentage()) { %>
                    appliedPromoDiscount = Math.floor(basePrice * <%= discount.getDiscountValue() %> / 100);
                    alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>%!");
                <% } else { %>
                    appliedPromoDiscount = <%= discount.getDiscountValue() %>;
                    alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>₫! ");
                <% } %>
                appliedPromoCode = promoCode;
                console.log("Applied Promo Code set to: " + appliedPromoCode); // Debug
                
                // Gửi request tăng counter
                fetch('<%= request.getContextPath() %>/discount', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'code=' + encodeURIComponent(promoCode) + '&updateCounter=true'
                })
                .then(response => {
                    console.log("Response status: " + response.status); // Debug
                    return response.text();
                })
                .then(data => {
                    console.log("Response data: " + data); // Debug
                    if (data.startsWith("success")) {
                        console.log("Counter updated successfully");
                    } else {
                        console.log("Failed to update counter: " + data);
                        alert(data);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("Đã xảy ra lỗi khi áp dụng mã giảm giá: " + error.message);
                });

                discountApplied = true;
            }
        }
    <% } %>

    if (!discountApplied) {
        appliedPromoDiscount = 0;
        appliedPromoCode = "";
        console.log("No valid promo code applied"); // Debug
        alert("Mã giảm giá không hợp lệ hoặc đã hết hiệu lực!");
    }
    updateTotal();
}

        function completeOrder() {
            let paymentMethod = document.getElementById("paymentMethod").value;
            let name = document.getElementById("name").value;
            let email = document.getElementById("email").value;
            let phone = document.getElementById("phone").value;
            let address = document.getElementById("address").value;
            let city = document.getElementById("city").options[document.getElementById("city").selectedIndex].text;
            let shippingFee = document.getElementById("shippingFee").innerText;
            let totalPrice = document.getElementById("totalPrice").innerText;

            if (!name || !email || !phone || !address) {
                alert("Vui lòng điền đầy đủ thông tin giao hàng!");
                return;
            }

            if (paymentMethod === "cod") {
                document.getElementById("popupName").innerText = name;
                document.getElementById("popupEmail").innerText = email;
                document.getElementById("popupPhone").innerText = phone;
                document.getElementById("popupAddress").innerText = address + ", " + city;
                document.getElementById("popupShippingFee").innerText = shippingFee;
                document.getElementById("popupTotalPrice").innerText = totalPrice;
                document.getElementById("popupDiscount").innerText = appliedPromoDiscount.toLocaleString() + "₫";
                document.getElementById("popupPromoCode").innerText = appliedPromoCode || "Không áp dụng";

                // Sử dụng các biến JavaScript đã định nghĩa
                document.getElementById("popupProduct").innerText = productName;
                document.getElementById("popupColor").innerText = productColor;
                document.getElementById("popupSize").innerText = productSize;

                document.getElementById("codPopup").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            } else if (paymentMethod === "bankTransfer") {
                document.getElementById("bankTransferPopup").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }
        }

        function confirmOrder() {
            if (appliedPromoCode) {
                console.log("Sending PATCH request for code: " + appliedPromoCode); // Debug
                fetch('discount', {
                    method: 'PATCH',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'code=' + encodeURIComponent(appliedPromoCode)
                })
                .then(response => {
                    console.log("Response status: " + response.status); // Debug
                    if (!response.ok) {
                        throw new Error("PATCH request failed with status: " + response.status);
                    }
                    return response.text();
                })
                .then(data => {
                    console.log("Server response: " + data); // Debug
                    document.getElementById("codPopup").style.display = "none";
                    document.getElementById("successPopup").style.display = "block";
                })
                .catch(error => {
                    console.error('Lỗi khi cập nhật counter:', error); // Debug
                    alert("Có lỗi xảy ra khi xác nhận đơn hàng: " + error.message);
                });
            } else {
                console.log("No promo code applied, skipping PATCH request"); // Debug
                document.getElementById("codPopup").style.display = "none";
                document.getElementById("successPopup").style.display = "block";
            }
        }

        function closeBankTransferPopup() {
            document.getElementById("bankTransferPopup").style.display = "none";
            document.getElementById("overlay").style.display = "none";
        }

        function goToHomePage() {
            window.location.href = "index.jsp";
        }

        window.onload = function() {
            updateShippingFee();
            updateTotal();
        }
    </script>
</head>
<body>
    <div class="brand-header">
        <a href="index.jsp">davadoi.clo</a>
    </div>
    <div class="container">
        <div class="left-section">
            <h2>Đơn hàng của bạn</h2>
            <p><b>Sản phẩm:</b> <%= productName != null ? productName : "Không có dữ liệu" %></p>
            <p><b>Màu:</b> <%= productColor != null ? productColor : "Không có dữ liệu" %></p>
            <p><b>Size:</b> <%= productSize != null ? productSize : "Không có dữ liệu" %></p>
            <p><b>Giá gốc:</b> <%= basePrice %>₫</p>
            <p><b>Giảm giá:</b> <span id="discountAmount">0₫</span></p>
            <p><b>Phí vận chuyển:</b> <span id="shippingFee">0₫</span></p>
            <h3><b>Tổng cộng: <span id="totalPrice">0₫</span></b></h3>
            <div class="promo-code">
                <input type="text" id="promoCode" placeholder="Nhập mã giảm giá">
                <button onclick="applyPromoCode()">Áp dụng</button>
            </div>
        </div>

        <div class="right-section">
            <h3>Thông tin giao hàng</h3>
            <div class="form-group">
                <label>Họ và Tên</label>
                <input type="text" id="name" placeholder="Nhập họ và tên">
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" id="email" placeholder="Nhập email">
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="text" id="phone" placeholder="Nhập số điện thoại">
            </div>
            <div class="form-group">
                <label>Địa chỉ</label>
                <input type="text" id="address" placeholder="Nhập địa chỉ">
            </div>
            <div class="form-group">
                <label>Chọn tỉnh/thành</label>
                <select id="city" onchange="updateShippingFee()">
                    <option value="HCM">Hồ Chí Minh</option>
                    <option value="HN">Hà Nội</option>
                    <option value="DN">Đà Nẵng</option>
                    <option value="other">Tỉnh khác</option>
                </select>
            </div>
            <div class="form-group">
                <label>Phương thức thanh toán</label>
                <select id="paymentMethod">
                    <option value="cod">COD (Thanh toán khi nhận hàng)</option>
                    <option value="bankTransfer">Chuyển khoản</option>
                </select>
            </div>
            <button class="btn-complete" onclick="completeOrder()">Hoàn tất đơn hàng</button>
        </div>
    </div>

    <!-- Popup xác nhận COD -->
    <div id="codPopup" class="popup">
        <h3>Xác nhận đơn hàng</h3>
        <div class="popup-content">
            <p><b>Sản phẩm:</b> <span id="popupProduct"></span></p>
            <p><b>Màu:</b> <span id="popupColor"></span></p>
            <p><b>Size:</b> <span id="popupSize"></span></p>
            <p><b>Họ và Tên:</b> <span id="popupName"></span></p>
            <p><b>Email:</b> <span id="popupEmail"></span></p>
            <p><b>Số điện thoại:</b> <span id="popupPhone"></span></p>
            <p><b>Địa chỉ:</b> <span id="popupAddress"></span></p>
            <p><b>Mã giảm giá:</b> <span id="popupPromoCode"></span></p>
            <p><b>Giảm giá:</b> <span id="popupDiscount"></span></p>
            <p><b>Phí vận chuyển:</b> <span id="popupShippingFee"></span></p>
            <p><b>Tổng cộng:</b> <span id="popupTotalPrice"></span></p>
        </div>
        <button onclick="confirmOrder()">Xác nhận</button>
    </div>

    <!-- Popup Đặt hàng thành công -->
    <div id="successPopup" class="popup">
        <h3>Đặt hàng thành công!</h3>
        <div class="popup-content">
            <p>Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được ghi nhận.</p>
        </div>
        <button onclick="goToHomePage()">Quay về trang chủ</button>
    </div>

    <!-- Popup Chuyển Khoản -->
    <div id="bankTransferPopup" class="popup">
        <h3>Thông tin chuyển khoản</h3>
        <div class="popup-content">
            <p>Vui lòng chuyển khoản theo thông tin dưới đây:</p>
            <img src="images/qr.png" alt="Thông tin chuyển khoản">
        </div>
        <button onclick="closeBankTransferPopup()">Đóng</button>
    </div>

    <!-- Overlay -->
    <div id="overlay"></div>
</body>
</html>