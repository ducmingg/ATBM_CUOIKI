package Entity;

import java.sql.Timestamp;

public class OrderItemLog {
    private int logId;
    private int orderItemId;
    private String action;
    private int oldQuantity;
    private int newQuantity;
    private double oldPrice;
    private double newPrice;
    private Timestamp changeTime;
    private String changedBy;
    private boolean checked;

    // Constructor
    public OrderItemLog(int logId, int orderItemId, String action, int oldQuantity, int newQuantity,
                        double oldPrice, double newPrice, Timestamp changeTime, String changedBy, boolean checked) {
        this.logId = logId;
        this.orderItemId = orderItemId;
        this.action = action;
        this.oldQuantity = oldQuantity;
        this.newQuantity = newQuantity;
        this.oldPrice = oldPrice;
        this.newPrice = newPrice;
        this.changeTime = changeTime;
        this.changedBy = changedBy;
        this.checked = checked;
    }

    public OrderItemLog() {

    }

    // Getters and setters
    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getOldQuantity() {
        return oldQuantity;
    }

    public void setOldQuantity(int oldQuantity) {
        this.oldQuantity = oldQuantity;
    }

    public int getNewQuantity() {
        return newQuantity;
    }

    public void setNewQuantity(int newQuantity) {
        this.newQuantity = newQuantity;
    }

    public double getOldPrice() {
        return oldPrice;
    }

    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(double newPrice) {
        this.newPrice = newPrice;
    }

    public Timestamp getChangeTime() {
        return changeTime;
    }

    public void setChangeTime(Timestamp changeTime) {
        this.changeTime = changeTime;
    }

    public String getChangedBy() {
        return changedBy;
    }

    public void setChangedBy(String changedBy) {
        this.changedBy = changedBy;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }


}
