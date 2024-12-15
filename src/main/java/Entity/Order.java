package Entity;

import DBcontext.Database;

import java.sql.Date;

public class Order {
    public int getVerify() {
        return verify;
    }

    public void setVerify(int verify) {
        this.verify = verify;
    }

    public int getIs_report() {
        return is_report;
    }

    public void setIs_report(int is_report) {
        this.is_report = is_report;
    }

    private int orderId;
    private int userId;
    private Date orderDate;
    private String username;
    private String signature;
    private String status;

    private int verify;
    private int is_report;

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

    public Order(int orderId, Date orderDate, int verify, int is_report) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.verify = verify;
        this.is_report = is_report;
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

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", username='" + username + '\'' +
                ", signature='" + signature + '\'' +
                ", status='" + status + '\'' +
                ", verify=" + verify +
                ", is_report=" + is_report +
                '}';
    }
}
