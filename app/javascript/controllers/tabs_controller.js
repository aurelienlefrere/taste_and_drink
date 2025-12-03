// ============================================
// 🍷 TASTE & DRINK - Tabs Controller
// Gère les onglets (Photo / Saisie / Ma Cave)
// ============================================

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Définit les "targets" qu'on peut utiliser dans le HTML
  // data-tabs-target="tab" et data-tabs-target="panel"
  static targets = ["tab", "panel"]

  // Méthode appelée quand on clique sur un onglet
  switch(event) {
    // Récupère l'onglet cliqué
    const clickedTab = event.currentTarget
    // Récupère le nom du panel à afficher (data-tab="camera")
    const panelName = clickedTab.dataset.tab

    // === 1. Met à jour les classes "active" sur les onglets ===
    this.tabTargets.forEach(tab => {
      if (tab === clickedTab) {
        tab.classList.add("active")
      } else {
        tab.classList.remove("active")
      }
    })

    // === 2. Affiche/cache les panels correspondants ===
    this.panelTargets.forEach(panel => {
      if (panel.dataset.panel === panelName) {
        panel.classList.add("active")
      } else {
        panel.classList.remove("active")
      }
    })
  }
}
