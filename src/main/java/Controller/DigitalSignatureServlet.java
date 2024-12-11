package Controller;

import Dao.DigitalSignatureDAO;
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
import java.util.Base64;

@WebServlet("/digital-signature")
public class DigitalSignatureServlet extends HttpServlet {
    private DigitalSignatureDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new DigitalSignatureDAO();
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

            // Xử lý logic gửi khóa (lưu vào database, gửi email, etc.)
            int userId = (int) session.getAttribute("userId");
            dao.addPublicKey(userId,publicKey);
            dao.changeDtReportToNull(userId);
            // Thông báo sau khi gửi
            req.setAttribute("message", "Khóa đã được gửi thành công.");
//            RequestDispatcher dispatcher = req.getRequestDispatcher("welcome.jsp");
//            dispatcher.forward(req, resp);
            resp.sendRedirect("welcome");
        } else if ("uploadPublicKey".equals(action)) {
            // Xử lí gửi khi bấm vào "Tải lên"
            req.setAttribute("publickey", req.getParameter("publickey"));
            RequestDispatcher dispatcher = req.getRequestDispatcher("create-key.jsp");
            dispatcher.forward(req, resp);

        }
    }
}
