import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "checkbox", "drinkCard"]

  connect() {
    console.log("Meal show controller connected")
    console.log("Nombre de cards:", this.drinkCardTargets.length)
    console.log("Nombre de checkboxes:", this.checkboxTargets.length)

    // Trouver le bouton Match de la footbar
    this.footbarMatchBtn = document.querySelector('.td-footbar-icon-match')
    this.footbarMatchIcon = this.footbarMatchBtn?.querySelector('i')

    // Vérifier si nous sommes en mode sélection
    this.isSelectionMode = this.hasFormTarget

    if (this.isSelectionMode) {
      // Initialiser l'état du bouton
      this.updateMatchButton()

      // Écouter le clic sur le bouton Match
      if (this.footbarMatchBtn) {
        this.footbarMatchBtn.addEventListener('click', this.handleMatchClick.bind(this))
      }
    }
  }

  disconnect() {
    if (this.footbarMatchBtn && this.isSelectionMode) {
      this.footbarMatchBtn.removeEventListener('click', this.handleMatchClick.bind(this))
    }
  }

  toggleSelection(event) {
    const label = event.currentTarget
    const checkbox = label.querySelector('.drink-checkbox')
    const card = label.closest('.td-wine-card')

    if (!checkbox || !card) {
      console.error("Checkbox ou card introuvable")
      return
    }

    // Toggle la checkbox
    checkbox.checked = !checkbox.checked

    console.log("Checkbox toggled:", checkbox.checked)

    // Effet visuel : BORDURE BLEUE élégante quand sélectionné
    if (checkbox.checked) {
      card.style.borderColor = '#5D2A32'
      card.style.borderWidth = '3px'
      card.style.boxShadow = '0 6px 20px rgba(102, 126, 234, 0.4)'
    } else {
      card.style.borderColor = ''
      card.style.borderWidth = ''
      card.style.boxShadow = ''
    }

    // Mettre à jour le bouton Match
    this.updateMatchButton()
  }

  updateMatchButton() {
    if (!this.footbarMatchBtn || !this.isSelectionMode) return

    // Récupérer toutes les checkboxes
    const allCheckboxes = this.element.querySelectorAll('.drink-checkbox')
    const checkedCount = Array.from(allCheckboxes).filter(cb => cb.checked).length

    console.log("Nombre de checkboxes cochées:", checkedCount)

    if (checkedCount > 0) {
      // Mode "Valider sélection" : bouton actif VERT
      this.footbarMatchBtn.classList.add('td-footbar-validate')

      if (this.footbarMatchIcon) {
        this.footbarMatchIcon.className = 'fas fa-check-circle'
      }
    } else {
      // Mode "Normal"
      this.footbarMatchBtn.classList.remove('td-footbar-validate')

      if (this.footbarMatchIcon) {
        this.footbarMatchIcon.className = 'fas fa-utensils-alt'
      }
    }
  }

  handleMatchClick(event) {
    if (!this.isSelectionMode) return

    const allCheckboxes = this.element.querySelectorAll('.drink-checkbox')
    const checkedCount = Array.from(allCheckboxes).filter(cb => cb.checked).length

    if (checkedCount > 0) {
      // Empêcher la navigation
      event.preventDefault()
      event.stopPropagation()

      // Soumettre le formulaire directement
      this.formTarget.submit()
    }
  }
}
