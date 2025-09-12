<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
  // Example: bookedSeatsList is passed as a List<String> attribute from servlet
  java.util.List<String> bookedSeatsList = (java.util.List<String>) request.getAttribute("bookedSeatsList");
  if(bookedSeatsList == null) {
    bookedSeatsList = new java.util.ArrayList<>();
  }

  // Convert list to quoted, comma-separated string to pass to JS
  StringBuilder jsArray = new StringBuilder();
  for(int i=0; i < bookedSeatsList.size(); i++) {
    jsArray.append("\"").append(bookedSeatsList.get(i)).append("\"");
    if(i < bookedSeatsList.size()-1) jsArray.append(", ");
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Seat Booking</title>
    <style>
      /* Your existing styles here */
    </style>
</head>
<body>

<h1>🎬 Seat Booking</h1>
<div class="screen">SCREEN</div>
<div class="seats" id="seats"></div>

<div class="legend">
    <div><div class="box available"></div>Available</div>
    <div><div class="box selected"></div>Selected</div>
    <div><div class="box booked"></div>Booked</div>
</div>

<form id="bookingForm" method="post" action="BookSeatsServlet">
  <input type="hidden" name="selectedSeats" id="selectedSeatsInput" />
  <button type="button" class="btn" onclick="goNext()">Book Now</button>
</form>

<script>
  const bookedSeats = [<%= jsArray.toString() %>];
  const rows = 6;  // A-F
  const cols = 12; // 1-12
  const seatsContainer = document.getElementById("seats");
  let selectedSeats = [];

  function generateSeats() {
    const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (let r = 0; r < rows; r++) {
      for (let c = 1; c <= cols; c++) {
        const seatId = alphabet[r] + c;
        const seat = document.createElement("div");
        seat.classList.add("seat");

        if (bookedSeats.includes(seatId)) {
          seat.classList.add("booked");
        } else {
          seat.classList.add("available");
          seat.addEventListener("click", () => toggleSeat(seat, seatId));
        }

        seat.textContent = seatId;
        seatsContainer.appendChild(seat);
      }
    }
  }

  function toggleSeat(seat, seatId) {
    if (seat.classList.contains("available")) {
      seat.classList.remove("available");
      seat.classList.add("selected");
      selectedSeats.push(seatId);
    } else if (seat.classList.contains("selected")) {
      seat.classList.remove("selected");
      seat.classList.add("available");
      selectedSeats = selectedSeats.filter(s => s !== seatId);
    }
  }

  function goNext() {
    if (selectedSeats.length === 0) {
      alert("Please select at least one seat!");
      return;
    }
    document.getElementById('selectedSeatsInput').value = selectedSeats.join(',');
    document.getElementById('bookingForm').submit();
  }

  generateSeats();
</script>

</body>
</html>

