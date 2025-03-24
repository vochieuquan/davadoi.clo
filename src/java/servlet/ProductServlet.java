package servlet;

import data.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        String role = (String) request.getSession().getAttribute("role");
        if ("admin".equalsIgnoreCase(role)) {
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("body.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String codeProduct = request.getParameter("codeProduct");
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String description = request.getParameter("description");

            Product product = new Product(0, productName, codeProduct, price, color, size, description);
            int productID = productDAO.addProduct(product);

            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/images/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String fileName = productID + ".png";
                String filePath = uploadPath + File.separator + fileName;
                try (InputStream input = filePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(filePath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }
            }
            response.sendRedirect("products");
            return;
        }

        if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productID"));
            System.out.println("🔍 Đang cập nhật sản phẩm có ID: " + productId);

            String name = request.getParameter("productName");
            String code = request.getParameter("codeProduct");
            double price = Double.parseDouble(request.getParameter("price"));
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String description = request.getParameter("description");

            Product product = new Product(productId, name, code, price, color, size, description);
            boolean updated = productDAO.updateProduct(product);

            if (updated) {
                response.sendRedirect("admin.jsp?success=update");
            } else {
                response.sendRedirect("admin.jsp?error=update");
            }
            return;
        }

        if ("delete".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productID"));
            System.out.println("🗑️ Đang xóa sản phẩm có ID: " + productId);

            String uploadPath = getServletContext().getRealPath("/images/");
            String fileName = productId + ".png";
            File productImage = new File(uploadPath + File.separator + fileName);
            if (productImage.exists()) {
                productImage.delete();
            }

            boolean deleted = productDAO.deleteProduct(productId);

            if (deleted) {
                response.sendRedirect("products?success=delete");
            } else {
                response.sendRedirect("products?error=delete");
            }
            return;
        }
    }
}