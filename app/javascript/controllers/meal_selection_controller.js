import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["drinkCard", "checkbox", "submitBtn", "countText"]

  connect() {
    console.log("Meal selection controller connected")
    console.log("Nombre de cards:", this.drinkCardTargets.length)
    console.log("Nombre de checkboxes:", this.checkboxTargets.length)
    this.updateButtonState()
  }

  toggleSelection(event) {
    // Récupérer le label cliqué
    const label = event.currentTarget

    // Trouver la checkbox à l'intérieur du label
    const checkbox = label.querySelector('.drink-checkbox')

    // Trouver la card parente
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
      card.style.borderColor = '#667eea'
      card.style.borderWidth = '3px'
      card.style.boxShadow = '0 6px 20px rgba(102, 126, 234, 0.4)'
    } else {
      card.style.borderColor = ''
      card.style.borderWidth = ''
      card.style.boxShadow = ''
    }

    this.updateButtonState()
  }

  updateButtonState() {
    // Récupérer toutes les checkboxes (même celles sans target)
    const allCheckboxes = this.element.querySelectorAll('.drink-checkbox')
    const checkedCount = Array.from(allCheckboxes).filter(cb => cb.checked).length

    console.log("Nombre de checkboxes cochées:", checkedCount)

    // Activer/désactiver le bouton
    if (this.hasSubmitBtnTarget) {
      this.submitBtnTarget.disabled = checkedCount === 0
    }

    // Mettre à jour le texte
    if (this.hasCountTextTarget) {
      if (checkedCount === 0) {
        this.countTextTarget.textContent = 'Sélectionnez au moins une boisson'
        this.countTextTarget.classList.remove('active')
      } else if (checkedCount === 1) {
        this.countTextTarget.textContent = '✓ 1 boisson sélectionnée'
        this.countTextTarget.classList.add('active')
      } else {
        this.countTextTarget.textContent = `✓ ${checkedCount} boissons sélectionnées`
        this.countTextTarget.classList.add('active')
      }
    }
  }
}
