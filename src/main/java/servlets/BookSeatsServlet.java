import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookSeatsServlet")
public class BookSeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // For simplicity: static list to hold booked seats
    // In real app, use database to persist booked seats
    private static List<String> bookedSeats = new ArrayList<>(Arrays.asList("A3", "A4", "B5", "C7", "D1", "E10", "F12"));

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedSeatsStr = request.getParameter("selectedSeats");
        if (selectedSeatsStr == null || selectedSeatsStr.trim().isEmpty()) {
            request.setAttribute("error", "No seats selected.");
            request.getRequestDispatcher("seatBooking.jsp").forward(request, response);
            return;
        }

        List<String> selectedSeats = Arrays.asList(selectedSeatsStr.split(","));

        // Check if any selected seat is already booked
        for (String seat : selectedSeats) {
            if (bookedSeats.contains(seat)) {
                request.setAttribute("error", "Some seats were already booked: " + seat);
                request.setAttribute("bookedSeatsList", bookedSeats);
                request.getRequestDispatcher("seatBooking.jsp").forward(request, response);
                return;
            }
        }

        // Add selected seats to booked list (simulate saving)
        bookedSeats.addAll(selectedSeats);

        // Forward to confirmation page or redisplay with success message
        request.setAttribute("message", "Booking successful for seats: " + String.join(", ", selectedSeats));
        request.setAttribute("bookedSeatsList", bookedSeats);
        request.getRequestDispatcher("seatBooking.jsp").forward(request, response);
    }

    // Optionally provide bookedSeats for initial load via GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("bookedSeatsList", bookedSeats);
        request.getRequestDispatcher("seatBooking.jsp").forward(request, response);
    }
}

