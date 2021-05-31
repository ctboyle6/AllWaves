// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div
import Rails from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    this.submitForm();
  }
  handleSelect() {
    this.submitForm();
  }
  submitForm() {
    Rails.fire(this.element, "submit");
  }
}
