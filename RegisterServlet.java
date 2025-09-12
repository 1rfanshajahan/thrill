import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm_password");

        if (username == null || password == null || confirmPassword == null
                || !password.equals(confirmPassword) || username.trim().isEmpty() || password.trim().isEmpty()) {
            res.sendRedirect("register.html?error=1");  // Redirect back on error
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            // Insert new user
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password) VALUES (?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);  // For better security: hash passwords in real apps
            ps.executeUpdate();

            // Redirect to login page after successful registration
            res.sendRedirect("login.html?registered=1");

        } catch (SQLException e) {
            // Handle duplicate username or DB error
            e.printStackTrace();
            res.sendRedirect("register.html?error=2");
        }
    }
}

