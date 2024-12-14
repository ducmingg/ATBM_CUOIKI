package Dao;

import DBcontext.Database;
import Entity.OrderInfo;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.*;

import java.util.*;
import java.util.stream.Collectors;

public class DigitalSignatureDAO {
    public KeyPair generateKey() throws Exception {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(2048);
        return keyPairGenerator.genKeyPair();
    }

    public String create(String option, String pathFile, String base64PrivateKey) throws Exception {

        RSAPrivateKey privKey = base64StringToPrivateKey(base64PrivateKey);

        Signature signature = Signature.getInstance(option);
        signature.initSign(privKey);
        byte[] data = Files.readAllBytes(Paths.get(pathFile));
        signature.update(data);
        byte[] digitalSignature = signature.sign();
        return Base64.getEncoder().encodeToString(digitalSignature);
    }

    public boolean verify(String option, String pathFile, String signedData, String base64PublicKey) throws Exception {
        RSAPublicKey publicKey = base64StringToPublicKey(base64PublicKey);
        byte[] signatureBytes = Base64.getDecoder().decode(signedData); // Giải mã chữ ký từ Base64
        Signature signature = Signature.getInstance(option);
        signature.initVerify(publicKey);

        byte[] data = Files.readAllBytes(Paths.get(pathFile));
        signature.update(data);
        boolean isCorrect = signature.verify(signatureBytes);
        return isCorrect;
    }

    public String loadKey(String filePathKey) {
        String base64Key = null;
        try {
            // Đọc tất cả dữ liệu từ tệp vào mảng byte
            byte[] keyBytes = Files.readAllBytes(Paths.get(filePathKey));
            // Chuyển mảng byte thành Base64
            base64Key = Base64.getEncoder().encodeToString(keyBytes);
            // In ra hoặc lưu key Base64
            System.out.println("Key Base64: " + base64Key);
            // Nếu bạn cần lưu base64 vào một biến, bạn có thể lưu nó ở đây
            // this.base64Key = base64Key;
        } catch (IOException e) {
            // Xử lý ngoại lệ nếu có lỗi trong quá trình đọc tệp
            System.err.println("Đã xảy ra lỗi khi đọc tệp: " + e.getMessage());
        }
        return base64Key;
    }

    public RSAPrivateKey base64StringToPrivateKey(String base64PrivateKey) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(base64PrivateKey);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return (RSAPrivateKey) keyFactory.generatePrivate(spec);
    }

    public RSAPublicKey base64StringToPublicKey(String base64PublicKey) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(base64PublicKey);
        X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return (RSAPublicKey) keyFactory.generatePublic(x509EncodedKeySpec);
    }

    private Connection getConnection() throws SQLException {
        return Database.getConnection();
    }

    public boolean doesUserExist(int userId) {
        String sql = "SELECT 1 FROM digital_signature WHERE user_id = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addPublicKey(int userId, String publickey) {
        String sqlInsert = "INSERT INTO digital_signature (user_id, public_key, dt_create, dt_expired) VALUES (?, ?, CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY))";
        String sqlUpdate = "UPDATE digital_signature SET public_key = ?, dt_create = CURRENT_TIMESTAMP, dt_expired = DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY) WHERE user_id = ?";

        boolean userExists = doesUserExist(userId);
        String sql = userExists ? sqlUpdate : sqlInsert;

        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (userExists) {
                stmt.setString(1, publickey);
                stmt.setInt(2, userId);
            } else {
                stmt.setInt(1, userId);
                stmt.setString(2, publickey);
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getCartId(int user_id) {
        String sql = "select cart_id from cart where user_id = ?";
        int cart_id = 0; // Khởi tạo giá trị mặc định
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user_id); // Gán tham số cho câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cart_id = Integer.parseInt(rs.getString("cart_id")); // Lấy giá trị của cột `cart_id`
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart_id; // Trả về `cart_id` hoặc null nếu không có kết quả
    }

    public String getInfo(List<OrderInfo> orders) {
        Map<String, List<List<Object>>> groups = orders.stream().collect(Collectors.groupingBy(order -> order.getUser_id() + "-" + order.getCart_id() + "-" + order.getDt_buy(), // Khóa
                Collectors.mapping( // Chuyển đổi giá trị
                        order -> Arrays.asList(order.getProperty_id(), order.getPrice(), order.getQuantity()), // Lưu các trường còn lại trong danh sách
                        Collectors.toList() // Thu thập thành danh sách
                )));

        StringBuilder result = new StringBuilder();
        for (Map.Entry<String, List<List<Object>>> i : groups.entrySet()) {
            String key = i.getKey();
            List<List<Object>> val = i.getValue();
            result.append(key);
            for (List<Object> ee : val) {
                for (Object e : ee) {
                    result.append(e);
                }
            }
        }

        // Trả về chuỗi kết quả
        return result.toString();
    }

    public void insertSignature(String sig, int orderId) {
        String sql = "update orders set signature  = ? where order_id = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sig); // Gán tham số cho câu lệnh SQL
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getCartItemInfo(int user_id) {
        List<OrderInfo> orders = new ArrayList<>();
        String sql = "SELECT u.id as user_id,c.cart_id,ci.property_id,ci.price,ci.quantity FROM users u " + "join cart c on u.id = c.user_id " + "join cartitems ci on c.cart_id = ci.cart_id " + "where u.id = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user_id); // Gán tham số cho câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt(1);
                int cartId = rs.getInt(2);
                int propertyId = rs.getInt(3);
                double price = rs.getDouble(4);
                int quantity = rs.getInt(5);
                orders.add(new OrderInfo(user_id, cartId, propertyId, price, quantity));
                System.out.println(new OrderInfo(user_id, cartId, propertyId, price, quantity).toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getInfo(orders);
    }


    public void sendTokenEmail(String userEmail, String token) throws MessagingException {
        // Thông tin cấu hình SMTP
        String host = "smtp.gmail.com";
        String from = "khoangoquan@gmail.com";  // Địa chỉ email gửi
        String password = "mzrs xvca qstr zegw";  // Mật khẩu (nên thay bằng biến môi trường)

        String subject = "Xác nhận khóa kỹ thuật số";

        // Tạo URL xác nhận với token
        String confirmUrl = "http://localhost:8080/Batdongsan/confirm-token?token=" + token + "&action=addPublicKey";

        // Nội dung email
        String body = "Xin chào,\n\n" +
                "Chúng tôi đã nhận được yêu cầu xác nhận khóa kỹ thuật số của bạn. " +
                "Vui lòng bấm vào liên kết dưới đây để xác nhận:\n" +
                confirmUrl + "\n\n" +

                "Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này.\n\n" +
                "Trân trọng,\n" +
                "Hệ thống hỗ trợ";

        // Cấu hình thông tin máy chủ gửi email
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Tạo session và xác thực thông tin đăng nhập
        Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Soạn thảo email
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));  // Địa chỉ nhận email
        message.setSubject(subject);  // Tiêu đề email
        message.setText(body);  // Nội dung email

        // Gửi email
        Transport.send(message);
        System.out.println("Token xác nhận đã được gửi đến email: " + userEmail);
    }


    public static void main(String[] args) throws Exception {
        DigitalSignatureDAO ds = new DigitalSignatureDAO();
//        KeyPair keyPair = ds.generateKey();
//        PublicKey publicKey = keyPair.getPublic();
//        PrivateKey privateKey = keyPair.getPrivate();
//        String base64PublicKey = Base64.getEncoder().encodeToString(publicKey.getEncoded());
//        String base64PrivateKey = Base64.getEncoder().encodeToString(privateKey.getEncoded());
//        System.out.println(base64PrivateKey);
//        System.out.println(base64PublicKey);
//        ds.addPublicKey("publikey");
//        ds.getCartItemInfo(32);
//        System.out.println(ds.getCartItemInfo(32));
    }


}
