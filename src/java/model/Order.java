package model;

import java.sql.Timestamp;

public class Order {
    private Long id;
    private String orderDetails;
    private Timestamp orderDate;
    private String status;

    // Constructors
    public Order() {}

    // Getters và Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getOrderDetails() { return orderDetails; }
    public void setOrderDetails(String orderDetails) { this.orderDetails = orderDetails; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}