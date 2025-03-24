package data;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Order;

@WebServlet("/api/orders")
public class OrderServlet2 extends HttpServlet {
    
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("OrderServlet2: Đã nhận GET request tại /api/orders");
        try {
            List<Order> orders = orderDAO.getAllOrders();
            System.out.println("OrderServlet2: Số đơn hàng lấy được: " + (orders != null ? orders.size() : 0));
            if (orders == null || orders.isEmpty()) {
                request.setAttribute("message", "Không có đơn hàng nào trong database.");
            } else {
                request.setAttribute("orders", orders);
            }
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("OrderServlet2: Lỗi SQL - " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu: " + e.getMessage());
        }
    }

    // Thêm phương thức để cập nhật trạng thái
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("updateStatus".equals(action)) {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");
            System.out.println("OrderServlet2: Cập nhật trạng thái cho Order ID=" + orderId + " thành " + newStatus);
            orderDAO.updateOrderStatus(orderId, newStatus);
            response.setContentType("text/plain");
            response.getWriter().write("Cập nhật trạng thái thành công");
        } catch (SQLException e) {
            System.out.println("OrderServlet2: Lỗi SQL khi cập nhật trạng thái - " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật trạng thái: " + e.getMessage());
        }
    } else {
        String orderDetails = request.getParameter("orderDetails");
        String orderDate = request.getParameter("orderDate");
        try {
            orderDAO.saveOrder(orderDetails, orderDate);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Order created successfully");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error creating order: " + e.getMessage());
        }
    }
}
}