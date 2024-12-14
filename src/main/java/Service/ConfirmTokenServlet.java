package Service;

import Dao.DigitalSignatureDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;

@WebServlet("/confirm-token")
public class ConfirmTokenServlet extends HttpServlet {
    private DigitalSignatureDAO digitalSignatureDAO;

    @Override
    public void init() {
        digitalSignatureDAO = new DigitalSignatureDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String action = req.getParameter("action");

        if ("addPublicKey".equals(action)) {
            // Lấy thông tin người dùng từ token, đây có thể là mã người dùng hoặc mã token trong cơ sở dữ liệu
            // Giả sử bạn đã có phương thức xác thực token, và lấy được userId từ token
            HttpSession session = req.getSession();

            Integer userId = (Integer) session.getAttribute("userId");

            // Lấy public key từ yêu cầu (hoặc từ session)
            String publicKey = req.getParameter("publickey");

            // Gọi phương thức để thêm khóa công khai vào cơ sở dữ liệu
            digitalSignatureDAO.addPublicKey(userId, publicKey);

            // Redirect hoặc trả về thông báo xác nhận
            resp.sendRedirect("success.jsp"); // Redirect đến trang thành công hoặc thông báo
        }
    }
}
