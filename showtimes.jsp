<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="utils.DBUtil" %>
<%
    String movieId = request.getParameter("movieid");
    if (movieId == null) {
        response.sendRedirect("movies.jsp");
        return;
    }

    String title = "", genre = "", language = "English", duration = "1 hr 44 mins", poster = "", desc = "";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT * FROM movies WHERE id=?")) {
        ps.setInt(1, Integer.parseInt(movieId));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            genre = rs.getString("description");
            poster = rs.getString("img_url");
            desc = genre;
        }
        rs.close();
    } catch (Exception e) {}

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    List<String> dateList = new ArrayList<>();
    for (int i = 0; i < 5; i++) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, i);
        dateList.add(sdf.format(cal.getTime()));
    }
    String selectedDate = request.getParameter("date");
    if (selectedDate == null) selectedDate = dateList.get(0);
%>
<!DOCTYPE html>
<html>
<head>
<title><%=title%> - Showtimes</title>
<style>
    body {
        min-height: 100vh;
        margin: 0;
        font-family: 'Segoe UI', Arial, sans-serif;
        background: linear-gradient(to bottom, #161617 0%, #232326 100%);
        color: #fff;
    }
    .container { max-width: 960px; margin: 54px auto 0 auto; }
    .movie-head { display: flex; align-items: flex-start; gap:38px; margin-bottom: 18px;}
    .movie-poster { width:125px; height:170px; object-fit:cover; border-radius:12px; margin-bottom:8px; box-shadow:0 6px 40px #0009;}
    .moviedetails { flex:1; }
    .movietitle { font-size:2.3em; font-weight: bold; margin-bottom:6px; color:#fff;}
    .moviegenres, .movietags { color:#ffe900; margin-bottom:4px; }
    .moviegenres { font-size:1.05em; }
    .moviedesc { color:#ccc;}
    .datebar { margin:24px 0 14px 0; gap:11px; display:flex;}
    .date-btn {
        padding:11px 28px;
        background:#202128;
        color:#e8f2f2;
        border-radius:10px;
        border:none;
        font-size:1.1em;
        cursor:pointer;
        font-weight: bold;
        outline:none;
        box-shadow:0 1px 8px #07080b77;
        transition: background 0.19s, color 0.19s;
    }
    .date-btn.selected, .date-btn:focus {
        background: #ffe900;
        color: #161819;
    }
    .theatre-block {
        margin:28px 0 0 0;
        background: rgba(32,34,42,0.94);
        border-radius:18px;
        box-shadow:0 4px 32px #0007;
        padding:24px 40px 18px 40px;
        backdrop-filter: blur(0.5px);
        border:1.5px solid #1a222b;
    }
    .theatre-name {
        font-size:1.22em; 
        font-weight: bold;
        color: #fff;
        margin-bottom:13px;
        letter-spacing:.01em;
    }
    .showtimes { display: flex; gap: 24px; flex-wrap:wrap;}
    .show-btn {
        font-size:1.17em;
        background: #131914;
        color: #ffe900;
        border:none;
        border-radius:11px;
        padding:15px 36px;
        cursor:pointer;
        font-weight: bold;
        margin-bottom:8px;
        box-shadow:0 3px 18px #12291333;
        letter-spacing: .01em;
        transition: background 0.23s, color 0.23s;
        outline: none;
    }
    .show-btn:hover, .show-btn:focus {
        background: #ffe900;
        color: #181a1a !important;
    }
    .show-btn span {
        display: block; font-size: .87em; color: #ffe900; font-weight:normal; letter-spacing: 0;
    }
    .no-shows { color: #d4dfe7; margin:45px 0; text-align:center;}
</style>
</head>
<body>
<div class="container">
    <div class="movie-head">
        <img src="<%=poster%>" class="movie-poster">
        <div class="moviedetails">
            <div class="movietitle"><%=title%></div>
            <div class="moviegenres"><%=genre%></div>
            <div class="movietags">
                UA13+ &nbsp;•&nbsp; <%=duration%> &nbsp;•&nbsp; <%=language%>
            </div>
            <div class="moviedesc"><%=desc%></div>
        </div>
    </div>
    <div class="datebar">
        <% for(String d : dateList) { %>
            <form style="display:inline;" method="get">
                <input type="hidden" name="movieid" value="<%=movieId%>">
                <input type="hidden" name="date" value="<%=d%>">
                <button class="date-btn<%=d.equals(selectedDate)?" selected":""%>" type="submit"><%=d%></button>
            </form>
        <% } %>
    </div>
<%
    try (Connection con = DBUtil.getConnection();
        PreparedStatement ps = con.prepareStatement(
        "SELECT th.name as theatre, s.showtime, s.screen_type " +
        "FROM showtimes s JOIN theatres th ON s.theatre_id = th.id " +
        "WHERE s.movie_id=? AND s.date=? ORDER BY th.name, s.showtime")) {
        ps.setInt(1, Integer.parseInt(movieId));
        ps.setString(2, selectedDate);
        ResultSet rs = ps.executeQuery();
        String lastTheatre = "", currentTheatre = "";
        boolean foundAny = false;
        while(rs.next()) {
            foundAny = true;
            currentTheatre = rs.getString("theatre");
            if(!currentTheatre.equals(lastTheatre)){
                if(!lastTheatre.equals("")){ %></div></div> <% }
%>
<div class="theatre-block">
    <div class="theatre-name"><%=currentTheatre%></div>
    <div class="showtimes">
<%          lastTheatre = currentTheatre; }
%>
        <form method="get" action="SeatBookingServlet" style="display:inline;">
            <input type="hidden" name="movieid" value="<%=movieId%>">
            <input type="hidden" name="theatre" value="<%=currentTheatre%>">
            <input type="hidden" name="date" value="<%=selectedDate%>">
            <input type="hidden" name="showtime" value="<%=rs.getString("showtime")%>">
            <button class="show-btn" type="submit">
              <%=rs.getString("showtime")%>
              <% if(rs.getString("screen_type")!=null){ %>
                <span><%=rs.getString("screen_type")%></span>
              <% } %>
            </button>
        </form>
<%
        }
        if(!lastTheatre.equals("")){ %></div></div> <% }
        if(!foundAny) { %>
        <div class="no-shows">No showtimes found for this movie and date.</div>
        <% }
    } catch(Exception e) { %>
        <div class="no-shows">Error: <%=e.getMessage()%></div>
<%}%>
</div>
</div>
</body>
</html>

