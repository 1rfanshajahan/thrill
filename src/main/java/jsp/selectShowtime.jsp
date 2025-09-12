<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // These variables should be set from your servlet/database in production
    String movieTitle = request.getParameter("movie") != null ? request.getParameter("movie") : "Avengers: Endgame";
    String certification = "UA13+";
    String duration = "1 hr 44 mins";
    String genres = "Animation, Adventure, Comedy";
    String language = "English";
    List<String> days = Arrays.asList("Sun", "Mon", "Tue", "Wed", "Thu");
    List<String> dates = Arrays.asList("3", "4", "5", "6", "7");
    int activeDay = 0; // demo: highlight first day

    // Demo showtimes data - replace with DB data in real integration
    class Showtime {
        String theatre, time, format, label;
        Showtime(String theatre, String time, String format, String label) {
            this.theatre = theatre; this.time = time; this.format = format; this.label = label;
        }
    }
    List<Showtime> showtimes = new ArrayList<>();
    showtimes.add(new Showtime("C cinemas, Chengannur", "04:50 PM", "3D", "LASER"));
    showtimes.add(new Showtime("Cinepolis, Chengannur", "09:00 PM", "3D", "JUNIOR"));
    showtimes.add(new Showtime("PVR, Chengannur", "06:15 PM", "3D", ""));
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title><%= movieTitle %> - Showtimes</title>
  <style>
    body { background: #16181d; color: #fff; margin: 0; font-family: 'Segoe UI', Arial, sans-serif; }
    .container { max-width: 880px; margin: 0 auto; padding: 0 20px; margin-top: 26px; }
    .movie-title { font-size: 2.4rem; font-weight: 700; margin-bottom: 7px; }
    .meta { color: #aaa; font-size: 1.05rem; margin-bottom: 3px; }
    .tags { color: #62d2a2; font-size: 1rem; margin-bottom: 18px; }
    .days-bar { display: flex; gap: 9px; margin-bottom: 20px; margin-top: 24px; }
    .day-pill {
      background: #23262d; color: #eee;
      padding: 11px 18px 6px 18px; border-radius: 8px;
      font-size: 1rem; font-weight: 500; border: none;
      outline: none; cursor: pointer; line-height: 1.05; text-align: center;
      min-width: 45px;
      transition: background 0.2s;
    }
    .day-pill.active { background: #1ab46c; color: #fff }
    .theatre-list {
      background: #23262d; border-radius: 15px; box-shadow: 0 3px 18px rgba(0,0,0,0.15); margin-bottom: 32px;
      padding: 0 0 20px 0;
    }
    .theatre-row {
      border-bottom: 1px solid #23272e;
      padding: 20px 30px 12px 30px;
      display: flex; flex-direction: row; justify-content: space-between; align-items: center;
    }
    .theatre-row:last-child { border-bottom: none; }
    .theatre-name { font-size: 1.1rem; font-weight: 600; color: #f4f4fa; flex: 2; }
    .show-btn-section { flex: 1; display: flex; flex-direction: column; align-items: flex-end; gap: 6px; }
    .show-btn {
      font-size: 1.07rem; background: #1ab46c; color: #fff;
      border: none; border-radius: 8px; padding: 9px 28px;
      font-weight: 600; cursor: pointer; margin-bottom: 2px; box-shadow: 0 2px 9px rgba(26,180,108,0.09);
      display: inline-block; letter-spacing: .5px;
      transition: background 0.19s;
    }
    .show-btn:hover {
      background: #179c5a;
    }
    .show-details {
      color: #53d6ab; font-size: 0.96rem; margin-left: 8px; font-weight: 500;
    }
    .theatre-label {
      font-size: 0.82rem; background: #23262d; color: #95cde4;
      border-radius: 6px; padding: 2px 9px; margin-left: 11px; font-weight: 500;
      display: inline-block; letter-spacing: 0.4px;
    }
    .search-section {
      padding: 16px 30px 0 30px;
    }
    .search-inp {
      background: #181a21; color: #eef; font-size: 1.06rem;
      border: none; border-radius: 9px; padding: 9px 15px; width: 100%; outline: none;
      box-shadow: 0 1px 1px rgba(0,0,0,0.10);
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="movie-title"><%= movieTitle %></div>
    <div class="meta"><%= certification %> &bull; <%= duration %></div>
    <div class="tags"><%= genres %> <span style="color:#a5a5a5">|</span> <%= language %></div>
    <!-- Days Bar -->
    <div class="days-bar">
    <% for(int i=0; i<days.size(); i++) { %>
      <div class="day-pill<%= (i==activeDay) ? " active" : "" %>"><%= days.get(i) %><br><%= dates.get(i) %></div>
    <% } %>
    </div>
    <!-- Theatre/Showtime List -->
    <div class="theatre-list">
      <div class="search-section">
        <input class="search-inp" type="text" placeholder="Search Theatres" oninput="filterTheatres(this.value)" id="theatreSearch" />
      </div>
      <% for(Showtime st : showtimes) { %>
      <div class="theatre-row" data-theatre="<%= st.theatre.toLowerCase() %>">
        <div class="theatre-name"><%= st.theatre %></div>
        <div class="show-btn-section">
          <button class="show-btn"
            onclick="goToSeatBooking('<%= movieTitle %>','<%= st.theatre %>','<%= st.time %>')">
            <%= st.time %>
            <span class="show-details"><%= st.format %></span>
            <% if(st.label.length() > 0){ %>
              <span class="theatre-label"><%= st.label %></span>
            <% } %>
          </button>
        </div>
      </div>
      <% } %>
    </div>
  </div>
  <script>
    function filterTheatres(keyword) {
      keyword = keyword.toLowerCase();
      document.querySelectorAll('.theatre-row').forEach(function(row) {
        let theatre = row.getAttribute('data-theatre');
        row.style.display = theatre.includes(keyword) ? '' : 'none';
      });
    }
    function goToSeatBooking(movie, theatre, time) {
      // Redirect to seat booking page with relevant info
      window.location.href = "seatBooking.jsp?movie=" + encodeURIComponent(movie)
        + "&theatre=" + encodeURIComponent(theatre)
        + "&time=" + encodeURIComponent(time);
    }
  </script>
</body>
</html>

