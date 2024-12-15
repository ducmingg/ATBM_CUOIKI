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


            // Lưu publicKey và privateKey vào session
            HttpSession session = req.getSession();
            session.setAttribute("publicKey", base64PublicKey);  // Lưu publicKey vào session
            session.setAttribute("privateKey", base64PrivateKey);  // Lưu privateKey vào session
            System.out.println(base64PublicKey);
            // Chuyển hướng về trang để hiển thị khóa
            resp.sendRedirect("create-key.jsp");


        } else if ("submitForm".equals(action)) {
            // Lấy giá trị publicKey từ session
            HttpSession session = req.getSession();
            String publicKey = (String) session.getAttribute("publicKey");

            if (publicKey != null) {
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId != null) {
                    // Lấy email của người dùng từ cơ sở dữ liệu
                    String userEmail = null;
                    try {
                        userEmail = userDao.getEmailByUserId(userId);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }

                    // Tạo mã token và lưu vào session
                    String token = UUID.randomUUID().toString();
                    session.setAttribute("token", token);  // Lưu token vào session

                    try {
                        // Gửi email xác nhận cho người dùng
                        dao.sendTokenEmail(userEmail, token);
                    } catch (MessagingException e) {
                        throw new RuntimeException("Không thể gửi mã xác nhận qua email.", e);
                    }

                    // Thêm thông báo cho người dùng
                    session.setAttribute("message", "Mã xác nhận đã được gửi đến email của bạn.");

                    // Chuyển hướng về trang để hiển thị thông báo
                    resp.sendRedirect("create-key.jsp");
                }
            }
        }
    }
}



