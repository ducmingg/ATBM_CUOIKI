package DBcontext;

import Entity.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DBUser {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Khai báo thông tin kết nối cơ sở dữ liệu
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        String dbName = "webbds";
        String dbUsername = "root";  // Tài khoản MySQL của bạn
        String dbPassword = "123456";  // Mật khẩu MySQL của bạn

        // Tải driver MySQL
        Class.forName(dbDriver);


        return DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
    }

}





