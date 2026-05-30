import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "sidebar", "dropdown", "modal" ]

  connect() {
    // Add event listener to close dropdown if clicking outside
    this.clickOutsideHandler = (event) => {
      if (this.hasDropdownTarget && !this.dropdownTarget.contains(event.target) && !event.target.closest('[data-action*="toggleDropdown"]')) {
        this.dropdownTarget.classList.add("hidden")
      }
    }
    document.addEventListener("click", this.clickOutsideHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutsideHandler)
  }

  toggleSidebar() {
    if (this.hasSidebarTarget) {
      this.sidebarTarget.classList.toggle("-translate-x-full")
    }
  }

  toggleDropdown(event) {
    event.stopPropagation()
    if (this.hasDropdownTarget) {
      this.dropdownTarget.classList.toggle("hidden")
    }
  }

  openModal(event) {
    if (event) event.preventDefault()
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      this.modalTarget.classList.add("flex")
      document.body.classList.add("overflow-hidden")
    }
  }

  closeModal(event) {
    if (event) event.preventDefault()
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
      this.modalTarget.classList.remove("flex")
      document.body.classList.remove("overflow-hidden")
    }
  }
}
