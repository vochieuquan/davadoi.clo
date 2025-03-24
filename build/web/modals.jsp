<%-- 
    Document   : modal
    Created on : Mar 12, 2025, 1:03:55 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- modals.jsp --%>
<div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="addProduct" method="post">
                    <div class="mb-3">
                        <label for="productName" class="form-label">Tên sản phẩm</label>
                        <input type="text" name="productName" id="productName" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Thêm</button>
                </form>
            </div>
        </div>
    </div>
</div>
