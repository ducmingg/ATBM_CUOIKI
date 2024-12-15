package Controller;

import Mail.EmailService;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.json.JSONObject;

import javax.mail.MessagingException;
import java.sql.SQLOutput;
import java.util.List;
import java.util.Properties;

public class KafkaConsumerMain {

    public static void main(String[] args) {
        // Cấu hình Kafka Consumer
        String bootstrapServers = "192.168.1.4:9094"; // Thay đổi với địa chỉ Kafka Broker của bạn
        String groupId = "test-group";  // Thay đổi với Group ID của bạn
        String topic = "db.webbds.orderitem_logs"; // Thay đổi với tên topic bạn muốn tiêu thụ

        // Cấu hình các tham số cho Consumer
        Properties properties = new Properties();
        properties.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        properties.put(ConsumerConfig.GROUP_ID_CONFIG, groupId);
        properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        properties.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest"); // Chỉ định vị trí bắt đầu đọc nếu không có offset

        // Tạo Consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);

        // Đăng ký với topic
        consumer.subscribe(List.of(topic));
        EmailService emailService = new EmailService();
        try {
            while (true) {
                var records = consumer.poll(java.time.Duration.ofMillis(100)); // Chờ 100ms để lấy tin nhắn
                records.forEach(record -> {
                    JSONObject valueJson = new JSONObject(record.value());
                    JSONObject payload = valueJson.optJSONObject("payload");
                    JSONObject before = payload.optJSONObject("before");
                    JSONObject after = payload.optJSONObject("after");
                    System.out.println(before);
                    System.out.println(after);
                    int order_id = before.optInt("order_item_id");
                    String change_by = after.optString("changed_by");
                    double price = before.optDouble("old_price") != after.optDouble("new_price") ? after.optDouble("new_price"): null;
                    int quantity = before.optInt("old_quantity") != after.optInt("new_quantity") ? after.optInt("new_quantity"): null;
                    System.out.println(order_id+" "+change_by+" "+quantity+" "+price);
                    String msg = "Mã đơn hàng: "+order_id + " ** Người thay đổi: "+ change_by+" ** Giá: "+price +" ** Số lượng: "+quantity;
                    try {
                        emailService.sendEmail("21130447@st.hcmuaf.edu.vn","Cảnh báo có người thay đổi đơn hàng",msg);
                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }
                });
            }
        } finally {
            consumer.close(); // Đảm bảo đóng consumer khi kết thúc
        }
    }
}
