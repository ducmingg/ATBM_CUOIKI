package Entity;

import DBcontext.Database;

import java.sql.Date;

public class Order {

    private int orderId;
    private int userId;
    private Date orderDate;
    private String username;
    private String signature;
    private String status;

    public Order(int orderId, int userId, String username, Date orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.username = username;
    }

    public Order() {

    }

    public Order(int orderId, int userId, String username, Date date, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = date;
        this.username = username;
        this.status = status;
    }


    // Getters and Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;

    }

}
