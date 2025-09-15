<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ThrillBuzz Cinema Booking</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(to bottom, #000 0%, #333 100%);
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Share Tech Mono', monospace;
      color: #fff;
    }
    .container {
      text-align: center;
    }
    .logo {
      width: 220px;
      margin-bottom: 32px;
      filter: drop-shadow(0 0 16px #fff3);
    }
    .title {
      font-size: 2.3rem;
      font-weight: bold;
      margin-bottom: 24px;
      letter-spacing: 2px;
      color: #fff;
      text-shadow: 0 0 12px #ffe651,0 0 5px #f444ae,0 0 7px #15f5c6;
    }
    .button-row {
      margin-top: 32px;
      display: flex;
      justify-content: center;
      gap: 24px;
    }
    .btn {
      padding: 13px 34px;
      font-size: 1.14rem;
      border: 2px solid #15f5c6;
      border-radius: 20px;
      background: none;
      color: #ffe651;
      font-weight: bold;
      box-shadow: 0 0 14px #f444ae,0 0 7px #15f5c6;
      cursor: pointer;
      transition: background 0.18s, color 0.18s, border-color 0.16s;
    }
    .btn:hover {
      background: #ffe651;
      color: #181818;
      border-color: #f444ae;
      box-shadow: 0 0 30px #15f5c6, 0 0 16px #f444ae;
    }
    @media (max-width: 700px) {
      .logo { width: 140px; }
      .title { font-size: 1.23rem; }
      .btn { font-size: 1rem; padding: 10px 18px; }
      .button-row { gap: 10px; }
    }
  </style>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
</head>
<body>
  <div class="container">
    <img src="images/logo.jpeg" alt="ThrillBuzz Logo" class="logo">
    <div class="title">Welcome to ThrillBuzz Cinema Booking</div>
    <div class="button-row">
      <a href="login.html"><button class="btn">Login</button></a>
      <a href="register.html"><button class="btn">Register</button></a>
    </div>
  </div>
</body>
</html>

