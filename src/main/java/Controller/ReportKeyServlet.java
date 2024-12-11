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
import java.time.LocalDateTime;

@WebServlet("/report-key")
public class ReportKeyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DigitalSignatureDAO dao = new DigitalSignatureDAO();
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");
        LocalDateTime time = LocalDateTime.parse(req.getParameter("time"));
        dao.reportKey(userId,time);
        System.out.println(time);

        resp.sendRedirect("welcome");

    }
}
