import java.sql.*;

public class DBUtil {
  static final String URL = "jdbc:mariadb://localhost:3306/cinema";
  static final String USER = "root";
  static final String PASS = "your_password";

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

