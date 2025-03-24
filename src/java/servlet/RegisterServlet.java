package servlet;

import data.DatabaseConnection;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        String userRole = "customer"; // Mặc định là khách hàng

        // Kiểm tra dữ liệu nhập vào
        if (firstName.isEmpty() || lastName.isEmpty() || gender.isEmpty() || dob.isEmpty() ||
            username.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = hashPassword(password);

        // Chuyển đổi ngày sinh sang kiểu SQL Date
        Date sqlDob;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = sdf.parse(dob);
            sqlDob = new Date(parsedDate.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn == null) {
                request.setAttribute("error", "Không thể kết nối database!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra username hoặc email đã tồn tại chưa
            String checkUserSql = "SELECT 1 FROM userss WHERE username = ? OR email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkUserSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại!");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Chèn dữ liệu mới vào bảng userss
            String sql = "INSERT INTO userss (first_name, last_name, gender, dob, username, email, password_hash, user_role, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'active')";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, gender);
                stmt.setDate(4, sqlDob);
                stmt.setString(5, username);
                stmt.setString(6, email);
                stmt.setString(7, hashedPassword);
                stmt.setString(8, userRole);
                
                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    request.setAttribute("success", "Đăng ký thành công!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Đăng ký thất bại!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi SQL: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // Hàm mã hóa mật khẩu SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi mã hóa mật khẩu", e);
        }
    }
}