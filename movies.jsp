<%@ page import="java.sql.*" %>
<%
String user = (String) session.getAttribute("user");
if(user == null) { response.sendRedirect("login.html"); return; }
%>
<!DOCTYPE html>
<html>
<head><title>Movies</title></head>
<body style="background:#181818;color:#fff;">
<h2>Welcome, <%= user %></h2>
<h3>Available Movies:</h3>
<%
try (Connection con = DBUtil.getConnection();
     Statement st = con.createStatement();
     ResultSet rs = st.executeQuery("SELECT * FROM movies")) {
    while(rs.next()) {
%>
    <div>
        <b><%= rs.getString("title") %></b><br>
        <small><%= rs.getString("description") %></small><br>
        <form action="book" method="POST">
            <input type="hidden" name="movieid" value="<%= rs.getInt("id") %>">
            Seats: <input type="text" name="seats">
            <button type="submit">Book Now</button>
        </form>
    </div>
<%
    }
} catch(Exception e) { out.println("DB error!"); }
%>
</body>
</html>

