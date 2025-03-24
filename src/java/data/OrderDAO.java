package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDAO {

    public void saveOrder(String orderDetails, String orderDate) throws SQLException {
        String sql = "INSERT INTO orders (order_details, order_date, status) VALUES (?, ?, N'pending')";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, orderDetails);
            pstmt.setTimestamp(2, new java.sql.Timestamp(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(orderDate).getTime()));
            
            pstmt.executeUpdate();
            System.out.println("Đã lưu đơn hàng thành công!");
        } catch (Exception e) {
            throw new SQLException("Lỗi khi lưu đơn hàng: " + e.getMessage(), e);
        }
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, order_details, order_date, status FROM orders";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getLong("id"));
                order.setOrderDetails(rs.getString("order_details"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        }
        return orders;
    }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
    String sql = "UPDATE orders SET status = ? WHERE id = ?";
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, status);
        stmt.setInt(2, orderId);
        int rowsAffected = stmt.executeUpdate();
        System.out.println("Đã cập nhật trạng thái cho Order ID=" + orderId + ", rows affected: " + rowsAffected);
    } catch (SQLException e) {
        throw new SQLException("Lỗi khi cập nhật trạng thái: " + e.getMessage(), e);
    }
}

    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
        try {
            List<Order> orders = orderDAO.getAllOrders();
            if (orders.isEmpty()) {
                System.out.println("Không có đơn hàng nào trong database.");
            } else {
                System.out.println("Danh sách đơn hàng:");
                for (Order order : orders) {
                    System.out.println("ID: " + order.getId());
                    System.out.println("Chi tiết đơn hàng: " + order.getOrderDetails());
                    System.out.println("Ngày đặt hàng: " + order.getOrderDate());
                    System.out.println("Trạng thái: " + order.getStatus());
                    System.out.println("-------------------");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy dữ liệu: " + e.getMessage());
        }
    }
}