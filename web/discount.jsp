<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Discount" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Mã Giảm Giá | DAVADOI.CLO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
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
            background-color: var(--white);
            min-height: 100vh;
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            letter-spacing: 0.02em;
            color: var(--dark-gray);
        }
        
        .page-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .content-card {
            background: var(--white);
            padding: 40px;
            border: 1px solid var(--light-gray);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        
        .page-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 28px;
            letter-spacing: 0.1em;
            color: var(--black);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        .page-title::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 1px;
            background-color: var(--black);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .section-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 22px;
            letter-spacing: 0.05em;
            color: var(--black);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .btn-custom {
            background-color: var(--dark-gray);
            color: var(--white);
            border: none;
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            font-size: 13px;
            letter-spacing: 0.05em;
            padding: 8px 20px;
            border-radius: 0;
            transition: all 0.3s ease;
        }
        
        .btn-custom:hover {
            background-color: var(--black);
            color: var(--white);
        }
        
        .btn-secondary {
            background-color: var(--white);
            color: var(--dark-gray);
            border: 1px solid var(--dark-gray);
        }
        
        .btn-secondary:hover {
            background-color: var(--dark-gray);
            color: var(--white);
            border-color: var(--dark-gray);
        }
        
        .form-control {
            border-radius: 0;
            border: 1px solid var(--light-gray);
            padding: 10px 15px;
            font-size: 14px;
            font-weight: 300;
            color: var(--dark-gray);
        }
        
        .form-control:focus {
            box-shadow: none;
            border-color: var(--dark-gray);
        }
        
        .form-check-input {
            border-radius: 0;
            border: 1px solid var(--medium-gray);
        }
        
        .form-check-input:checked {
            background-color: var(--dark-gray);
            border-color: var(--dark-gray);
        }
        
        .form-check-label {
            font-size: 13px;
            color: var(--dark-gray);
        }
        
        .table {
            border: 1px solid var(--light-gray);
        }
        
        .table thead {
            background-color: var(--soft-beige);
            border-bottom: 1px solid var(--light-gray);
        }
        
        .table thead th {
            font-family: 'Montserrat', sans-serif;
            font-weight: 400;
            font-size: 13px;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            color: var(--dark-gray);
            padding: 15px;
        }
        
        .table tbody td {
            font-size: 14px;
            font-weight: 300;
            color: var(--dark-gray);
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .table tbody tr:hover {
            background-color: var(--off-white);
        }
        
        .badge {
            font-weight: 300;
            font-size: 12px;
            letter-spacing: 0.05em;
            padding: 6px 12px;
            border-radius: 0;
        }
        
        .badge-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .badge-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .action-btns .btn {
            margin: 0 5px;
            padding: 5px 10px;
            border-radius: 0;
            font-size: 12px;
        }
        
        .btn-toggle {
            background-color: var(--white);
            color: #856404;
            border: 1px solid #856404;
        }
        
        .btn-toggle:hover {
            background-color: #856404;
            color: var(--white);
        }
        
        .btn-delete {
            background-color: var(--white);
            color: #721c24;
            border: 1px solid #721c24;
        }
        
        .btn-delete:hover {
            background-color: #721c24;
            color: var(--white);
        }
        
        .alert {
            border-radius: 0;
            font-size: 14px;
            font-weight: 300;
            letter-spacing: 0.02em;
            padding: 15px;
            margin-bottom: 30px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: none;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: none;
        }
        
        .empty-message {
            text-align: center;
            padding: 30px;
            color: var(--medium-gray);
            font-style: italic;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            color: var(--dark-gray);
            font-size: 14px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            color: var(--black);
        }
        
        .back-link i {
            margin-right: 8px;
        }
        
        @media (max-width: 768px) {
            .content-card {
                padding: 30px 20px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            .section-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <div class="content-card">
            <h1 class="page-title">QUẢN LÝ MÃ GIẢM GIÁ</h1>
            
            <div class="text-end mb-4">
                <a href="home_admin.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Trở về Trang Quản Trị
                </a>
            </div>

            <!-- Thông báo thành công hoặc lỗi -->
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><%= errorMessage %>
                </div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= successMessage %>
                </div>
            <% } %>

            <!-- Form thêm mã giảm giá -->
            <h2 class="section-title">Thêm Mã Giảm Giá</h2>
            <form action="discount" method="post" class="mb-5">
                <div class="row g-3">
                    <div class="col-md-2">
                        <label class="form-label small">Mã giảm giá</label>
                        <input type="text" name="code" class="form-control" placeholder="Nhập mã" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small">Giá trị</label>
                        <input type="number" name="discountValue" step="0.01" class="form-control" placeholder="Nhập giá trị" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small">Giới hạn sử dụng</label>
                        <input type="number" name="maxUsage" min="1" class="form-control" placeholder="Số lần" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small">Tùy chọn</label>
                        <div class="form-check mt-2">
                            <input type="checkbox" class="form-check-input" name="isPercentage" id="isPercentage">
                            <label class="form-check-label" for="isPercentage">Giảm theo %</label>
                        </div>
                        <div class="form-check mt-2">
                            <input type="checkbox" class="form-check-input" name="isActive" id="isActive" checked>
                            <label class="form-check-label" for="isActive">Hoạt động</label>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small">&nbsp;</label>
                        <button type="submit" class="btn btn-custom w-100 mt-2">
                            <i class="fas fa-plus me-2"></i>Thêm Mã
                        </button>
                    </div>
                </div>
            </form>

            <!-- Danh sách mã giảm giá -->
            <h2 class="section-title">Danh sách Mã Giảm Giá</h2>
            <% List<Discount> discounts = (List<Discount>) request.getAttribute("discounts"); %>
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã</th>
                        <th>Giá trị</th>
                        <th>Loại</th>
                        <th>Số lần sử dụng</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (discounts != null && !discounts.isEmpty()) { %>
                        <% for (Discount d : discounts) { %>
                            <tr>
                                <td><strong><%= d.getCode() %></strong></td>
                                <td><%= d.getDiscountValue() %></td>
                                <td><%= d.isPercentage() ? "%" : "VNĐ" %></td>
                                <td><%= d.getCounter() %>/<%= d.getMaxUsage() %></td>
                                <td>
                                    <span class="badge <%= d.isActive() ? "badge-active" : "badge-inactive" %>">
                                        <%= d.isActive() ? "Hoạt động" : "Tắt" %>
                                    </span>
                                </td>
                                <td class="action-btns">
                                    <form action="discount" method="post" class="d-inline">
                                        <input type="hidden" name="toggleCode" value="<%= d.getCode() %>">
                                        <button type="submit" class="btn btn-toggle" title="Đổi trạng thái">
                                            <i class="fas fa-sync-alt"></i>
                                        </button>
                                    </form>
                                    <form action="discount" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa mã <%= d.getCode() %>?');">
                                        <input type="hidden" name="deleteCode" value="<%= d.getCode() %>">
                                        <button type="submit" class="btn btn-delete" title="Xóa mã">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr><td colspan="6" class="empty-message">Không có mã giảm giá nào.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>