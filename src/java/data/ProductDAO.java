package data;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection(); // Đảm bảo class này hoạt động
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("productID"),
                    rs.getString("productName"),
                    rs.getString("codeProduct"),
                    rs.getDouble("price"),
                    rs.getString("color"),
                    rs.getString("size"),
                    rs.getString("description")
                );
                products.add(product);
            }
            System.out.println("DAO - Số sản phẩm lấy được: " + products.size());
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy dữ liệu từ database: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT * FROM Product WHERE productID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("codeProduct"),
                        rs.getDouble("price"),
                        rs.getString("color"),
                        rs.getString("size"),
                        rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return product;
    }

    public int addProduct(Product product) {
        String sql = "INSERT INTO Product (productName, codeProduct, price, color, size, description) VALUES (?, ?, ?, ?, ?, ?)";
        int generatedId = -1;
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCodeProduct());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getColor());
            stmt.setString(5, product.getSize());
            stmt.setString(6, product.getDescription() != null ? product.getDescription() : null);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                        product.setProductID(generatedId);
                    }
                }
                System.out.println("DAO - Đã thêm sản phẩm: " + product.getProductName() + " với ID: " + generatedId);
            } else {
                System.err.println("DAO - Không thể thêm sản phẩm!");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm sản phẩm vào database: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET productName=?, codeProduct=?, price=?, color=?, size=?, description=? WHERE productID=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCodeProduct());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getColor());
            stmt.setString(5, product.getSize());
            stmt.setString(6, product.getDescription());
            stmt.setInt(7, product.getProductID());

            int rowsUpdated = stmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                System.out.println("✅ Cập nhật thành công sản phẩm ID: " + product.getProductID());
            } else {
                System.out.println("❌ Không tìm thấy sản phẩm ID: " + product.getProductID());
            }
            
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi SQL khi cập nhật sản phẩm ID: " + product.getProductID());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM Product WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            
            int rowsDeleted = stmt.executeUpdate();
            
            if (rowsDeleted > 0) {
                System.out.println("🗑️ Xóa thành công sản phẩm ID: " + productId);
            } else {
                System.out.println("❌ Không tìm thấy sản phẩm ID: " + productId + " để xóa");
            }
            
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("🚨 Lỗi SQL khi xóa sản phẩm ID: " + productId);
            e.printStackTrace();
            return false;
        }
    }

    // Test phương thức
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();
        if (products.isEmpty()) {
            System.out.println("Không có sản phẩm nào trong database!");
        } else {
            for (Product p : products) {
                System.out.println(p.getProductName() + " - " + p.getPrice() + " - " + p.getColor() + " - " + p.getSize());
            }
        }
    }
}