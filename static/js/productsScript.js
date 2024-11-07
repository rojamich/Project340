// Add product popup
document.getElementById("addProductsButton").addEventListener("click", function() {
    document.getElementById("popupTitle").textContent = "Add Product";
    document.getElementById("productsForm").reset(); 
    document.getElementById("popupOverlay").style.display = "block";
});

// Edit product popup
document.querySelectorAll(".editButton").forEach(button => {
    button.addEventListener("click", function() {
      document.getElementById("popupTitle").textContent = "Edit Product";
      document.getElementById("productsID").value = button.getAttribute("data-productsID");
      document.getElementById("type").value = button.getAttribute("data-type");
      document.getElementById("size").value = button.getAttribute("data-size");
      document.getElementById("flavor").value = button.getAttribute("data-flavor");
      document.getElementById("price").value = button.getAttribute("data-price");
      document.getElementById("popupOverlay").style.display = "block";
    });
  });

// Delete product popup
document.querySelectorAll(".deleteButton").forEach(button => {
    button.addEventListener("click", function() {
        var productsName = button.getAttribute("data-productsID");
        confirm(`Are you sure you want to remove ${productsName}?`);
      }
    )});

// Close
document.getElementById("popupClose").addEventListener("click", function() {
    document.getElementById("popupOverlay").style.display = "none";
});
