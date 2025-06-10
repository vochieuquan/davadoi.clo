package servlet;

import data.DiscountDAO;
import model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/discount")
public class DiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DiscountDAO discountDAO = new DiscountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        List<Discount> discounts = discountDAO.getAllDiscounts();
        request.setAttribute("discounts", discounts);
        request.getRequestDispatcher("discount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String toggleCode = request.getParameter("toggleCode");
        String deleteCode = request.getParameter("deleteCode");
        String code = request.getParameter("code");
        String updateCounter = request.getParameter("updateCounter");

        // Xử lý tăng counter khi khách hàng dùng mã
        if (code != null && updateCounter != null) {
            response.setContentType("text/plain;charset=UTF-8");
            Discount discount = discountDAO.getDiscountByCode(code);
            if (discount != null) {
                if (!discount.isActive()) {
                    response.getWriter().println("failed: Mã giảm giá đã bị vô hiệu hóa!");
                } else if (discount.getCounter() >= discount.getMaxUsage()) {
                    response.getWriter().println("failed: Mã giảm giá đã hết lượt sử dụng!");
                } else {
                    // Dùng incrementDiscountUsage thay vì updateDiscount
                    boolean success = discountDAO.incrementDiscountUsage(code);
                    if (success) {
                        response.getWriter().println("success");
                    } else {
                        response.getWriter().println("failed: Không thể tăng số lần sử dụng!");
                    }
                }
            } else {
                response.getWriter().println("failed: Không tìm thấy mã giảm giá!");
            }
            return;
        }

        // Giữ nguyên các chức năng khác
        if (toggleCode != null) {
            Discount discount = discountDAO.getDiscountByCode(toggleCode);
            if (discount != null) {
                discount.setActive(!discount.isActive());
                discountDAO.updateDiscount(discount); // Dùng updateDiscount cho admin
            }
            response.sendRedirect("discount");
            return;
        } 
        
        if (deleteCode != null) {
            discountDAO.deleteDiscount(deleteCode);
            response.sendRedirect("discount");
            return;
        } 
        
        if (code != null) {
            if (discountDAO.isCodeExists(code)) {
                request.setAttribute("errorMessage", "Mã giảm giá đã tồn tại!");
                request.getRequestDispatcher("discount.jsp").forward(request, response);
                return;
            }

            try {
                double discountValue = Double.parseDouble(request.getParameter("discountValue"));
                boolean isPercentage = request.getParameter("isPercentage") != null;
                boolean isActive = request.getParameter("isActive") != null;
                int maxUsage = Integer.parseInt(request.getParameter("maxUsage"));

                Discount discount = new Discount(code, discountValue, isPercentage, isActive, 0, maxUsage);
                discountDAO.addDiscount(discount);
                response.sendRedirect("discount");
            } catch (NumberFormatException e) {
                response.sendRedirect("discount.jsp?error=Dữ liệu không hợp lệ!");
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");
        Discount discount = discountDAO.getDiscountByCode(code);
        if (discount != null) {
            discount.setActive(!discount.isActive());
            boolean success = discountDAO.updateDiscount(discount); // Dùng updateDiscount cho admin
            response.getWriter().println(success ? "Cập nhật thành công!" : "Lỗi khi cập nhật!");
        } else {
            response.getWriter().println("Không tìm thấy mã giảm giá!");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");
        boolean success = discountDAO.deleteDiscount(code);
        response.getWriter().println(success ? "Xóa thành công!" : "Lỗi khi xóa!");
    }

    @Override
    protected void doPatch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");
        String code = request.getParameter("code");
        Discount discount = discountDAO.getDiscountByCode(code);
        if (discount != null) {
            if (!discount.isActive()) {
                response.getWriter().println("Mã giảm giá đã bị vô hiệu hóa!");
                return;
            }
            if (discount.getCounter() >= discount.getMaxUsage()) {
                discount.setActive(false);
                discountDAO.updateDiscount(discount); // Dùng updateDiscount cho admin
                response.getWriter().println("Mã giảm giá đã đạt số lần sử dụng tối đa và bị vô hiệu hóa!");
                return;
            }
            discount.setCounter(discount.getCounter() + 1);
            if (discount.getCounter() >= discount.getMaxUsage()) {
                discount.setActive(false);
            }
            discountDAO.updateDiscount(discount); // Dùng updateDiscount cho admin
            response.getWriter().println("Giảm giá đã được áp dụng! Số lần còn lại: " + (discount.getMaxUsage() - discount.getCounter()));
        } else {
            response.getWriter().println("Không tìm thấy mã giảm giá!");
        }
    }
}