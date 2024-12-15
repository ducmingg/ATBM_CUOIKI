package DBcontext;

import java.sql.*;

public class DbConnection {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Khai báo thông tin kết nối cơ sở dữ liệu
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:30306/";
        String dbName = "webbds";
        String dbUsername = "root";  // Tài khoản MySQL của bạn
        String dbPassword = "root";  // Mật khẩu MySQL của bạn

        // Tải driver MySQL
        Class.forName(dbDriver);


        return DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
    }

}
