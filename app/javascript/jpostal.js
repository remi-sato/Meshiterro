document.addEventListener("turbo:load", () => {
  $("#zipcode").on("keyup", function () {
    AjaxZip3.zip2addr(this, "", "post_image[address]", "post_image[address]");
  });
});