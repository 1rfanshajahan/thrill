import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookSeatsServlet")
public class BookSeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Update DB URL, username, and password as per your environment
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/cinema";
    private static final String DB_USER = "thrilluser";
    private static final String DB_PASS = "thrillpassword";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String theatre = request.getParameter("theatre");
        String date = request.getParameter("date");
        String showtime = request.getParameter("showtime");

        List<String> bookedSeats = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "SELECT seat_id FROM bookings WHERE theatre = ? AND date = ? AND showtime = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, theatre);
                ps.setString(2, date);
                ps.setString(3, showtime);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    bookedSeats.add(rs.getString("seat_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.setAttribute("bookedSeatsList", bookedSeats);
        request.getRequestDispatcher("seatBooking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Similar to your old logic, plus DB INSERT for booked seats
        // ...add DB insert logic here as per your booking schema...
        doGet(request, response);  // Redirect to GET after booking
    }
}

