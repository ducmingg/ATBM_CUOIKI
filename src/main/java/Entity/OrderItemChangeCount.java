package Entity;

public class OrderItemChangeCount {
    private int orderItemId;
    private int changeCount;
    private String orderId;

    public OrderItemChangeCount(int orderItemId, int changeCount, String orderId) {
        this.orderItemId = orderItemId;
        this.changeCount = changeCount;
        this.orderId = orderId;
    }

    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getChangeCount() {
        return changeCount;
    }

    public void setChangeCount(int changeCount) {
        this.changeCount = changeCount;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return "OrderItemChangeCount{" +
                "orderItemId=" + orderItemId +
                ", changeCount=" + changeCount +
                ", orderId='" + orderId + '\'' +
                '}';
    }
}
