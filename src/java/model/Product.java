package model;
public class Product {
    private int productID;
    private String productName;
    private String codeProduct;
    private double price;
    private String color;
    private String size;
    private String description;

    // Constructor đầy đủ
    public Product(int productID, String productName, String codeProduct, double price, String color, String size, String description) {
        this.productID = productID;
        this.productName = productName;
        this.codeProduct = codeProduct;
        this.price = price;
        this.color = color;
        this.size = size;
        this.description = description;
    }

    // Getter và Setter đầy đủ
    public int getProductID() { return productID; }
    public String getProductName() { return productName; }
    public String getCodeProduct() { return codeProduct; }
    public double getPrice() { return price; }
    public String getColor() { return color; }
    public String getSize() { return size; }
    public String getDescription() { return description; }
    
    public void setProductID(int productID) { this.productID = productID; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setCodeProduct(String codeProduct) { this.codeProduct = codeProduct; }
    public void setPrice(double price) { this.price = price; }
    public void setColor(String color) { this.color = color; }
    public void setSize(String size) { this.size = size; }
    public void setDescription(String description) { this.description = description; }

    // Debug toString để kiểm tra dữ liệu
    @Override
    public String toString() {
        return "Product{" +
                "id=" + productID +
                ", name='" + productName + '\'' +
                ", codeProduct='" + codeProduct + '\'' +
                ", price=" + price +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
