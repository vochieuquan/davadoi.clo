package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Cart;

@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if this is a single product purchase
        String productName = request.getParameter("name");
        String productColor = request.getParameter("color");
        String productSize = request.getParameter("size");
        String productPrice = request.getParameter("price");
        boolean isSingleProduct = productName != null && productColor != null && productSize != null && productPrice != null;
        
        if (!isSingleProduct) {
            // Clear the shopping cart
            session.removeAttribute("cart");
        }
        
        // Set success message
        session.setAttribute("paymentMessage", "Thanh toán thành công!");
        
        // Redirect to homepage
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
} 