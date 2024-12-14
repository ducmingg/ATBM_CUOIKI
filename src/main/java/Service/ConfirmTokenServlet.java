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
        digitalSignatureDAO = new DigitalSignatureDAO(); // Khởi tạo DAO để thao tác với cơ sở dữ liệu
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token"); // Lấy token từ URL
        String action = req.getParameter("action"); // Lấy action từ URL
        HttpSession session = req.getSession(); // Lấy session hiện tại

        // Kiểm tra nếu action là 'addPublicKey'
        if ("addPublicKey".equals(action)) {
            // Lấy userId từ session (Giả sử đã được lưu trong session khi người dùng đăng nhập)
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId != null) {
                // Lấy public key từ session (Đã được lưu khi tạo khóa ở DigitalSignatureServlet)
                String publicKey = (String) session.getAttribute("publicKey");

                // Kiểm tra nếu public key không null và không rỗng
                if (publicKey != null && !publicKey.isEmpty()) {
                    try {
                        // Gọi phương thức để thêm public key vào cơ sở dữ liệu
                        digitalSignatureDAO.addPublicKey(userId, publicKey);
                        System.out.println(publicKey);
                        // Chuyển hướng đến trang thành công
                        resp.sendRedirect("success.jsp"); // Trang thành công sau khi thêm public key
                    } catch (Exception e) {
                        // Nếu có lỗi khi lưu public key vào cơ sở dữ liệu
                        resp.sendRedirect("error.jsp"); // Trang lỗi
                    }
                } else {
                    // Trường hợp không có public key trong session
                    resp.sendRedirect("error.jsp"); // Trang lỗi
                }
            } else {
                // Trường hợp không tìm thấy userId trong session (người dùng chưa đăng nhập)
                resp.sendRedirect("error.jsp"); // Trang lỗi
            }
        }
    }
}
