package Controller;

import DBcontext.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.*;


@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // Helper method to get database connection
    private Connection getConnection() throws SQLException {

        return Database.getConnection();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // Handle retrieving the cart items
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


    }
}
