import { Controller } from "@hotwired/stimulus"

// Controller pour les carousels swipables
export default class extends Controller {
  static targets = ["container", "track"]
  static values = {
    index: { type: Number, default: 0 },
    cardWidth: { type: Number, default: 140 },
    gap: { type: Number, default: 12 }
  }

  connect() {
    this.setupTouchEvents()
    this.startX = 0
    this.currentX = 0
    this.isDragging = false
  }

  setupTouchEvents() {
    const track = this.trackTarget

    // Touch events (mobile)
    track.addEventListener('touchstart', (e) => this.handleDragStart(e), { passive: true })
    track.addEventListener('touchmove', (e) => this.handleDragMove(e), { passive: true })
    track.addEventListener('touchend', () => this.handleDragEnd())

    // Mouse events (desktop)
    track.addEventListener('mousedown', (e) => this.handleDragStart(e))
    track.addEventListener('mousemove', (e) => this.handleDragMove(e))
    track.addEventListener('mouseup', () => this.handleDragEnd())
    track.addEventListener('mouseleave', () => this.handleDragEnd())
  }

  handleDragStart(e) {
    this.isDragging = true
    // Récupère la position X selon le type d'événement
    this.startX = e.type.includes('mouse') ? e.pageX : e.touches[0].clientX
    this.scrollLeft = this.trackTarget.scrollLeft
    this.trackTarget.style.cursor = 'grabbing'
  }

  handleDragMove(e) {
    if (!this.isDragging) return

    const x = e.type.includes('mouse') ? e.pageX : e.touches[0].clientX
    const walk = (this.startX - x) * 1.5  // Multiplicateur de vitesse
    this.trackTarget.scrollLeft = this.scrollLeft + walk
  }

  handleDragEnd() {
    this.isDragging = false
    this.trackTarget.style.cursor = 'grab'
  }

  // Navigation par boutons (si tu veux ajouter des flèches)
  prev() {
    const scrollAmount = this.cardWidthValue + this.gapValue
    this.trackTarget.scrollBy({ left: -scrollAmount, behavior: 'smooth' })
  }

  next() {
    const scrollAmount = this.cardWidthValue + this.gapValue
    this.trackTarget.scrollBy({ left: scrollAmount, behavior: 'smooth' })
  }
}
