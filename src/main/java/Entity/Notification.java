package Entity;

import java.sql.Timestamp;

public class Notification {

    private int id;
    private int orderId;
    private String message;
    private boolean status;
    private Timestamp createdAt;

    // Constructor
    public Notification(int id, int orderId, String message, boolean status, Timestamp createdAt) {
        this.id = id;
        this.orderId = orderId;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getter and Setter methods

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Override toString for easier debugging
    @Override
    public String toString() {
        return "Notification{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", message='" + message + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}
