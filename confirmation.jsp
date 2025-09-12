<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Booking Confirmed</title>
  <style>
    body {
      background: #16181d;
      color: #fff;
      font-family: 'Segoe UI', Arial, sans-serif;
      min-height: 100vh;
      margin: 0;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    .confirmed-icon {
      margin-top: 68px;
      margin-bottom: 24px;
    }
    .confirmed-icon svg {
      width: 90px;
      height: 90px;
      display: block;
      margin: 0 auto;
    }
    .confirm-title {
      font-size: 2.3rem;
      font-weight: bold;
      margin-bottom: 32px;
      text-align: center;
      letter-spacing: 1.1px;
    }
    .details-card {
      background: #212329;
      padding: 14px 34px 18px 34px;
      border-radius: 16px;
      box-shadow: 0 5px 32px rgba(0,0,0,0.11);
      min-width: 340px;
      margin-bottom: 14px;
    }
    .detail-row {
      display: flex;
      align-items: center;
      margin: 16px 0;
      border-radius: 10px;
      justify-content: start;
      font-size: 1.18rem;
    }
    .detail-label {
      color: #b2b9c2;
      font-weight: 550;
      margin-right: 26px;
      min-width: 74px;
      letter-spacing: 0.6px;
    }
    .detail-value {
      color: #fff;
      font-weight: 635;
      letter-spacing: 0.3px;
    }
    @media (max-width: 500px) {
      .details-card {
        min-width: unset;
        width: 94vw;
        padding: 7vw 3vw;
      }
      .confirm-title {
        font-size: 1.5rem;
      }
    }
  </style>
</head>
<body>
  <div class="confirmed-icon">
    <!-- Checkmark in circle SVG -->
    <svg viewBox="0 0 72 72" fill="none">
      <circle cx="36" cy="36" r="34" stroke="#49CD7D" stroke-width="4"/>
      <path d="M22 37L33 48L50 29" stroke="#49CD7D" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </div>
  <div class="confirm-title">Booking Confirmed</div>
  <div class="details-card">
    <div class="detail-row">
      <span class="detail-label">Movie</span>
      <span class="detail-value"><%= request.getAttribute("movie") %></span>
    </div>
    <div class="detail-row">
      <span class="detail-label">Time</span>
      <span class="detail-value"><%= request.getAttribute("time") %></span>
    </div>
    <div class="detail-row">
      <span class="detail-label">Seats</span>
      <span class="detail-value"><%= request.getAttribute("seats") %></span>
    </div>
  </div>
</body>
</html>

