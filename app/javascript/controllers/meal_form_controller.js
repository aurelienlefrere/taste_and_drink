import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dishInput", "photoInput", "photoLabel", "submitBtn"]

  connect() {
    console.log("Meal form controller connected")

    // Trouver le bouton Match de la footbar
    this.footbarMatchBtn = document.querySelector('.td-footbar-icon-match')
    this.footbarMatchIcon = this.footbarMatchBtn?.querySelector('i')

    // Initialiser l'état du bouton
    this.updateMatchButton()

    // Écouter le clic sur le bouton Match
    if (this.footbarMatchBtn) {
      this.footbarMatchBtn.addEventListener('click', this.handleMatchClick.bind(this))
    }

    // Gérer le label de la photo
    if (this.hasPhotoInputTarget) {
      this.photoInputTarget.addEventListener('change', this.updatePhotoLabel.bind(this))
    }
  }

  disconnect() {
    // Nettoyer l'écouteur d'événement
    if (this.footbarMatchBtn) {
      this.footbarMatchBtn.removeEventListener('click', this.handleMatchClick.bind(this))
    }
  }

  updateMatchButton() {
    if (!this.footbarMatchBtn) return

    const dishValue = this.dishInputTarget.value.trim()

    if (dishValue && dishValue.length > 0) {
      // Mode "Valider" : bouton actif
      this.footbarMatchBtn.classList.add('td-footbar-active')

      if (this.footbarMatchIcon) {
        this.footbarMatchIcon.className = 'fas fa-rocket'
      }
    } else {
      // Mode "Normal"
      this.footbarMatchBtn.classList.remove('td-footbar-active')

      if (this.footbarMatchIcon) {
        this.footbarMatchIcon.className = 'fas fa-utensils-alt'
      }
    }
  }

  handleMatchClick(event) {
    const dishValue = this.dishInputTarget.value.trim()

    if (dishValue && dishValue.length > 0) {
      // Empêcher la navigation
      event.preventDefault()
      event.stopPropagation()

      // Soumettre le formulaire
      this.element.submit()
    }
    // Si le champ est vide, laisser le comportement par défaut
  }

  updatePhotoLabel(event) {
    const file = event.target.files[0]
    if (file) {
      this.photoLabelTarget.textContent = `Photo : ${file.name}`
    } else {
      this.photoLabelTarget.textContent = "Prendre une photo du repas"
    }
  }
}
