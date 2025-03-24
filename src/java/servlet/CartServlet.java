package servlet;

import java.io.IOException;
import model.Cart;
import model.Product;
import data.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/view";
        }
        
        switch (action) {
            case "/view":
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                break;
            case "/remove":
                removeFromCart(request, response);
                break;
            case "/update":
                updateCart(request, response);
                break;
            case "/clear":
                clearCart(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/add";
        }
        
        switch (action) {
            case "/add":
                addToCart(request, response);
                break;
            case "/update":
                updateCart(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                break;
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String selectedSize = request.getParameter("size");
            int quantity = 1; // Default quantity
            
            Product product = productDAO.getProductById(productId);
            if (product != null && selectedSize != null && !selectedSize.isEmpty()) {
                cart.addItem(product, quantity, selectedSize);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"cartCount\": " + cart.getItemCount() + "}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid product or size\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid product ID\"}");
        }
    }
    
    private void viewCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String selectedSize = request.getParameter("size");
                cart.removeItem(productId, selectedSize);
            } catch (NumberFormatException e) {
                // Handle invalid product ID
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            try {
                java.util.Enumeration<String> paramNames = request.getParameterNames();
                while (paramNames.hasMoreElements()) {
                    String paramName = paramNames.nextElement();
                    if (paramName.startsWith("quantity_")) {
                        String[] parts = paramName.split("_");
                        if (parts.length == 3) {
                            int productId = Integer.parseInt(parts[1]);
                            String size = parts[2];
                            int quantity = Integer.parseInt(request.getParameter(paramName));
                            if (quantity > 0) {
                                cart.updateQuantity(productId, size, quantity);
                            } else {
                                cart.removeItem(productId, size);
                            }
                        }
                    }
                }
            } catch (NumberFormatException e) {
                // Handle invalid numbers
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.clear();
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
} 