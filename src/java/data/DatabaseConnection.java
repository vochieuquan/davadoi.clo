package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:sqlserver://LAPTOP-00KVPJLV:1433;databaseName=davaodoicopy;encrypt=false";
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASS");
 

    public static Connection getConnection() throws SQLException {
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("Kết nối thành công!");
        return conn;
    } catch (ClassNotFoundException e) {
        throw new SQLException("SQL Server JDBC Driver not found", e);
    }
}

    public static void main(String[] args) throws SQLException {
        getConnection();
    }
}
