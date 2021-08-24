function myFunction() {
  event.stopPropagation();
  const dropDown = document.getElementById("myDropdown");
  dropDown.classList.contains("show") ?dropDown.classList.remove("show") :dropDown.classList.add("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
