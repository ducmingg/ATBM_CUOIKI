package Service;

import DBcontext.Database;

import Entity.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class NotificationServlet extends HttpServlet {

    private NotificationService notificationService;

    @Override
    public void init() throws ServletException {
        try {
            // Kết nối đến cơ sở dữ liệu
            notificationService = new NotificationService(Database.getConnection());
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền admin từ session
        String role = (String) request.getSession().getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Lấy thông báo mới cho admin
        try {
            List<Notification> notifications = notificationService.getNewNotificationsForAdmin();

            // Gửi thông báo dưới dạng JSON
            response.setContentType("application/json");
            response.getWriter().write(convertNotificationsToJson(notifications));

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thêm thông báo mới
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String message = request.getParameter("message");

            notificationService.addNotification(orderId, message);

            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("Notification added successfully");
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error or invalid input");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đánh dấu thông báo là đã đọc
        try {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Notification marked as read");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error or invalid input");
        }
    }

    @Override
    public void destroy() {
        try {
            if (notificationService != null) {
                notificationService.closeConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String convertNotificationsToJson(List<Notification> notifications) {
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < notifications.size(); i++) {
            Notification notification = notifications.get(i);
            json.append("{")
                    .append("\"id\":").append(notification.getId()).append(",")
                    .append("\"orderId\":").append(notification.getOrderId()).append(",")
                    .append("\"message\":\"").append(notification.getMessage()).append("\",")
                    .append("\"status\":").append(notification.isStatus()).append(",")
                    .append("\"createdAt\":\"").append(notification.getCreatedAt()).append("\"")
                    .append("}");
            if (i < notifications.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}
