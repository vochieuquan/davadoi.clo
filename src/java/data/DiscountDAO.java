package data;

import model.Discount;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {
    private static Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Discount> getAllDiscounts() {
        List<Discount> discounts = new ArrayList<>();
        String sql = "SELECT * FROM Discount";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Discount discount = new Discount(
                    rs.getString("code"),
                    rs.getDouble("discountValue"),
                    rs.getBoolean("isPercentage"),
                    rs.getBoolean("isActive"),
                    rs.getInt("counter"),
                    rs.getInt("maxUsage")
                );
                discounts.add(discount);
            }
            System.out.println("DAO - Số mã giảm giá lấy được: " + discounts.size());
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy dữ liệu từ database: " + e.getMessage());
            e.printStackTrace();
        }
        return discounts;
    }

    public Discount getDiscountByCode(String code) {
        Discount discount = null;
        String sql = "SELECT * FROM Discount WHERE code = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    discount = new Discount(
                        rs.getString("code"),
                        rs.getDouble("discountValue"),
                        rs.getBoolean("isPercentage"),
                        rs.getBoolean("isActive"),
                        rs.getInt("counter"),
                        rs.getInt("maxUsage")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy mã giảm giá theo code: " + e.getMessage());
            e.printStackTrace();
        }
        return discount;
    }

    public boolean addDiscount(Discount discount) {
        String sql = "INSERT INTO Discount (code, discountValue, isPercentage, isActive, counter, maxUsage) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, discount.getCode());
            stmt.setDouble(2, discount.getDiscountValue());
            stmt.setBoolean(3, discount.isPercentage());
            stmt.setBoolean(4, discount.isActive());
            stmt.setInt(5, discount.getCounter());
            stmt.setInt(6, discount.getMaxUsage());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("DAO - Đã thêm mã giảm giá: " + discount.getCode());
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm mã giảm giá vào database: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateDiscount(Discount discount) {
        String sql = "UPDATE Discount SET discountValue=?, isPercentage=?, isActive=?, counter=?, maxUsage=? WHERE code=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, discount.getDiscountValue());
            stmt.setBoolean(2, discount.isPercentage());
            stmt.setBoolean(3, discount.isActive());
            stmt.setInt(4, discount.getCounter());
            stmt.setInt(5, discount.getMaxUsage());
            stmt.setString(6, discount.getCode());

            int rowsUpdated = stmt.executeUpdate();
            System.out.println("✅ Cập nhật thành công mã giảm giá: " + discount.getCode());
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi SQL khi cập nhật mã giảm giá: " + discount.getCode());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteDiscount(String code) {
        String sql = "DELETE FROM Discount WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);

            int rowsDeleted = stmt.executeUpdate();
            System.out.println("🗑️ Xóa thành công mã giảm giá: " + code);
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi SQL khi xóa mã giảm giá: " + code);
            e.printStackTrace();
            return false;
        }
    }

    public boolean isCodeExists(String code) {
        String sql = "SELECT COUNT(*) FROM Discount WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu có ít nhất 1 kết quả, mã đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật số lần sử dụng mã giảm giá
    public boolean incrementDiscountUsage(String code) {
        String sql = "UPDATE Discount SET counter = counter + 1 WHERE code = ? AND counter < maxUsage";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi khi cập nhật số lần sử dụng mã giảm giá: " + code);
            e.printStackTrace();
            return false;
        }
    }

    public boolean canUseDiscount(String code) {
        String sql = "SELECT counter, maxUsage FROM Discount WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int counter = rs.getInt("counter");
                int maxUsage = rs.getInt("maxUsage");
                return counter < maxUsage;
            }
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi khi kiểm tra số lần sử dụng mã giảm giá: " + code);
            e.printStackTrace();
        }
        return false;
    }
public boolean updateDiscounta(Discount discount) {
        String sql = "UPDATE discounts SET discountValue = ?, isPercentage = ?, isActive = ?, counter = ?, maxUsage = ? WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDouble(1, discount.getDiscountValue());
            pstmt.setBoolean(2, discount.isPercentage());
            pstmt.setBoolean(3, discount.isActive());
            pstmt.setInt(4, discount.getCounter()); // Đảm bảo cập nhật counter
            pstmt.setInt(5, discount.getMaxUsage());
            pstmt.setString(6, discount.getCode());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Các phương thức khác như getDiscountByCode, addDiscount, deleteDiscount...
    public Discount getDiscountByCodea(String code) {
        String sql = "SELECT * FROM discounts WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, code);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Discount(
                    rs.getString("code"),
                    rs.getDouble("discountValue"),
                    rs.getBoolean("isPercentage"),
                    rs.getBoolean("isActive"),
                    rs.getInt("counter"),
                    rs.getInt("maxUsage")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    // Test phương thức
    public static void main(String[] args) {
        DiscountDAO dao = new DiscountDAO();
        List<Discount> discounts = dao.getAllDiscounts();
        if (discounts.isEmpty()) {
            System.out.println("Không có mã giảm giá nào trong database!");
        } else {
            for (Discount d : discounts) {
                System.out.println(d.getCode() + " - " + d.getDiscountValue() + " - " + (d.isPercentage() ? "%" : "VNĐ") + " - " + (d.isActive() ? "Hoạt động" : "Không hoạt động") + " - " + d.getCounter() + "/" + d.getMaxUsage());
            }
        }
    }
}
