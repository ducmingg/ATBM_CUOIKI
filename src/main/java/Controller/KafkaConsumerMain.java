package Controller;

import Mail.EmailService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.json.JSONObject;

import javax.mail.MessagingException;
import java.sql.SQLOutput;
import java.util.List;
import java.util.Properties;



public class KafkaConsumerMain implements Runnable, ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent arg0) {
        System.out.println("Consumer init:");

        Thread kafkaThread = new Thread(this); // Sử dụng chính class làm Runnable
//        kafkaThread.setDaemon(true);          // Đảm bảo thread không ngăn Tomcat tắt
        kafkaThread.start();
    }


    @Override
    public void run() {
        String bootstrapServers = "192.168.1.4:9094";
        String groupId = "test-group";
        String topic = "db.webbds.orderitem_logs";

        // Cấu hình các tham số cho Consumer
        Properties properties = new Properties();
        properties.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        properties.put(ConsumerConfig.GROUP_ID_CONFIG, groupId);
        properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        properties.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");

        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);
        consumer.subscribe(List.of(topic));
        EmailService emailService = new EmailService();

        try {
            while (true) {
                var records = consumer.poll(java.time.Duration.ofMillis(100));
                records.forEach(record -> {
                    JSONObject valueJson = new JSONObject(record.value());
                    JSONObject payload = valueJson.optJSONObject("payload");
                    JSONObject after = payload.optJSONObject("after");

                    int order_id = after.optInt("order_item_id");
                    String change_by = after.optString("changed_by");
                    double price = after.optDouble("new_price");
                    int quantity = after.optInt("new_quantity");
                    String action = after.optString("action");

                    System.out.println("Order ID: " + order_id + ", Changed By: " + change_by);
                    String msg = String.format(
                            "Hành động: %s, Mã đơn hàng: %d, Người thay đổi: %s, Giá: %.2f, Số lượng: %d",
                            action, order_id, change_by, price, quantity
                    );

                    try {
                        emailService.sendEmail(
                                "21130447@st.hcmuaf.edu.vn",
                                "Cảnh báo thay đổi đơn hàng",
                                msg
                        );
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                });
            }
        } finally {
            consumer.close();
        }
    }

}
