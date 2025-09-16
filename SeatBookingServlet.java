import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class SeatBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String movieId = req.getParameter("movieid");
        String theatre = req.getParameter("theatre");
        String date = req.getParameter("date");
        String showtime = req.getParameter("showtime");
        List<String> bookedSeatsList = new ArrayList<>();
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "user", "pass");
             PreparedStatement ps = con.prepareStatement("SELECT seat_number FROM bookings WHERE movie_id=? AND theatre=? AND date=? AND showtime=?")) {
            ps.setInt(1, Integer.parseInt(movieId));
            ps.setString(2, theatre);
            ps.setString(3, date);
            ps.setString(4, showtime);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                bookedSeatsList.add(rs.getString("seat_number"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.setAttribute("bookedSeatsList", bookedSeatsList);
        req.getRequestDispatcher("seatBooking.jsp").forward(req, resp);
    }
}




