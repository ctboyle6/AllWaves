import Rails from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    Rails.fire(this.element, "click");
  }

  // handleSelect() {
  //   this.submitForm();
  // }
  // submitForm() {
  //   Rails.fire(this.element, "submit");
  // }
}
