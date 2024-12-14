package Controller;

import Dao.DigitalSignatureDAO;
import Dao.UserDAO; // Import UserDAO để lấy email
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Properties;
import java.util.UUID; // Dùng để tạo mã xác nhận
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/digital-signature")
public class DigitalSignatureServlet extends HttpServlet {
    private DigitalSignatureDAO dao;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        dao = new DigitalSignatureDAO();
        userDao = new UserDAO(); // Khởi tạo UserDAO để truy vấn thông tin người dùng
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy giá trị action từ form
        String action = req.getParameter("action");

        if ("generateKey".equals(action)) {
            // Xử lý khi người dùng nhấn "Tạo Khóa Mới"
            KeyPair keyPair = null;
            String base64PublicKey, base64PrivateKey;
            try {
                keyPair = dao.generateKey();
                PublicKey publicKey = keyPair.getPublic();
                PrivateKey privateKey = keyPair.getPrivate();
                base64PublicKey = Base64.getEncoder().encodeToString(publicKey.getEncoded());
                base64PrivateKey = Base64.getEncoder().encodeToString(privateKey.getEncoded());
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            // Gửi giá trị khóa đến trang JSP
            req.setAttribute("publickey", base64PublicKey);
            req.setAttribute("privatekey", base64PrivateKey);
            RequestDispatcher dispatcher = req.getRequestDispatcher("create-key.jsp");
            dispatcher.forward(req, resp);
        } else if ("submitForm".equals(action)) {
            // Xử lý khi người dùng nhấn "Gửi Khóa"
            String publicKey = req.getParameter("publickey");
            HttpSession session = req.getSession();

            // Lấy userId từ session
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId != null) {
                // Lấy email của người dùng từ cơ sở dữ liệu
                String userEmail = null;
                try {
                    userEmail = userDao.getEmailByUserId(userId);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                // Tạo mã token
                String token = UUID.randomUUID().toString();

                // Lưu token vào cơ sở dữ liệu hoặc session nếu cần thiết
                // userDao.saveTokenForUser(userId, token);

                // Gửi token qua email
                sendTokenEmail(userEmail, token);

                // Thêm thông báo cho người dùng
                session.setAttribute("message", "Mã xác nhận đã được gửi đến email của bạn.");

                // Chuyển hướng về trang để hiển thị thông báo
                resp.sendRedirect("create-key.jsp");
            } else {
                resp.getWriter().println("User ID không hợp lệ.");
            }
        }
    }

    // Hàm gửi email chứa token
    private void sendTokenEmail(String userEmail, String token) {
        String host = "smtp.gmail.com";
        String from = "khoangoquan@gmail.com";  // Thay thế bằng email của bạn
        String password = "mzrs xvca qstr zegw"; // Thay thế bằng mật khẩu email của bạn
        String subject = "Xác nhận khóa kỹ thuật số";

        // Tạo URL xác nhận với mã token
        // Tạo URL xác nhận với mã token và thêm hành động addPublicKey
        String confirmUrl = "http://localhost:8080/Batdongsan/confirm-token?token=" + token + "&action=addPublicKey";


        String body = "Xin chào,\n\n" +
                "Để xác nhận khóa kỹ thuật số của bạn, vui lòng bấm vào liên kết sau:\n" +
                confirmUrl + "\n\n" +
                "Nếu bạn không yêu cầu mã này, hãy bỏ qua email này.\n\n" +
                "Trân trọng,\n" +
                "Hệ thống";

        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("Token xác nhận đã được gửi đến email: " + userEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
