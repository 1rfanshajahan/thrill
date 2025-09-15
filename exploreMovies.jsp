<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // Simulate fetching movies from the backend as a List of Movie objects.
    // Replace this with code to fetch from your database!
    class Movie {
        String title, poster, borderColor;
        Movie(String title, String poster, String borderColor) {
            this.title = title;
            this.poster = poster;
            this.borderColor = borderColor;
        }
    }
    // Example static list for demonstration:
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    if (movies == null) {
        movies = new ArrayList<>();
        movies.add(new Movie("Avengers: Endgame", "images/avengers_poster.jpg", "#a784fc"));
        movies.add(new Movie("Thudarum", "images/thudarum_poster.jpg", "#d6d502"));
        movies.add(new Movie("Merry Christmas", "images/merry_christmas_poster.jpg", "#ffee00"));
        movies.add(new Movie("Fantastic Four", "images/fantastic_four_poster.jpg", "#00b4ff"));
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Explore Movies Now</title>
  <style>
    body {
      background: #000;
      color: #eaff00;
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      min-height: 100vh;
    }
    .header {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-top: 30px;
      gap: 60px;
    }
    .header img {
      width: 140px;
      height: auto;
    }
    .header .headline {
      font-size: 2.5rem;
      font-weight: bold;
      text-align: left;
      line-height: 1.2;
      color: #eaff00;
    }
    .movies-row {
      display: flex;
      justify-content: center;
      gap: 32px;
      margin-top: 50px;
      flex-wrap: wrap;
    }
    .movie-card {
      display: flex;
      flex-direction: column;
      align-items: center;
      background: #161616;
      border-radius: 18px;
      box-shadow: 0 10px 36px rgba(0,0,0,0.66);
      padding: 18px 18px 20px 18px;
      width: 210px;
      margin-bottom: 24px;
    }
    .movie-poster {
      width: 180px;
      height: 245px;
      border-radius: 12px;
      object-fit: cover;
      margin-bottom: 18px;
      background: #232323;
      border: 3px solid #232323;
    }
    .book-btn {
      margin-top: 10px;
      padding: 10px 0;
      width: 160px;
      background: #fff;
      color: #232323;
      font-weight: 600;
      font-size: 1rem;
      border-radius: 8px;
      border: 3px solid transparent;
      outline: none;
      cursor: pointer;
      transition: background 0.25s, color 0.25s, border 0.25s;
      letter-spacing: 1px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.22);
    }
    .book-btn:hover {
      background: #161616;
      color: #eaff00;
    }
  </style>
</head>
<body>
  <div class="header">
    <!-- Use your actual filename for the popcorn/cinema icon image -->
    <img src="images/popcorn_icon.png" alt="Movie Fun Icon" />
    <div class="headline">EXPLORE<br>MOVIES<br>NOW!!!</div>
  </div>
  <div class="movies-row">
    <%
      for (int i = 0; i < movies.size(); i++) {
        Movie m = movies.get(i);
    %>
      <div class="movie-card">
        <img class="movie-poster" src="<%= m.poster %>" alt="<%= m.title %> Poster" style="border-color:<%= m.borderColor %>;" />
        <button class="book-btn" style="border-color:<%= m.borderColor %>;"
          onclick="bookMovie('<%= m.title.replace("'", "\\'") %>')">BOOK NOW</button>
      </div>
    <%
      }
    %>
  </div>
  <script>
    function bookMovie(movieName) {
      // Redirect to seat booking page, passing movie name as parameter
      window.location.href = "seatBooking.jsp?movie=" + encodeURIComponent(movieName);
    }
  </script>
</body>
</html>

