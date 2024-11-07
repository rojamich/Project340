// Add employee popup
document.getElementById("addEmployeesButton").addEventListener("click", function() {
    document.getElementById("popupTitle").textContent = "Add Employee";
    document.getElementById("employeesForm").reset(); 
    document.getElementById("popupOverlay").style.display = "block";
});

// Edit employee popup
document.querySelectorAll(".editButton").forEach(button => {
    button.addEventListener("click", function() {
      document.getElementById("popupTitle").textContent = "Edit Employee";
      document.getElementById("employeeID").value = button.getAttribute("data-employeeID");
      document.getElementById("name").value = button.getAttribute("data-name");
      document.getElementById("position").value = button.getAttribute("data-position");
      document.getElementById("email").value = button.getAttribute("data-email");
      document.getElementById("phone").value = button.getAttribute("data-phone");
      document.getElementById("popupOverlay").style.display = "block";
    });
  });

// Delete employee popup
document.querySelectorAll(".deleteButton").forEach(button => {
    button.addEventListener("click", function() {
        var employeeName = button.getAttribute("data-name");
        confirm(`Are you sure you want to remove ${employeeName}?`);
      }
    )});

// Close
document.getElementById("popupClose").addEventListener("click", function() {
    document.getElementById("popupOverlay").style.display = "none";
});
