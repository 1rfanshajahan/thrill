<%@ page import="java.sql.*" %>
<%@ page import="utils.DBUtil" %>
<%@ page isErrorPage="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Explore Movies Now!</title>
  <style>
    body {
      background: linear-gradient(to bottom, #19191b 0%, #29292e 100%);
      color: #ffe900;
      font-family: 'Segoe UI', Arial, sans-serif;
      margin: 0; padding: 0;
    }
    .top-bar {
      display: flex;
      align-items: center;
      gap: 36px;
      justify-content: center;
      margin: 26px 0 42px 0;
    }
    .explore-title {
      font-size: 3em;
      font-weight: bold;
      color: #ffe900;
      text-align: right;
      margin-left: 32px;
    }
    .container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 36px;
      margin: 30px 0 60px 0;
    }
    .movie-card {
      background: #121212;
      color: #fff;
      border-radius: 14px;
      width: 235px;
      box-shadow: 0 3px 22px #0009;
      padding: 1.2em;
      display: flex;
      flex-direction: column;
      align-items: center;
      transition: transform .17s;
    }
    .movie-card:hover {
      transform: scale(1.04);
      box-shadow: 0 8px 26px #000c;
    }
    .movie-card img {
      width: 180px;
      height: 240px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 16px;
      box-shadow: 0 3px 15px #0007;
      background: #232323;
    }
    .movie-title {
      font-size: 1.12em;
      font-weight: bold;
      margin-bottom: 3px;
      color: #ffe900;
      text-align: center;
    }
    .movie-desc {
      font-size: .98em;
      color: #bbb;
      margin-bottom: 12px;
      text-align: center;
    }
    .btn-book {
      padding: 11px 34px;
      background: #ffe900;
      color: #000;
      font-weight: bold;
      border: none;
      border-radius: 9px;
      cursor: pointer;
      font-size: 1.02em;
      letter-spacing: .02em;
      transition: background .2s, color .2s;
      margin-top: 4px;
      box-shadow: 0 2px 12px #0003;
    }
    .btn-book:hover {
      background: #fff799;
      color: #000;
    }
    .err-msg {
      color: #ff5252;
      background: #202010;
      border-radius: 8px;
      padding: 16px;
      margin: 40px auto;
      width: fit-content;
      font-size: 1.12em;
      text-align: center;
    }
    .no-movies {
      color: #fff3;
      text-align: center;
      font-size: 1.19em;
      margin-top: 50px;
    }
  </style>
</head>
<body>
  <div class="top-bar">
    <img src="popcorn.png" alt="Popcorn Banner" style="height:100px;">
    <div class="explore-title">EXPLORE<br/>MOVIES<br/>NOW!!!</div>
  </div>
  <div class="container">
    <%
      boolean moviesFound = false;
      try (Connection con = DBUtil.getConnection();
           Statement st = con.createStatement();
           ResultSet rs = st.executeQuery("SELECT * FROM movies")) {
        while (rs.next()) {
            moviesFound = true;
    %>
      <div class="movie-card">
        <img src="<%= rs.getString("img_url") != null && !rs.getString("img_url").isEmpty() ? rs.getString("img_url") : "default-poster.jpg" %>" alt="Movie Poster">
        <div class="movie-title"><%= rs.getString("title") %></div>
        <div class="movie-desc"><%= rs.getString("description") %></div>
        <form action="showtimes.jsp" method="get">
          <input type="hidden" name="movieid" value="<%= rs.getInt("id") %>">
          <button type="submit" class="btn-book">BOOK NOW</button>
        </form>
      </div>
    <%
        }
        if (!moviesFound) {
    %>
        <div class="no-movies">No movies available at the moment.</div>
    <%
        }
      } catch(Exception e) {
    %>
      <div class="err-msg">
        <strong>DB error:</strong> <%= e.getMessage() %>
      </div>
    <%
      }
    %>
  </div>
</body>
</html>

