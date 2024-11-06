// Add customer popup
document.getElementById("addCustomerButton").addEventListener("click", function() {
    document.getElementById("popupTitle").textContent = "Add Customer";
    document.getElementById("customerForm").reset(); 
    document.getElementById("popupOverlay").style.display = "block";
});

// Edit customer popup
document.querySelectorAll(".editButton").forEach(button => {
    button.addEventListener("click", function() {
      document.getElementById("popupTitle").textContent = "Edit Customer";
      document.getElementById("name").value = button.getAttribute("data-name");
      document.getElementById("email").value = button.getAttribute("data-email");
      document.getElementById("phone").value = button.getAttribute("data-phone");
      document.getElementById("popupOverlay").style.display = "block";
    });
  });

// Delete customer popup
document.querySelectorAll(".deleteButton").forEach(button => {
    button.addEventListener("click", function() {
        var customerName = button.getAttribute("data-name");
        confirm(`Are you sure you want to remove ${customerName}?`);
      }
    )});

// Close
document.getElementById("popupClose").addEventListener("click", function() {
    document.getElementById("popupOverlay").style.display = "none";
});
