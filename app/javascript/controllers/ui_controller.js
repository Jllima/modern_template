import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 1. Adicionamos sidebarOverlay e main na lista
  static targets = ["sidebar", "sidebarOverlay", "dropdown", "modal", "main"]

  connect() {
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

  toggleSidebar(event) {
    if (event) event.preventDefault()

    const isDesktop = window.innerWidth >= 1024;

    if (isDesktop) {
      // 💻 WEB: Remove a classe que trava a sidebar na tela e a classe que empurra o conteúdo
      if (this.hasSidebarTarget) {
        this.sidebarTarget.classList.toggle("lg:translate-x-0")
      }
      if (this.hasMainTarget) {
        this.mainTarget.classList.toggle("lg:pl-64")
      }
    } else {
      // 📱 MOBILE: Alterna a entrada da sidebar e liga/desliga o fundo escuro
      if (this.hasSidebarTarget) {
        this.sidebarTarget.classList.toggle("-translate-x-full")
      }
      if (this.hasSidebarOverlayTarget) {
        this.sidebarOverlayTarget.classList.toggle("hidden")
      }
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