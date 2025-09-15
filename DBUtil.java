package utils;
import java.sql.*;
public class DBUtil {
  static final String URL = "jdbc:mariadb://localhost:3306/cinema";
  static final String USER = "thrilluser";         // new dedicated DB user
  static final String PASS = "thrillpassword";     // password for that user

  static {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    }
  }

  public static Connection getConnection() throws SQLException {
    return DriverManager.getConnection(URL, USER, PASS);
  }
}

