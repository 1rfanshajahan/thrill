<%
String user = (String) session.getAttribute("user");
if (user != null) {
    response.sendRedirect("movies.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to Movie Booking</title>
  <style>
    body {
      background: linear-gradient(to bottom, #000 0%, #333 100%);
      color: #fff;
      font-family: sans-serif;
      display: flex;
      height: 100vh;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      margin: 0;
    }
    a {
      color: #55aaff;
      text-decoration: none;
      margin: 10px;
      font-size: 1.2rem;
      border: 2px solid #55aaff;
      padding: 10px 20px;
      border-radius: 24px;
      transition: background-color 0.2s;
    }
    a:hover {
      background-color: #55aaff;
      color: #000;
    }
    h1 {
      margin-bottom: 40px;
      font-size: 2.5rem;
    }
  </style>
</head>
<body>
  <h1>Welcome to ThrillBuzz Cinema Booking</h1>
  <div>
    <a href="login.html">Login</a>
    <a href="register.html">Register</a>
  </div>
</body>
</html>

