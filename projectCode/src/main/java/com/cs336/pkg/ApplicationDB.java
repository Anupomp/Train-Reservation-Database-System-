package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

    public ApplicationDB() {}

    public Connection getConnection() {

        // Correct connection string for your setup
        String connectionUrl = "jdbc:mysql://localhost:3306/train_reservation?useSSL=false";
        Connection connection = null;

        try {
            // MySQL 8+ driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionUrl, "root", "anupam"); // Change password if needed
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;  // <--- Make sure this matches the variable above!
    }

    public void closeConnection(Connection connection) {
        try {
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/train_reservation?useSSL=false";
            Connection connection = DriverManager.getConnection(url, "root", "anupam");
            System.out.println(connection);
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
}
