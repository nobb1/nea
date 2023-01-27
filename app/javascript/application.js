// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"

$(document).on("change", "#translation_word_type", function() {
  let type = $(this).val();
  console.log(type);
  if (type != "") {
    if (type == "verb") {
      $(".conjugation").show();
      $(".word").text("Word (infinitive):")
    } else {
      $(".conjugation").hide();
      $(".word").text("Word:")
    }
  }
})