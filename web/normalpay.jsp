<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Cart"%>
<%@page import="model.CartItem"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List, model.Discount, data.DiscountDAO"%>

<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
    
    String productName = request.getParameter("name");
    String productColor = request.getParameter("color");
    String productSize = request.getParameter("size");
    String productPrice = request.getParameter("price");
    String productId = request.getParameter("id");
    boolean isSingleProduct = productName != null && productColor != null && 
                            productSize != null && productPrice != null;

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    String contextPath = request.getContextPath();

    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    if (discounts == null) {
        DiscountDAO discountDAO = new DiscountDAO();
        discounts = discountDAO.getAllDiscounts();
    }
    Double appliedDiscount = (Double) session.getAttribute("appliedDiscount");
    if (appliedDiscount == null) {
        appliedDiscount = 0.0;
    }
    double standardShippingFee = 30000;
    double fastShippingFee = 50000;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - davadoi.clo</title>
    <link rel="stylesheet" href="<%= contextPath %>/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            --light-gray: #e0e0e0;
            --border-color: #e0e0e0;
            --success-color: #4a7c59;
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
            background-color: var(--light-bg);
            line-height: 1.6;
            font-weight: 300;
            letter-spacing: 0.02em;
        }
        
        .checkout-container {
            max-width: 1400px;
            margin: 80px auto 60px;
            padding: 0 20px;
            display: flex;
            gap: 40px;
        }
        
        .checkout-main {
            flex: 3;
        }
        
        .checkout-sidebar {
            flex: 2;
            position: sticky;
            top: 100px;
            height: fit-content;
        }
        
        .checkout-section {
            background: var(--secondary-color);
            border-radius: 4px;
            padding: 35px;
            margin-bottom: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.03);
            transition: transform 0.3s ease;
        }
        
        .section-title {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            color: var(--primary-color);
        }
        
        .section-title h3 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 500;
            font-size: 24px;
            letter-spacing: 0.05em;
            margin-left: 15px;
        }
        
        .section-title i {
            font-size: 18px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 400;
            color: var(--text-color);
            font-size: 14px;
        }
        
        .form-group input, 
        .form-group select {
            width: 100%;
            padding: 14px;
            border: 1px solid var(--border-color);
            border-radius: 2px;
            font-size: 14px;
            font-family: 'Montserrat', sans-serif;
            transition: var(--transition);
            background-color: var(--secondary-color);
        }
        
        .form-group input:focus, 
        .form-group select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.05);
        }
        
        .payment-methods, 
        .shipping-methods {
            display: grid;
            gap: 15px;
        }
        
        .method-item {
            display: flex;
            align-items: center;
            padding: 16px;
            border: 1px solid var(--border-color);
            border-radius: 2px;
            cursor: pointer;
            transition: var(--transition);
            font-size: 14px;
        }
        
        .method-item:hover {
            border-color: var(--primary-color);
            background-color: var(--light-bg);
        }
        
        .method-item input[type="radio"] {
            margin-right: 15px;
            accent-color: var(--primary-color);
        }
        
        .order-summary {
            background: var(--secondary-color);
            padding: 35px;
            border-radius: 4px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.03);
        }
        
        .order-item {
            display: flex;
            padding: 20px 0;
            border-bottom: 1px solid var(--border-color);
        }
        
        .order-item-image {
            width: 90px;
            height: 120px;
            object-fit: cover;
            border-radius: 2px;
            margin-right: 20px;
            background-color: var(--light-bg);
        }
        
        .order-item-details {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        
        .order-item-name {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 500;
            font-size: 16px;
            margin-bottom: 8px;
            letter-spacing: 0.05em;
        }
        
        .order-item-variant {
            color: var(--medium-gray);
            font-size: 13px;
            margin-bottom: 10px;
        }
        
        .order-item-price {
            color: var(--primary-color);
            font-weight: 500;
            font-size: 15px;
            align-self: flex-end;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid var(--border-color);
            font-size: 14px;
        }
        
        .total-row.discount {
            color: var(--success-color);
        }
        
        .final-total {
            font-size: 18px;
            font-weight: 500;
            color: var(--primary-color);
            padding-top: 20px;
            letter-spacing: 0.05em;
        }
        
        .promo-code {
            margin: 25px 0;
            display: flex;
            gap: 10px;
        }
        
        .promo-code input {
            flex: 1;
            padding: 14px;
            border: 1px solid var(--border-color);
            border-radius: 2px;
            font-size: 14px;
            font-family: 'Montserrat', sans-serif;
        }
        
        .promo-code input:focus {
            border-color: var(--primary-color);
            outline: none;
        }
        
        .promo-code button {
            padding: 0 20px;
            background: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            border-radius: 2px;
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        
        .promo-code button:hover {
            background: #333;
        }
        
        .btn-complete {
            width: 100%;
            padding: 16px;
            background: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            border-radius: 2px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            letter-spacing: 0.1em;
            text-transform: uppercase;
            font-family: 'Montserrat', sans-serif;
            margin-top: 10px;
        }
        
        .btn-complete:hover {
            background: #333;
        }
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            backdrop-filter: blur(3px);
        }
        
        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: var(--secondary-color);
            padding: 40px;
            border-radius: 4px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-header {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 25px;
            text-align: center;
            letter-spacing: 0.05em;
        }
        
        .modal-body p {
            margin: 10px 0;
            line-height: 1.8;
            font-size: 14px;
        }
        
        .modal-body p strong {
            font-weight: 500;
        }
        
        .modal-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .modal-footer button {
            padding: 12px 25px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        
        .modal-footer .confirm-btn {
            background: var(--primary-color);
            color: var(--secondary-color);
        }
        
        .modal-footer .confirm-btn:hover {
            background: #333;
        }
        
        .modal-footer .cancel-btn {
            background: #f8f8f8;
            color: var(--primary-color);
            border: 1px solid var(--border-color);
        }
        
        .modal-footer .cancel-btn:hover {
            background: #eee;
        }
        
        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .close-btn:hover {
            opacity: 0.7;
        }
        
        /* Responsive styles */
        @media (max-width: 992px) {
            .checkout-container {
                flex-direction: column;
                margin-top: 60px;
            }
            
            .checkout-sidebar {
                position: static;
            }
        }
        
        @media (max-width: 768px) {
            .checkout-section, 
            .order-summary {
                padding: 25px;
            }
            
            .section-title h3 {
                font-size: 20px;
            }
            
            .modal-content {
                padding: 25px;
                width: 95%;
            }
        }
        
        @media (max-width: 576px) {
            .checkout-container {
                padding: 0 15px;
                margin-top: 40px;
            }
            
            .order-item-image {
                width: 70px;
                height: 90px;
            }
            
            .promo-code {
                flex-direction: column;
            }
            
            .promo-code button {
                padding: 12px;
            }
            
            .modal-footer {
                flex-direction: column;
                gap: 10px;
            }
            
            .modal-footer button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="checkout-container">
        <div class="checkout-main">
            <form id="checkoutForm" action="<%= contextPath %>/order" method="POST" onsubmit="return handleSubmit(event)">
                <div class="checkout-section">
                    <div class="section-title">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>Địa Chỉ Nhận Hàng</h3>
                    </div>
                    <div class="form-group">
                        <label>Họ và Tên</label>
                        <input type="text" name="fullName" id="fullName" placeholder="Nhập họ và tên" required>
                    </div>
                    <div class="form-group">
                        <label>Số Điện Thoại</label>
                        <input type="tel" name="phone" id="phone" placeholder="Nhập số điện thoại" required pattern="[0-9]{10}">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" id="email" placeholder="Nhập email" required>
                    </div>
                    <div class="form-group">
                        <label>Địa Chỉ</label>
                        <input type="text" name="address" id="address" placeholder="Ví dụ: 123 Đường ABC, Quận XYZ, TP HCM" required>
                    </div>
                </div>

                <div class="checkout-section">
                    <div class="section-title">
                        <i class="fas fa-truck"></i>
                        <h3>Phương Thức Vận Chuyển</h3>
                    </div>
                    <div class="shipping-methods">
                        <label class="method-item">
                            <input type="radio" name="shippingMethod" value="standard" checked onchange="updateShippingFee()">
                            Giao hàng tiêu chuẩn (2-3 ngày) - <%= currencyFormatter.format(standardShippingFee) %>
                        </label>
                        <label class="method-item">
                            <input type="radio" name="shippingMethod" value="fast" onchange="updateShippingFee()">
                            Giao hàng nhanh (1-2 ngày) - <%= currencyFormatter.format(fastShippingFee) %>
                        </label>
                    </div>
                </div>

                <div class="checkout-section">
                    <div class="section-title">
                        <i class="fas fa-wallet"></i>
                        <h3>Phương Thức Thanh Toán</h3>
                    </div>
                    <div class="payment-methods">
                        <label class="method-item">
                            <input type="radio" name="paymentMethod" value="cod" checked>
                            Thanh toán khi nhận hàng (COD)
                        </label>
                        <label class="method-item">
                            <input type="radio" name="paymentMethod" value="bank">
                            Chuyển khoản ngân hàng
                        </label>
                        <label class="method-item">
                            <input type="radio" name="paymentMethod" value="momo">
                            Ví MoMo
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn-complete">
                    Đặt Hàng (<%= isSingleProduct ? 1 : cart.getItemCount() %> sản phẩm)
                </button>
            </form>
        </div>

        <div class="checkout-sidebar">
            <div class="order-summary">
                <div class="section-title">
                    <i class="fas fa-shopping-bag"></i>
                    <h3>Đơn Hàng</h3>
                </div>
                <div class="order-items">
                    <% if (isSingleProduct) { %>
                        <div class="order-item">
                            <img src="images/<%= productId %>.png" 
                                 alt="<%= productName %>" 
                                 class="order-item-image"
                                 onerror="this.src='<%= contextPath %>/web/images/default.png'">
                            <div class="order-item-details">
                                <div>
                                    <div class="order-item-name"><%= productName %></div>
                                    <div class="order-item-variant">
                                        <%= productColor %>, Size: <%= productSize %>, Số lượng: 1
                                    </div>
                                </div>
                                <div class="order-item-price">
                                    <%= currencyFormatter.format(Double.parseDouble(productPrice)) %>
                                </div>
                            </div>
                        </div>
                    <% } else { %>
                        <% for (CartItem item : cart.getItems()) { %>
                            <div class="order-item">
                                <img src="images/<%= item.getProduct().getProductID() %>.png" 
                                     alt="<%= item.getProduct().getProductName() %>" 
                                     class="order-item-image"
                                     onerror="this.src='<%= contextPath %>/web/images/default.png'">
                                <div class="order-item-details">
                                    <div>
                                        <div class="order-item-name"><%= item.getProduct().getProductName() %></div>
                                        <div class="order-item-variant">
                                            <%= item.getProduct().getColor() %>, Size: <%= item.getSelectedSize() %>, Số lượng: <%= item.getQuantity() %>
                                        </div>
                                    </div>
                                    <div class="order-item-price">
                                        <%= currencyFormatter.format(item.getSubtotal()) %>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    <% } %>
                </div>

                <div class="promo-code">
                    <input type="text" id="promoCode" placeholder="Nhập mã giảm giá">
                    <button onclick="applyPromoCode()">Áp dụng</button>
                </div>

                <div class="order-total">
                    <div class="total-row">
                        <span>Tạm tính</span>
                        <span id="subtotal"><%= currencyFormatter.format(isSingleProduct ? Double.parseDouble(productPrice) : cart.getTotal()) %></span>
                    </div>
                    <div class="total-row">
                        <span>Phí vận chuyển</span>
                        <span id="shippingFee"><%= currencyFormatter.format(standardShippingFee) %></span>
                    </div>
                    <div class="total-row discount">
                        <span>Giảm giá</span>
                        <span id="discountAmount"><%= currencyFormatter.format(appliedDiscount) %></span>
                    </div>
                    <div class="total-row final-total">
                        <span>Tổng cộng</span>
                        <span id="finalTotal">
                            <%= currencyFormatter.format((isSingleProduct ? Double.parseDouble(productPrice) : cart.getTotal()) + standardShippingFee - appliedDiscount) %>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal" id="orderModal">
        <div class="modal-content">
            <div class="modal-header">Xác nhận đơn hàng</div>
            <div class="modal-body" id="modalBody"></div>
            <div class="modal-footer">
                <button class="confirm-btn" onclick="submitOrder()">Xác nhận</button>
                <button class="cancel-btn" onclick="closeModal()">Hủy</button>
            </div>
        </div>
    </div>

    <script>
        let cartTotal = <%= isSingleProduct ? Double.parseDouble(productPrice) : cart.getTotal() %>;
        let shippingFee = <%= standardShippingFee %>;
        let appliedDiscount = <%= appliedDiscount %>;
        const standardShippingFee = <%= standardShippingFee %>;
        const fastShippingFee = <%= fastShippingFee %>;
        let formSubmitted = false;

        function updateTotal() {
            let total = cartTotal + shippingFee - appliedDiscount;
            document.getElementById("shippingFee").innerText = shippingFee.toLocaleString('vi-VN') + "₫";
            document.getElementById("discountAmount").innerText = appliedDiscount.toLocaleString('vi-VN') + "₫";
            document.getElementById("finalTotal").innerText = total.toLocaleString('vi-VN') + "₫";
        }

        function updateShippingFee() {
            let selectedMethod = document.querySelector('input[name="shippingMethod"]:checked').value;
            shippingFee = (selectedMethod === "fast") ? fastShippingFee : standardShippingFee;
            updateTotal();
        }

        function applyPromoCode() {
            let promoCode = document.getElementById("promoCode").value.trim().toUpperCase();
            let discountApplied = false;

            console.log("Applying promo code: " + promoCode); // Debug
            <% for (Discount discount : discounts) { %>
                if (promoCode === "<%= discount.getCode() %>") {
                    console.log("Found matching code: <%= discount.getCode() %>, Active: <%= discount.isActive() %>, Counter: <%= discount.getCounter() %>, MaxUsage: <%= discount.getMaxUsage() %>"); // Debug
                    if (!<%= discount.isActive() %>) {
                        appliedDiscount = 0;
                        alert("Mã giảm giá " + promoCode + " đã bị tắt!");
                    } else if (<%= discount.getCounter() %> >= <%= discount.getMaxUsage() %>) {
                        appliedDiscount = 0;
                        alert("Mã giảm giá " + promoCode + " đã hết lượt sử dụng!");
                    } else {
                        <% if (discount.isPercentage()) { %>
                            appliedDiscount = Math.floor(cartTotal * <%= discount.getDiscountValue() %> / 100);
                            alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>%! ");
                        <% } else { %>
                            appliedDiscount = <%= discount.getDiscountValue() %>;
                            alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>₫! ");
                        <% } %>

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
                                alert("Lỗi khi cập nhật số lần sử dụng mã giảm giá: " + data);
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
                appliedDiscount = 0;
                alert("Mã giảm giá không hợp lệ hoặc đã hết hạn!");
            }

            // Gửi appliedDiscount về server
            let xhr = new XMLHttpRequest();
            xhr.open("POST", "<%= request.getContextPath() %>/cart/applyDiscount", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("discount=" + appliedDiscount);

            updateTotal();
        }

        function handleSubmit(event) {
            event.preventDefault();
            let paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            if (paymentMethod === "cod" && !formSubmitted) {
                showOrderConfirmation();
                return false;
            }
            return true;
        }

        function showOrderConfirmation() {
            let fullName = document.getElementById("fullName").value;
            let phone = document.getElementById("phone").value;
            let email = document.getElementById("email").value;
            let address = document.getElementById("address").value;
            let shippingMethod = document.querySelector('input[name="shippingMethod"]:checked').value;
            let shippingMethodText = (shippingMethod === "fast") ? "Giao hàng nhanh (1-2 ngày)" : "Giao hàng tiêu chuẩn (2-3 ngày)";

            let orderString = "Thông tin giao hàng:\n" +
                "Họ và tên: " + fullName + "\n" +
                "Số điện thoại: " + phone + "\n" +
                "Email: " + email + "\n" +
                "Địa chỉ: " + address + "\n" +
                "Phương thức vận chuyển: " + shippingMethodText + "\n" +
                "Phương thức thanh toán: Thanh toán khi nhận hàng (COD)\n" +
                "Sản phẩm:\n";

            <% if (isSingleProduct) { %>
                orderString += "- <%= productName %> (<%= productColor %>, Size: <%= productSize %>, Số lượng: 1): " +
                    "<%= currencyFormatter.format(Double.parseDouble(productPrice)) %>\n";
            <% } else { %>
                <% for (CartItem item : cart.getItems()) { %>
                    orderString += "- <%= item.getProduct().getProductName() %> " +
                        "(<%= item.getProduct().getColor() %>, Size: <%= item.getSelectedSize() %>, Số lượng: <%= item.getQuantity() %>): " +
                        "<%= currencyFormatter.format(item.getSubtotal()) %>\n";
                <% } %>
            <% } %>

            orderString += "Chi tiết thanh toán:\n" +
                "Tạm tính: " + cartTotal.toLocaleString('vi-VN') + "₫\n" +
                "Phí vận chuyển: " + shippingFee.toLocaleString('vi-VN') + "₫\n" +
                "Giảm giá: " + appliedDiscount.toLocaleString('vi-VN') + "₫\n" +
                "Tổng cộng: " + (cartTotal + shippingFee - appliedDiscount).toLocaleString('vi-VN') + "₫";

            let formData = 'orderDetails=' + encodeURIComponent(orderString) +
                '&orderDate=' + encodeURIComponent(new Date().toISOString());

            fetch('<%= request.getContextPath() %>/api/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    let orderDetails = "<p><strong>Thông tin giao hàng:</strong></p>" +
                        "<p>Họ và tên: " + fullName + "</p>" +
                        "<p>Số điện thoại: " + phone + "</p>" +
                        "<p>Email: " + email + "</p>" +
                        "<p>Địa chỉ: " + address + "</p>" +
                        "<p>Phương thức vận chuyển: " + shippingMethodText + "</p>" +
                        "<p>Phương thức thanh toán: Thanh toán khi nhận hàng (COD)</p>" +
                        "<p><strong>Sản phẩm:</strong></p>";

                    <% if (isSingleProduct) { %>
                        orderDetails += "<p>- <%= productName %> (<%= productColor %>, Size: <%= productSize %>, Số lượng: 1): " +
                            "<%= currencyFormatter.format(Double.parseDouble(productPrice)) %></p>";
                    <% } else { %>
                        <% for (CartItem item : cart.getItems()) { %>
                            orderDetails += "<p>- <%= item.getProduct().getProductName() %> " +
                                "(<%= item.getProduct().getColor() %>, Size: <%= item.getSelectedSize() %>, Số lượng: <%= item.getQuantity() %>): " +
                                "<%= currencyFormatter.format(item.getSubtotal()) %></p>";
                        <% } %>
                    <% } %>

                    orderDetails += "<p><strong>Chi tiết thanh toán:</strong></p>" +
                        "<p>Tạm tính: " + cartTotal.toLocaleString('vi-VN') + "₫</p>" +
                        "<p>Phí vận chuyển: " + shippingFee.toLocaleString('vi-VN') + "₫</p>" +
                        "<p>Giảm giá: " + appliedDiscount.toLocaleString('vi-VN') + "₫</p>" +
                        "<p><strong>Tổng cộng: " + (cartTotal + shippingFee - appliedDiscount).toLocaleString('vi-VN') + "₫</strong></p>";

                    document.getElementById("modalBody").innerHTML = orderDetails;
                    document.getElementById("orderModal").style.display = "block";
                } else {
                    alert("Có lỗi khi lưu đơn hàng!");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Có lỗi khi kết nối đến server!");
            });
        }

        function submitOrder() {
            formSubmitted = true;
            document.getElementById("checkoutForm").submit();
        }

        function closeModal() {
            document.getElementById("orderModal").style.display = "none";
        }

        window.onload = function() {
            updateTotal();
        };
    </script>

    <%@ include file="footer.jsp" %>
</body>
</html>