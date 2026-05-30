import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "count" ]

  connect() {
    this.count = 0
    this.updateCount()
  }

  increment() {
    this.count++
    this.updateCount()
  }

  decrement() {
    if (this.count > 0) {
      this.count--
      this.updateCount()
    }
  }

  updateCount() {
    if (this.hasCountTarget) {
      this.countTarget.textContent = this.count
    }
  }
}
