package Dao;

import DBcontext.Database;
import Entity.OrderInfo;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
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

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
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
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
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

    //chuyen danh sach don hang thanh chuoi string
    public String getInfo(List<OrderInfo> orders) {
        Map<String, List<List<Object>>> groups = orders.stream()
                .collect(Collectors.groupingBy(
                        order -> order.getUser_id() +"-" + order.getDt_buy(), // Khóa
                        Collectors.mapping( // Chuyển đổi giá trị
                                order -> Arrays.asList(order.getProperty_id(), order.getPrice(), order.getQuantity()), // Lưu các trường còn lại trong danh sách
                                Collectors.toList() // Thu thập thành danh sách
                        )
                ));

        StringBuilder result = new StringBuilder();
        for(Map.Entry<String,List<List<Object>>> i : groups.entrySet()){
            String key = i.getKey();
            List<List<Object>> val = i.getValue();
            result.append(key);
            for (List<Object> ee:val) {
                for (Object e: ee) {
                    result.append(e);
                }
            }
        }

        // Trả về chuỗi kết quả
        return result.toString();
    }

    public void insertSignature(String sig,int orderId) {
        String sql  = "update orders set signature  = ? where order_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sig); // Gán tham số cho câu lệnh SQL
            stmt.setInt(2,orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    thong tin danh sach don hang cua user theo id
     public String getCartItemInfo(int user_id) {
        List<OrderInfo> orders = new ArrayList<>();
        String sql = "SELECT u.id as user_id,c.cart_id,ci.property_id,ci.price,ci.quantity FROM users u " +
                "join cart c on u.id = c.user_id " +
                "join cartitems ci on c.cart_id = ci.cart_id " +
                "where u.id = ?";
        try (Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user_id); // Gán tham số cho câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt(1);
                int cartId = rs.getInt(2);
                int propertyId = rs.getInt(3);
                double price = rs.getDouble(4);
                int quantity = rs.getInt(5);
                orders.add(new OrderInfo(user_id,cartId,propertyId,price,quantity));
                System.out.println(new OrderInfo(user_id,cartId,propertyId,price,quantity).toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getInfo(orders);
    }

    public boolean check_is_use_key(int userId) {
        String sql = "select is_use from digital_signature where user_id = ?";
        int re = 0;
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId); // Gán tham số cho câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
            re = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return re==1;
    }
    public void reportKey(int userId, LocalDateTime dtReport) {
        String sql = "{CALL update_dt_report(?, ?)}";  // Stored procedure gọi 2 tham số
        try (Connection connection = getConnection();
             CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, userId);
            stmt.setTimestamp(2, Timestamp.valueOf(dtReport));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void changeDtReportToNull(int userId){
        String sql = "{CALL change_dt_report_to_null(?)}";  // Stored procedure gọi 2 tham số
        try (Connection connection = getConnection();
             CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) throws Exception {
        DigitalSignatureDAO ds = new DigitalSignatureDAO();
        LocalDateTime dtReport = LocalDateTime.parse("2024-12-02T15:20:07");

        System.out.println(ds.check_is_use_key(2));;
    }
}
