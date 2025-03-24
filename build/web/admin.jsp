<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Product" %>
<%@page import="data.ProductDAO" %>

<% 
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || sessionCheck.getAttribute("role") == null || !"admin".equalsIgnoreCase((String) sessionCheck.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
    if (products == null) {
        products = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm | DAVADOI.CLO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        }
        
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--white);
            padding: 15px 30px;
            color: var(--black);
            box-shadow: 0px 1px 10px rgba(0, 0, 0, 0.05);
            border-bottom: 1px solid var(--light-gray);
        }
        
        .navbar a {
            text-decoration: none;
            color: var(--dark-gray);
            font-weight: 400;
            font-size: 14px;
            letter-spacing: 0.05em;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .navbar a:hover {
            color: var(--black);
        }
        
        .navbar span {
            font-family: 'Cormorant Garamond', serif;
            font-size: 20px;
            font-weight: 400;
            letter-spacing: 0.1em;
            color: var(--black);
        }
        
        .content {
            padding: 40px 0;
        }
        
        .btn-add {
            background-color: var(--dark-gray);
            border: none;
            color: var(--white);
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            font-size: 13px;
            letter-spacing: 0.05em;
            padding: 10px 20px;
            border-radius: 0;
            transition: all 0.3s ease;
        }
        
        .btn-add:hover {
            background-color: var(--black);
        }
        
        .category-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 24px;
            letter-spacing: 0.1em;
            color: var(--black);
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
        }
        
        .category-title::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 1px;
            background-color: var(--black);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .product-card {
            border: none;
            border-radius: 0;
            box-shadow: 0px 3px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            overflow: hidden;
        }
        
        .product-card:hover {
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
            transform: translateY(-5px);
        }
        
        .product-card img {
            object-fit: cover;
            height: 250px;
            border-radius: 0;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .card-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 18px;
            letter-spacing: 0.05em;
            color: var(--black);
            margin-bottom: 10px;
        }
        
        .price {
            font-weight: 400;
            color: var(--medium-gray);
            margin-bottom: 10px;
        }
        
        .card-text {
            font-size: 13px;
            color: var(--medium-gray);
            margin-bottom: 5px;
        }
        
        .btn-sm {
            font-size: 12px;
            letter-spacing: 0.05em;
            padding: 6px 12px;
            border-radius: 0;
            font-weight: 300;
        }
        
        .btn-warning {
            background-color: var(--white);
            color: var(--dark-gray);
            border: 1px solid var(--dark-gray);
        }
        
        .btn-warning:hover {
            background-color: var(--dark-gray);
            color: var(--white);
            border-color: var(--dark-gray);
        }
        
        .btn-danger {
            background-color: var(--white);
            color: #d32f2f;
            border: 1px solid #d32f2f;
        }
        
        .btn-danger:hover {
            background-color: #d32f2f;
            color: var(--white);
            border-color: #d32f2f;
        }
        
        .modal-content {
            border-radius: 0;
            border: none;
        }
        
        .modal-header {
            border-bottom: 1px solid var(--light-gray);
            padding: 20px 30px;
        }
        
        .modal-title {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 400;
            font-size: 20px;
            letter-spacing: 0.05em;
            color: var(--black);
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .form-label {
            font-size: 13px;
            color: var(--dark-gray);
            font-weight: 400;
            letter-spacing: 0.05em;
        }
        
        .form-control {
            border-radius: 0;
            padding: 10px 15px;
            font-size: 14px;
            border: 1px solid var(--light-gray);
            font-weight: 300;
        }
        
        .form-control:focus {
            box-shadow: none;
            border-color: var(--dark-gray);
        }
        
        .btn-primary {
            background-color: var(--dark-gray);
            border: none;
            color: var(--white);
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            font-size: 13px;
            letter-spacing: 0.05em;
            padding: 10px 20px;
            border-radius: 0;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: var(--black);
        }
        
        .category-section {
            margin-bottom: 60px;
            padding-bottom: 40px;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .category-section:last-child {
            border-bottom: none;
        }
        
        .empty-category {
            text-align: center;
            padding: 30px;
            color: var(--medium-gray);
            font-style: italic;
        }
        
        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 10px;
            }
            
            .product-card img {
                height: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="home_admin.jsp"><i class="fas fa-arrow-left"></i> Trở về Trang Quản Trị</a>
        <span>QUẢN LÝ SẢN PHẨM</span>
        <div></div> <!-- Empty div for flex spacing -->
    </div>

    <div class="container my-5 content">
        <div class="text-end mb-5">
            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addProductModal">
                <i class="fas fa-plus me-2"></i> Thêm sản phẩm
            </button>
        </div>

        <% String[] categories = {"TS", "BT", "JE", "AC"}; %>
        <% for (String category : categories) { %>
            <div class="category-section">
                <div class="text-center mb-4">
                    <h3 class="category-title">
                        <% if (category.equals("TS")) { %>T-SHIRTS<% } %>
                        <% if (category.equals("BT")) { %>BOTTOMS<% } %>
                        <% if (category.equals("JE")) { %>JEWELRY<% } %>
                        <% if (category.equals("AC")) { %>ACCESSORIES<% } %>
                    </h3>
                </div>
                
                <div class="row">
                    <% 
                    boolean hasProducts = false;
                    for (Product p : products) {
                        if (p.getCodeProduct() != null && p.getCodeProduct().startsWith(category)) { 
                            hasProducts = true;
                    %>
                        <div class="col-md-3 col-sm-6">
                            <div class="card product-card">
                                <img src="images/<%= p.getProductID() %>.png" class="card-img-top" alt="<%= p.getProductName() %>">
                                <div class="card-body text-center">
                                    <h5 class="card-title"><%= p.getProductName() %></h5>
                                    <p class="price"><%= String.format("%,.0f", p.getPrice()) %>₫</p>
                                    <p class="card-text">Màu: <%= p.getColor() %></p>
                                    <p class="card-text">Size: <%= p.getSize() %></p>
                                    <div class="mt-3">
                                        <button type="button" class="btn btn-warning btn-sm me-2" 
                                                data-bs-toggle="modal" data-bs-target="#editProductModal"
                                                data-id="<%= p.getProductID() %>"
                                                data-code="<%= p.getCodeProduct() %>"
                                                data-name="<%= p.getProductName() %>"
                                                data-price="<%= p.getPrice() %>"
                                                data-color="<%= p.getColor() %>"
                                                data-size="<%= p.getSize() %>"
                                                data-description="<%= p.getDescription() != null ? p.getDescription() : "" %>">
                                            <i class="fas fa-edit me-1"></i> Chỉnh sửa
                                        </button>
                                        <form action="products" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="productID" value="<%= p.getProductID() %>">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                                <i class="fas fa-trash-alt me-1"></i> Xóa
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% 
                        } 
                    }
                    if (!hasProducts) { 
                    %>
                        <div class="col-12 empty-category">
                            <p>Không có sản phẩm nào trong danh mục này</p>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Modal Thêm Sản Phẩm -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addProductForm" action="products" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" name="productName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã Sản Phẩm</label>
                            <input type="text" class="form-control" name="codeProduct" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá</label>
                            <input type="number" class="form-control" name="price" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Màu</label>
                            <input type="text" class="form-control" name="color">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Size</label>
                            <input type="text" class="form-control" name="size">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô Tả</label>
                            <textarea class="form-control" name="description"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ảnh Sản Phẩm</label>
                            <input type="file" class="form-control" name="productImage" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Thêm Sản Phẩm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Chỉnh Sửa Sản Phẩm -->
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh Sửa Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProductForm" action="products" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editProductID" name="productID">
                        <div class="mb-3">
                            <label for="editProductName" class="form-label">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" id="editProductName" name="productName" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCodeProduct" class="form-label">Mã Sản Phẩm</label>
                            <input type="text" class="form-control" id="editCodeProduct" name="codeProduct" required>
                        </div>
                        <div class="mb-3">
                            <label for="editPrice" class="form-label">Giá</label>
                            <input type="number" class="form-control" id="editPrice" name="price" required>
                        </div>
                        <div class="mb-3">
                            <label for="editColor" class="form-label">Màu</label>
                            <input type="text" class="form-control" id="editColor" name="color">
                        </div>
                        <div class="mb-3">
                            <label for="editSize" class="form-label">Size</label>
                            <input type="text" class="form-control" id="editSize" name="size">
                        </div>
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Mô Tả</label>
                            <textarea class="form-control" id="editDescription" name="description"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var editProductModal = document.getElementById('editProductModal');
            if (!editProductModal) {
                console.error("Không tìm thấy modal #editProductModal trong DOM");
                return;
            }
            editProductModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                if (!button) return;

                document.getElementById('editProductID').value = button.getAttribute('data-id') || '';
                document.getElementById('editProductName').value = button.getAttribute('data-name') || '';
                document.getElementById('editCodeProduct').value = button.getAttribute('data-code') || '';
                document.getElementById('editPrice').value = button.getAttribute('data-price') || '';
                document.getElementById('editColor').value = button.getAttribute('data-color') || '';
                document.getElementById('editSize').value = button.getAttribute('data-size') || '';
                document.getElementById('editDescription').value = button.getAttribute('data-description') || '';
            });
        });
    </script>
</body>
</html>