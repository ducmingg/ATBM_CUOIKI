package Dao;

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
import java.util.Base64;

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

        String url = "jdbc:mysql://localhost:3306/webbds";
        String user = "root";
        String password = "root";
        return DriverManager.getConnection(url, user, password);
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
    }
}
