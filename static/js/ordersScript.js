// Add order popup
document.getElementById("addOrdersButton").addEventListener("click", function() {
    document.getElementById("popupTitle").textContent = "Add Order";
    document.getElementById("ordersForm").reset(); 
    document.getElementById("popupOverlay").style.display = "block";
});

// Edit order popup
document.querySelectorAll(".editButton").forEach(button => {
    button.addEventListener("click", function() {
      document.getElementById("popupTitle").textContent = "Edit Order";
      document.getElementById("orderID").value = button.getAttribute("data-orderID");
      document.getElementById("ordered").value = button.getAttribute("data-ordered");
      document.getElementById("pickedUp").value = button.getAttribute("data-pickedUp");
      document.getElementById("status").value = button.getAttribute("data-status");
      document.getElementById("customer").value = button.getAttribute("data-customer");
      document.getElementById("popupOverlay").style.display = "block";
    });
  });

// Delete order popup
document.querySelectorAll(".deleteButton").forEach(button => {
    button.addEventListener("click", function() {
        var orderID = button.getAttribute("data-orderID");
        confirm(`Are you sure you want to remove ${orderID}?`);
      }
    )});

// Close
document.getElementById("popupClose").addEventListener("click", function() {
    document.getElementById("popupOverlay").style.display = "none";
});
