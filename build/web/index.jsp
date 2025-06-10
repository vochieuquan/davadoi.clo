<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Cart" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>davadoi.clo - Trang chủ</title>
        <link rel="stylesheet" href="styles.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .payment-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 15px 25px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 1000;
            animation: slideIn 0.5s ease-out;
            font-weight: 500;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <%
        // Initialize or clear cart if payment was successful
        String paymentMessage = (String) session.getAttribute("paymentMessage");
        if (paymentMessage != null) {
            session.removeAttribute("paymentMessage");
        }
    %>

    <%@ include file="header.jsp" %>

    <% if (paymentMessage != null) { %>
        <div class="payment-message" id="paymentMessage">
            <%= paymentMessage %>
        </div>
    <% } %>
    
    
    <%@ include file="body.jsp" %>
    <!-- Your existing index.jsp content here -->

    <%@ include file="footer.jsp" %>

    <script>
        // Remove the payment message after 3 seconds
        document.addEventListener('DOMContentLoaded', function() {
            var message = document.querySelector('#paymentMessage');
            if (message) {
                setTimeout(function() {
                    message.style.opacity = '0';
                    message.style.transition = 'opacity 0.5s ease-out';
                    setTimeout(function() {
                        message.remove();
                    }, 500);
                }, 3000);
            }
        });
    </script>
</body>
</html> 