import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String user = req.getParameter("username");
    String pass = req.getParameter("password");

    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?")) {
      ps.setString(1, user);
      ps.setString(2, pass);
      ResultSet rs = ps.executeQuery();

      if(rs.next()) {
        req.getSession().setAttribute("user", user);
        res.sendRedirect("movies.jsp");
      } else {
        res.sendRedirect("login.html?error=1");
      }
    } catch(Exception e) {
      e.printStackTrace();
      res.getWriter().println("Database error");
    }
  }
}

