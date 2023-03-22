import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ "field" ]
  static values = {
    input: String,
    show: String
  }

  initialize() {
    // adding data to tags in toggle_controller.js, adding them directly to html does not work
    document.getElementById("translation_word_type").dataset.action = "toggle#changed";
  }

  connect() {
    this.inputField = document.getElementById(this.inputValue)
    this.targetElement = this.fieldTarget
    this.original = this.targetElement.style.display

    this.targetElement.style.display = "none"
  }

  changed() {
    if (this.inputField.value == this.showValue) {
      this.targetElement.style.display = this.original
    } else {
      this.targetElement.style.display = "none"
    }
  }
}