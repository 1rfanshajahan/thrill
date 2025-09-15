import utils.DBUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm_password");

        if (username == null || password == null || confirmPassword == null
                || !password.equals(confirmPassword) || username.trim().isEmpty() || password.trim().isEmpty()) {
            res.sendRedirect("register.html?error=1");
            return;
        }

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password) VALUES (?, ?)")) {

            ps.setString(1, username);
            ps.setString(2, password);  // Improvement: hash passwords in future

            ps.executeUpdate();

            res.sendRedirect("login.html?registered=1");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("ErrorCode: " + e.getErrorCode());
            // Optional: Log or display message for duplicate username or constraint issues
            res.sendRedirect("register.html?error=2");
        }
    }
}


