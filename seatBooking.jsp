<%@ page import="java.util.*" %>
<%
    List<String> bookedSeatsList = (List<String>) request.getAttribute("bookedSeatsList");
    if (bookedSeatsList == null) bookedSeatsList = new ArrayList<>();
    int rows = 7, cols = 14;
    String[] rowLabels = {"A","B","C","D","E","F","G"};
    String jsBooked = "";
    for (int i=0; i<bookedSeatsList.size(); i++) {
        jsBooked += "\"" + bookedSeatsList.get(i) + "\"";
        if (i < bookedSeatsList.size()-1) jsBooked += ",";
    }
%>
<html>
<head>
<style>
body { background: #18181a; color: #fff; font-family: Arial,sans-serif; }
.seat-grid { display: grid; grid-template-rows: repeat(<%=rows%>,30px); grid-template-columns: repeat(<%=cols%>,30px); gap:10px; margin:30px auto;}
.seat { width:24px; height:24px; border-radius:5px; border:none; background:#fff; cursor:pointer;}
.seat.booked { background:#ed2027; cursor:not-allowed; }
.seat.selected { background:#29cc3c; color:#fff; }
.legend { margin:18px auto; }
.legend .box { width:20px; height:20px; display:inline-block; border-radius:5px;}
.legend .avail { background:#fff; border:1px solid #ccc;}
.legend .booked { background:#ed2027;}
.legend .selected { background:#29cc3c;}
.submit-btn {padding:10px 32px;background:#ffe900;color:#000;border:none;font-weight:bold;border-radius:8px;cursor:pointer;}
</style>
</head>
<body>
<h2 style="text-align:center;">SEAT BOOKING</h2>
<div style="text-align:center;margin-bottom:18px;"><span style="background:#232319;padding:8px 34px;border-radius:8px 8px 18px 18px;color:#ffe900;">FACE HERE</span></div>
<form id="seatForm" method="post" action="BookSeatsServlet">
  <div class="seat-grid" id="seatGrid"></div>
  <input type="hidden" name="selectedSeats" id="selectedSeatsInput" />
  <button type="button" class="submit-btn" onclick="submitSeats()">Book Now</button>
  <div class="legend">
    <span class="box selected"></span>Selected
    <span class="box avail"></span>Available
    <span class="box booked"></span>Booked
  </div>
</form>
<script>
const rows = <%=rows%>;
const cols = <%=cols%>;
const rowLabels = <%= Arrays.toString(rowLabels) %>;
const bookedSeats = [<%=jsBooked%>];
let selectedSeats = [];
const grid = document.getElementById('seatGrid');
function getSeatId(r, c) { return rowLabels[r] + (c+1);}
function renderSeats() {
  grid.innerHTML = "";
  for(let r=0;r<rows;r++) for(let c=0;c<cols;c++) {
    const id = getSeatId(r,c);
    const btn=document.createElement("button");
    btn.type="button"; btn.className="seat";
    if(bookedSeats.includes(id)){btn.classList.add("booked");btn.disabled=true;}
    else{btn.onclick=()=>toggleSeat(btn,id);}
    if(selectedSeats.includes(id)){btn.classList.add("selected");}
    grid.appendChild(btn);
  }
}
function toggleSeat(btn,id){
  if(selectedSeats.includes(id)){selectedSeats=selectedSeats.filter(seat=>seat!=id);btn.classList.remove("selected");}
  else{selectedSeats.push(id);btn.classList.add("selected");}
  document.getElementById('selectedSeatsInput').value=selectedSeats.join(",");
}
function submitSeats(){
  if(selectedSeats.length==0){alert("Please select at least one seat!");return;}
  document.getElementById('seatForm').submit();
}
renderSeats();
</script>
</body>
</html>


