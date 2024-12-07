package Entity;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderInfo {
    private int user_id;
    private int cart_id;
    private int property_id;
    private double price;
    private int quantity;
    private LocalDate dt_buy;

    public OrderInfo(int user_id, int cart_id, int property_id, double price, int quantity) {
        this.user_id = user_id;
        this.cart_id = cart_id;
        this.property_id = property_id;
        this.price = price;
        this.quantity = quantity;
        this.dt_buy = LocalDate.now();
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getProperty_id() {
        return property_id;
    }

    public void setProperty_id(int property_id) {
        this.property_id = property_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    public LocalDate getDt_buy() {
        return dt_buy;
    }

    public void setDt_buy(LocalDate dt_buy) {
        this.dt_buy = dt_buy;
    }

    @Override
    public String toString() {
        return "OrderInfo{" +
                "user_id=" + user_id +
                ", cart_id=" + cart_id +
                ", property_id=" + property_id +
                ", price=" + price +
                ", quantity=" + quantity +
                ", dt_buy=" + dt_buy +
                '}';
    }

    public static void main(String[] args) {
//        OrderInfo o = new OrderInfo(1,2,3,4.5,5);
//        List<OrderInfo> orders = Arrays.asList(
//                new OrderInfo(1, 101, 1001, 20.5, 2),
//                new OrderInfo(1, 101, 1002, 15.0, 1),
//                new OrderInfo(1, 103, 1004, 50.0, 1)
//        );
//        System.out.println(o.getInfo(orders));
    }
}
