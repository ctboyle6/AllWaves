import Rails from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    Rails.fire(this.element, "click");
  }
}
