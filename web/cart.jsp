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
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

    // Lấy danh sách discount từ Servlet hoặc trực tiếp từ DAO
    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    if (discounts == null) {
        DiscountDAO discountDAO = new DiscountDAO();
        discounts = discountDAO.getAllDiscounts();
    }

    // Lấy giá trị giảm giá đã áp dụng từ session (nếu có)
    Double appliedDiscount = (Double) session.getAttribute("appliedDiscount");
    if (appliedDiscount == null) {
        appliedDiscount = 0.0;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        .cart-table th, .cart-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cart-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .product-info img {
            width: 100px;
            height: auto;
        }
        .quantity-input {
            width: 60px;
            padding: 5px;
            text-align: center;
        }
        .remove-btn {
            color: #dc3545;
            text-decoration: none;
            font-weight: bold;
        }
        .cart-summary {
            float: right;
            width: 300px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .cart-summary h3 {
            margin-top: 0;
        }
        .cart-total {
            font-size: 1.2em;
            font-weight: bold;
            margin: 15px 0;
        }
        .checkout-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #000;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .checkout-btn:hover {
            background-color: #333;
        }
        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }
        .continue-shopping {
            display: inline-block;
            padding: 12px 24px;
            background-color: #000000;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        .continue-shopping:hover {
            background-color: #333333;
        }
        .promo-code {
            margin: 15px 0;
            display: flex;
            gap: 10px;
        }
        .promo-code input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .promo-code button {
            background: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .promo-code button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="cart-container">
        <% if (cart.getItems().isEmpty()) { %>
            <div class="empty-cart">
                <h2>Giỏ hàng của bạn đang trống</h2>
                <a href="index.jsp" class="continue-shopping">Tiếp tục mua sắm</a>
            </div>
        <% } else { %>
            <form action="cart/update" method="post" id="updateCartForm">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart.getItems()) { %>
                            <tr>
                                <td>
                                    <div class="product-info">
                                        <img src="images/<%= item.getProduct().getProductID() %>.png" 
                                             alt="<%= item.getProduct().getProductName() %>">
                                        <div>
                                            <h4><%= item.getProduct().getProductName() %></h4>
                                            <p>Size: <%= item.getSelectedSize() %></p>
                                            <p>Màu: <%= item.getProduct().getColor() %></p>
                                        </div>
                                    </div>
                                </td>
                                <td><%= currencyFormatter.format(item.getProduct().getPrice()) %></td>
                                <td>
                                    <input type="number" 
                                           name="quantity_<%= item.getProduct().getProductID() %>_<%= item.getSelectedSize() %>" 
                                           value="<%= item.getQuantity() %>" 
                                           min="1" 
                                           class="quantity-input"
                                           onchange="updateQuantity(this)">
                                </td>
                                <td><%= currencyFormatter.format(item.getSubtotal()) %></td>
                                <td>
                                    <a href="cart/remove?productId=<%= item.getProduct().getProductID() %>&size=<%= item.getSelectedSize() %>" 
                                       class="remove-btn"
                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">×</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </form>

            <div style="clear: both; width: 100%; margin-top: 20px; padding: 20px; background-color: #f8f9fa; border-radius: 5px;">
                <h3>Tổng giỏ hàng</h3>
                <p>Tổng tiền hàng: <%= currencyFormatter.format(cart.getTotal()) %></p>
                <p class="cart-total">Tổng cộng: <span id="totalAmount"><%= currencyFormatter.format(cart.getTotal() - appliedDiscount) %></span></p>
                
                
                
                <a href="normalpay.jsp" class="checkout-btn" 
                   style="display: block; width: 100%; padding: 10px; background-color: #000; color: #fff; text-align: center; text-decoration: none; border: none; border-radius: 5px; cursor: pointer;">
                   THANH TOÁN
                </a>
            </div>
        <% } %>
    </div>

    <script>
        let appliedPromoDiscount = <%= appliedDiscount %>;
        let cartTotal = <%= cart.getTotal() %>;

        function updateTotal() {
            let total = cartTotal - appliedPromoDiscount;
            document.getElementById("discountAmount").innerText = appliedPromoDiscount.toLocaleString('vi-VN') + "₫";
            document.getElementById("totalAmount").innerText = total.toLocaleString('vi-VN') + "₫";
        }

        function applyPromoCode() {
            let promoCode = document.getElementById("promoCode").value.toUpperCase().trim();
            let discountApplied = false;

            <% for (Discount discount : discounts) { %>
                if (promoCode === "<%= discount.getCode() %>" && <%= discount.isActive() %>) {
                    <% if (discount.isPercentage()) { %>
                        appliedPromoDiscount = Math.floor(cartTotal * <%= discount.getDiscountValue() %> / 100);
                        alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>%!");
                    <% } else { %>
                        appliedPromoDiscount = <%= discount.getDiscountValue() %>;
                        alert("Áp dụng mã giảm giá thành công: Giảm <%= discount.getDiscountValue() %>₫!");
                    <% } %>
                    discountApplied = true;
                }
            <% } %>

            if (!discountApplied) {
                appliedPromoDiscount = 0;
                alert("Mã giảm giá không hợp lệ hoặc đã hết hiệu lực!");
            }

            // Lưu giá trị giảm giá vào session qua AJAX
            let xhr = new XMLHttpRequest();
            xhr.open("POST", "cart/applyDiscount", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("discount=" + appliedPromoDiscount);

            updateTotal();
        }

        function updateQuantity(input) {
            if (input.value > 0) {
                document.getElementById('updateCartForm').submit();
            }
        }

        window.onload = function() {
            updateTotal();
        };
    </script>

    <%@ include file="footer.jsp" %>
</body>
</html>