<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng | DAVADOI.CLO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --black: #000000;
            --white: #ffffff;
            --off-white: #f9f9f9;
            --light-gray: #e6e6e6;
            --medium-gray: #767676;
            --dark-gray: #333333;
            --soft-beige: #f8f7f5;
            --primary: #4a6741;
            --primary-light: #eef2ed;
            --accent: #d4b78f;
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
            background-color: var(--off-white);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1300px;
            margin: 40px auto;
            padding: 0;
            display: flex;
            gap: 30px;
        }
        
        .left-section {
            flex: 2;
            background-color: var(--white);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        
        .right-section {
            flex: 1;
            background-color: var(--white);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        
        h1 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
            font-size: 32px;
            letter-spacing: 0.1em;
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        h1::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 2px;
            background-color: var(--accent);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            font-size: 18px;
            color: var(--primary);
            margin-bottom: 20px;
            border-bottom: 1px solid var(--light-gray);
            padding-bottom: 10px;
        }
        
        .back-btn {
            display: inline-flex;
            align-items: center;
            margin-bottom: 30px;
            padding: 12px 24px;
            background-color: var(--white);
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 400;
            letter-spacing: 0.05em;
            border: 1px solid var(--primary);
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            background-color: var(--primary);
            color: var(--white);
        }
        
        .back-btn i {
            margin-right: 10px;
        }
        
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
        }
        
        th, td {
            padding: 16px;
            text-align: left;
        }
        
        th {
            background-color: var(--primary-light);
            color: var(--primary);
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        
        td {
            color: var(--dark-gray);
            font-size: 14px;
            font-weight: 300;
            border-bottom: 1px solid var(--light-gray);
        }
        
        tr:last-child td {
            border-bottom: none;
        }
        
        tr:hover td {
            background-color: var(--off-white);
        }
        
        .message {
            text-align: center;
            color: #721c24;
            font-size: 14px;
            font-weight: 300;
            margin: 20px 0;
            padding: 20px;
            background-color: #f8d7da;
            border-radius: 8px;
            border-left: 4px solid #721c24;
        }
        
        .summary-item {
            margin: 20px 0;
            font-size: 14px;
            background-color: var(--primary-light);
            padding: 15px;
            border-radius: 8px;
        }
        
        .summary-item span {
            display: block;
            margin-bottom: 5px;
        }
        
        .summary-item .value {
            font-weight: 600;
            color: var(--primary);
            font-size: 18px;
        }
        
        .status-breakdown {
            margin-top: 30px;
        }
        
        .status-breakdown .item {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin: 12px 0;
            padding: 10px;
            border-radius: 6px;
            background-color: var(--off-white);
        }
        
        .details-btn {
            color: var(--primary);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            padding: 6px 12px;
            background-color: var(--primary-light);
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .details-btn:hover {
            background-color: var(--primary);
            color: var(--white);
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(3px);
        }
        
        .modal-content {
            background-color: var(--white);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
        }
        
        .modal-content pre {
            margin: 0;
            white-space: pre-wrap;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            font-weight: 400;
            color: var(--dark-gray);
            line-height: 1.6;
            background-color: var(--off-white);
            padding: 15px;
            border-radius: 6px;
        }
        
        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            color: var(--medium-gray);
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .close-btn:hover {
            color: var(--primary);
        }
        
        select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--light-gray);
            border-radius: 5px;
            background-color: var(--white);
            color: var(--dark-gray);
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            font-weight: 400;
            cursor: pointer;
            transition: all 0.3s;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23333333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px;
        }
        
        select:hover, select:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 2px rgba(74, 103, 65, 0.1);
        }
        
        .status-pending {
            color: #856404;
            background-color: #fff3cd;
            border-color: #ffeeba;
        }
        
        .status-processing {
            color: #0c5460;
            background-color: #d1ecf1;
            border-color: #bee5eb;
        }
        
        .status-shipping {
            color: #004085;
            background-color: #cce5ff;
            border-color: #b8daff;
        }
        
        .status-delivered {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        
        .order-id {
            font-weight: 500;
            color: var(--primary);
        }
        
        .date-column {
            white-space: nowrap;
            color: var(--medium-gray);
            font-weight: 400;
        }
        
        @media (max-width: 992px) {
            .container {
                flex-direction: column;
                margin: 20px;
                padding: 0;
            }
            
            .left-section, .right-section {
                padding: 25px;
            }
        }
        
        @media (max-width: 768px) {
            h1 {
                font-size: 26px;
            }
            
            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }
            
            .back-btn {
                padding: 10px 16px;
                font-size: 13px;
            }
            
            .summary-item {
                padding: 12px;
            }
            
            .modal-content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-section">
            <h1>DANH SÁCH ĐƠN HÀNG</h1>
            <a href="<%= request.getContextPath() %>/home_admin.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Quay lại trang quản trị
            </a>
            <%
                System.out.println("orders.jsp: Bắt đầu xử lý JSP");
                String message = (String) request.getAttribute("message");
                List<Order> orders = (List<Order>) request.getAttribute("orders");

                if (message == null && orders == null) {
                    System.out.println("orders.jsp: Không có dữ liệu, chuyển hướng tới /api/orders");
                    response.sendRedirect(request.getContextPath() + "/api/orders");
                } else {
                    System.out.println("orders.jsp: Message từ servlet: " + (message != null ? message : "null"));
                    System.out.println("orders.jsp: Orders từ servlet: " + (orders != null ? orders.size() + " đơn hàng" : "null"));

                    if (message != null) {
                        System.out.println("orders.jsp: Hiển thị message - " + message);
                        out.println("<p class='message'>" + message + "</p>");
                    } else if (orders != null && !orders.isEmpty()) {
                        System.out.println("orders.jsp: Có " + orders.size() + " đơn hàng để hiển thị");
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                        
                        // Biến để tính tổng tiền và đếm khách hàng
                        double grandTotal = 0.0;
                        Map<String, Integer> customerCount = new HashMap<>();
                        Map<String, Double> customerTotal = new HashMap<>();
                        Map<String, Integer> statusCount = new HashMap<>();

                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>Khách hàng</th><th>Tổng tiền</th><th>Ngày đặt hàng</th><th>Trạng thái </th><th>Xem chi tiết đơn hàng</th></tr>");
                        for (Order order : orders) {
                            System.out.println("orders.jsp: Xử lý Order ID=" + order.getId());
                            String formattedDate = "N/A";
                            try {
                                if (order.getOrderDate() != null) {
                                    formattedDate = sdf.format(order.getOrderDate());
                                }
                            } catch (Exception e) {
                                System.out.println("orders.jsp: Lỗi format ngày cho ID=" + order.getId() + " - " + e.getMessage());
                            }
                            
                            // Xử lý regex để lấy tên và tổng tiền
                            String orderDetails = order.getOrderDetails() != null ? order.getOrderDetails() : "";
                            
                            // Regex lấy tên
                            String namePattern = "Họ và tên:\\s*([\\p{L}\\p{M}\\s]+?)\\s*Số điện thoại:";
Pattern nameRegex = Pattern.compile(namePattern);
Matcher nameMatcher = nameRegex.matcher(orderDetails);
String customerName = "N/A";
if (nameMatcher.find()) {
    customerName = nameMatcher.group(1).trim();
}

                            
                            // Regex lấy tổng tiền
                            String totalPattern = "Tổng cộng: ([\\d.]+)₫";
                            Pattern totalRegex = Pattern.compile(totalPattern);
                            Matcher totalMatcher = totalRegex.matcher(orderDetails);
                            String totalAmount = "N/A";
                            double totalValue = 0.0;
                            if (totalMatcher.find()) {
                                totalAmount = totalMatcher.group(1) + "₫";
                                try {
                                    totalValue = Double.parseDouble(totalMatcher.group(1).replace(".", ""));
                                    grandTotal += totalValue;
                                } catch (NumberFormatException e) {
                                    System.out.println("orders.jsp: Lỗi parse tổng tiền cho ID=" + order.getId());
                                }
                            }
                            
                            // Cập nhật thống kê khách hàng
                            customerCount.put(customerName, customerCount.getOrDefault(customerName, 0) + 1);
                            customerTotal.put(customerName, customerTotal.getOrDefault(customerName, 0.0) + totalValue);

                            // Cập nhật thống kê trạng thái
                            String currentStatus = order.getStatus() != null ? order.getStatus() : "N/A";
                            statusCount.put(currentStatus, statusCount.getOrDefault(currentStatus, 0) + 1);

                            String statusClass = "";
                            if ("Đang chờ xác nhận".equals(currentStatus)) {
                                statusClass = "status-pending";
                            } else if ("Đang đóng gói".equals(currentStatus)) {
                                statusClass = "status-processing";
                            } else if ("Đang giao".equals(currentStatus)) {
                                statusClass = "status-shipping";
                            } else if ("Đã giao thành công".equals(currentStatus)) {
                                statusClass = "status-delivered";
                            }
                            
                            out.println("<tr>");
                            out.println("<td><span class='order-id'>#" + order.getId() + "</span></td>");
                            out.println("<td>" + customerName + "</td>");
                            out.println("<td>" + totalAmount + "</td>");
                            out.println("<td class='date-column'>" + formattedDate + "</td>");
                            out.println("<td>");
                            out.println("<select class='" + statusClass + "' onchange=\"updateStatus(" + order.getId() + ", this.value)\">");
                            out.println("<option value='Đang chờ xác nhận'" + ("Đang chờ xác nhận".equals(currentStatus) ? " selected" : "") + ">Đang chờ xác nhận</option>");
                            out.println("<option value='Đang đóng gói'" + ("Đang đóng gói".equals(currentStatus) ? " selected" : "") + ">Đang đóng gói</option>");
                            out.println("<option value='Đang giao'" + ("Đang giao".equals(currentStatus) ? " selected" : "") + ">Đang giao</option>");
                            out.println("<option value='Đã giao thành công'" + ("Đã giao thành công".equals(currentStatus) ? " selected" : "") + ">Đã giao thành công</option>");
                            out.println("</select>");
                            out.println("</td>");
                            out.println("<td><a href='javascript:void(0)' class='details-btn' onclick=\"showDetails('" + order.getId() + "')\">Xem chi tiết</a></td>");
                            out.println("</tr>");
                            // Hidden div for modal content
                            out.println("<div id='modal-" + order.getId() + "' class='modal'>");
                            out.println("<div class='modal-content'>");
                            out.println("<span class='close-btn' onclick=\"closeModal('" + order.getId() + "')\">&times;</span>");
                            out.println("<h2>Chi tiết đơn hàng #" + order.getId() + "</h2>");
                            out.println("<pre>" + (order.getOrderDetails() != null ? order.getOrderDetails() : "N/A") + "</pre>");
                            out.println("</div>");
                            out.println("</div>");
                        }
                        out.println("</table>");

                        // Tìm khách hàng mua nhiều nhất
                        String topCustomer = "N/A";
                        int maxOrders = 0;
                        double maxTotal = 0.0;
                        String topCustomerByTotal = "N/A";
                        for (Map.Entry<String, Integer> entry : customerCount.entrySet()) {
                            String name = entry.getKey();
                            int count = entry.getValue();
                            double total = customerTotal.getOrDefault(name, 0.0);
                            if (count > maxOrders) {
                                maxOrders = count;
                                topCustomer = name;
                            }
                            if (total > maxTotal) {
                                maxTotal = total;
                                topCustomerByTotal = name;
                            }
                        }
            %>
        </div>
        <div class="right-section">
            <h2>Thống kê đơn hàng</h2>
            <div class="summary-item">
                <span>Tổng doanh thu</span>
                <span class="value"><%= String.format("%,.0f", grandTotal) %>₫</span>
            </div>
            <div class="summary-item">
                <span>Khách hàng đặt nhiều đơn nhất</span>
                <span class="value"><%= topCustomer %> (<%= maxOrders %> đơn)</span>
            </div>
            <div class="summary-item">
                <span>Khách hàng chi tiêu nhiều nhất</span>
                <span class="value"><%= topCustomerByTotal %> (<%= String.format("%,.0f", maxTotal) %>₫)</span>
            </div>
            <div class="status-breakdown">
                <h2>Trạng thái đơn hàng</h2>
                <div class="item">
                    <span>Đang chờ xác nhận</span>
                    <span><%= statusCount.getOrDefault("Đang chờ xác nhận", 0) %> (<%= orders.size() > 0 ? String.format("%.0f", (statusCount.getOrDefault("Đang chờ xác nhận", 0) * 100.0 / orders.size())) : 0 %>%)</span>
                </div>
                <div class="item">
                    <span>Đang đóng gói</span>
                    <span><%= statusCount.getOrDefault("Đang đóng gói", 0) %> (<%= orders.size() > 0 ? String.format("%.0f", (statusCount.getOrDefault("Đang đóng gói", 0) * 100.0 / orders.size())) : 0 %>%)</span>
                </div>
                <div class="item">
                    <span>Đang giao</span>
                    <span><%= statusCount.getOrDefault("Đang giao", 0) %> (<%= orders.size() > 0 ? String.format("%.0f", (statusCount.getOrDefault("Đang giao", 0) * 100.0 / orders.size())) : 0 %>%)</span>
                </div>
                <div class="item">
                    <span>Đã giao thành công</span>
                    <span><%= statusCount.getOrDefault("Đã giao thành công", 0) %> (<%= orders.size() > 0 ? String.format("%.0f", (statusCount.getOrDefault("Đã giao thành công", 0) * 100.0 / orders.size())) : 0 %>%)</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showDetails(orderId) {
            const modal = document.getElementById('modal-' + orderId);
            modal.style.display = 'flex';
        }

        function closeModal(orderId) {
            const modal = document.getElementById('modal-' + orderId);
            modal.style.display = 'none';
        }

        // Đóng modal khi bấm ra ngoài nội dung
        window.onclick = function(event) {
            const modals = document.getElementsByClassName('modal');
            for (let i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = 'none';
                }
            }
        }

        function updateStatus(orderId, newStatus) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "<%= request.getContextPath() %>/api/orders", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        console.log("Cập nhật trạng thái thành công cho Order ID=" + orderId);
                        const select = event.target;
                        select.className = '';
                        if (newStatus === 'Đang chờ xác nhận') {
                            select.classList.add('status-pending');
                        } else if (newStatus === 'Đang đóng gói') {
                            select.classList.add('status-processing');
                        } else if (newStatus === 'Đang giao') {
                            select.classList.add('status-shipping');
                        } else if (newStatus === 'Đã giao thành công') {
                            select.classList.add('status-delivered');
                        }
                    } else {
                        console.error("Lỗi khi cập nhật trạng thái: " + xhr.responseText);
                        alert("Lỗi khi cập nhật trạng thái!");
                    }
                }
            };
            xhr.send("action=updateStatus&orderId=" + orderId + "&status=" + encodeURIComponent(newStatus));
        }
    </script>
</body>
</html>
<% } else {
    System.out.println("orders.jsp: Không có đơn hàng hoặc orders là null");
    out.println("<p class='message'>Không có đơn hàng để hiển thị.</p>");
}
}
%>