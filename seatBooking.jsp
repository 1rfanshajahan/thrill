<%@ page import="java.util.*" %>
<%
    List<String> bookedSeatsList = (List<String>) request.getAttribute("bookedSeatsList");
    if (bookedSeatsList == null) bookedSeatsList = new ArrayList<>();
    int rows = 7, cols = 14;
%>
<script>
const rows = <%= rows %>;
const cols = <%= cols %>;
const rowLabels = ["A","B","C","D","E","F","G"];
// Properly formatted JavaScript string array:
const bookedSeats = <%= bookedSeatsList.toString().replace("[", "[\"").replace("]", "\"]").replace(", ", "\",\"") %>;
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

