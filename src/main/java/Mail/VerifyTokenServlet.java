//package Mail;
//
//import Dao.DigitalSignatureDAO;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//
//@WebServlet("/digital-signature")
//public class DigitalSignatureServlet extends HttpServlet {
//    private DigitalSignatureDAO dao;
//
//    @Override
//    public void init() throws ServletException {
//        dao = new DigitalSignatureDAO();
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        // Lấy giá trị action từ form
//        String action = req.getParameter("action");
//
//        if ("generateKey".equals(action)) {
//            // Xử lý khi người dùng nhấn "Tạo Khóa Mới"
//            KeyPair keyPair = null;
//            String base64PublicKey, base64PrivateKey;
//            try {
//                keyPair = dao.generateKey();
//                PublicKey publicKey = keyPair.getPublic();
//                PrivateKey privateKey = keyPair.getPrivate();
//                base64PublicKey = Base64.getEncoder().encodeToString(publicKey.getEncoded());
//                base64PrivateKey = Base64.getEncoder().encodeToString(privateKey.getEncoded());
//            } catch (Exception e) {
//                throw new RuntimeException(e);
//            }
//
//            // Gửi giá trị khóa đến trang JSP
//            req.setAttribute("publickey", base64PublicKey);
//            req.setAttribute("privatekey", base64PrivateKey);
//            RequestDispatcher dispatcher = req.getRequestDispatcher("create-key.jsp");
//            dispatcher.forward(req, resp);
//
//        } else if ("submitForm".equals(action)) {
//            // Xử lý khi người dùng nhấn "Gửi Khóa"
//            String publicKey = req.getParameter("publickey");
//            HttpSession session = req.getSession();
//            int userId = (int) session.getAttribute("userId");
//
//            // Lưu publicKey vào database và gửi email xác nhận
//            try {
//                // Lưu khóa vào cơ sở dữ liệu (hoặc thực hiện các thao tác khác)
//                dao.addPublicKey(userId, publicKey);
//
//                // Gửi email xác nhận đến người dùng
//                String email = dao.getEmailByUserId(userId);
//                String token = dao.generateTokenForUser(userId);
//                // Giả sử bạn đã có một phương thức gửi email ở đâu đó
//                sendVerificationEmail(email, token);
//
//                // Chuyển hướng người dùng đến trang thông báo đã gửi email
//                req.setAttribute("message", "Chúng tôi đã gửi một thông báo đến email của bạn. Hãy xác nhận để gửi khóa.");
//                RequestDispatcher dispatcher = req.getRequestDispatcher("confirmation.jsp");
//                dispatcher.forward(req, resp);
//            } catch (Exception e) {
//                e.printStackTrace();
//                req.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại sau.");
//                RequestDispatcher dispatcher = req.getRequestDispatcher("create-key.jsp");
//                dispatcher.forward(req, resp);
//            }
//        }
//    }
//
//    private void sendVerificationEmail(String email, String token) {
//        // Thực hiện gửi email xác nhận (ví dụ: sử dụng thư viện gửi email như JavaMail)
//        String verificationLink = "http://localhost:8080/your-app/verify-token?token=" + token;
//        String subject = "Xác nhận khóa của bạn";
//        String body = "Vui lòng xác nhận để gửi khóa của bạn: " + verificationLink;
//        // Gửi email bằng JavaMail hoặc các thư viện khác
//        // ...
//    }
//}
//
