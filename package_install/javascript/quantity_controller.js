// app/javascript/controllers/quantity_controller.js
// Controller Stimulus pour gérer les boutons +/- de quantité

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  
  // Méthode appelée quand on clique sur le bouton "+"
  increase() {
    const currentValue = parseInt(this.inputTarget.value) || 0
    this.inputTarget.value = currentValue + 1
  }
  
  // Méthode appelée quand on clique sur le bouton "-"
  decrease() {
    const currentValue = parseInt(this.inputTarget.value) || 1
    // On ne peut pas descendre en dessous de 1
    if (currentValue > 1) {
      this.inputTarget.value = currentValue - 1
    }
  }
}
