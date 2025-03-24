package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;
    
    public Cart() {
        this.items = new ArrayList<>();
    }
    
    public List<CartItem> getItems() {
        return items;
    }
    
    public void addItem(Product product, int quantity, String selectedSize) {
        // Check if product already exists with same size
        for (CartItem item : items) {
            if (item.getProduct().getProductID() == product.getProductID() 
                && item.getSelectedSize().equals(selectedSize)) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        // If not found, add new item
        items.add(new CartItem(product, quantity, selectedSize));
    }
    
    public void removeItem(int productId, String selectedSize) {
        items.removeIf(item -> 
            item.getProduct().getProductID() == productId 
            && item.getSelectedSize().equals(selectedSize));
    }
    
    public void updateQuantity(int productId, String selectedSize, int quantity) {
        for (CartItem item : items) {
            if (item.getProduct().getProductID() == productId 
                && item.getSelectedSize().equals(selectedSize)) {
                item.setQuantity(quantity);
                return;
            }
        }
    }
    
    public void clear() {
        items.clear();
    }
    
    public int getItemCount() {
        return items.stream().mapToInt(CartItem::getQuantity).sum();
    }
    
    public double getTotal() {
        return items.stream().mapToDouble(CartItem::getSubtotal).sum();
    }
} 