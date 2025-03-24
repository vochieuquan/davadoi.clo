package servlet;

import data.DatabaseConnection;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password");
        
        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu bằng SHA-256
        String hashedPassword = hashPassword(password);
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn == null) {
                request.setAttribute("error", "Không thể kết nối database!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String sql = "SELECT username, user_role, status FROM userss WHERE username = ? AND password_hash = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, hashedPassword);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String status = rs.getString("status");

                        if (!"active".equalsIgnoreCase(status)) {
                            request.setAttribute("error", "Tài khoản chưa được kích hoạt hoặc bị khóa!");
                            request.setAttribute("username", username);
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                            return;
                        }

                        // Đăng nhập thành công, tạo session
                        HttpSession session = request.getSession();
                        session.setAttribute("username", rs.getString("username"));
                        String userRole = rs.getString("user_role");
                        session.setAttribute("role", userRole);

                        // Phân hướng dựa trên role
                        if ("admin".equalsIgnoreCase(userRole)) {
                            response.sendRedirect("home_admin.jsp"); // Trang dành cho admin
                        } else if ("customer".equalsIgnoreCase(userRole)) {
                            response.sendRedirect("index.jsp"); // Trang dành cho khách hàng
                        } else {
                            // Trường hợp role không xác định
                            request.setAttribute("error", "Vai trò người dùng không hợp lệ!");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        }
                    } else {
                        // Sai thông tin đăng nhập
                        request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
                        request.setAttribute("username", username);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

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