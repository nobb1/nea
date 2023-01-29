import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ "conjugation" ]

  initialize() {
    console.log(this.element);
  }
  
  changed() {
    console.log("Changed");
  }
}