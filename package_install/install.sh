#!/bin/bash

# ============================================
# 🍷 Installation Automatique - Taste & Drink
# Script d'installation complète des modifications
# ============================================

set -e  # Arrêter en cas d'erreur

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Fonctions d'affichage
print_header() {
    echo ""
    echo -e "${MAGENTA}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║                                                      ║${NC}"
    echo -e "${MAGENTA}║  🍷  Installation Taste & Drink - Modifications UI  ║${NC}"
    echo -e "${MAGENTA}║                                                      ║${NC}"
    echo -e "${MAGENTA}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${CYAN}➜ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Récupérer le chemin du script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_header

# ============================================
# ÉTAPE 0 : Vérifications préliminaires
# ============================================
print_step "ÉTAPE 0 : Vérifications préliminaires"

# Vérifier qu'on est dans un projet Rails
if [ ! -f "Gemfile" ]; then
    print_error "Ce script doit être exécuté depuis la racine du projet Rails"
    print_info "Naviguez vers votre dossier taste_and_drink avant d'exécuter ce script"
    exit 1
fi

print_success "Projet Rails détecté"

# Vérifier que les fichiers sources existent
if [ ! -d "$SCRIPT_DIR/views" ]; then
    print_error "Dossier 'views' introuvable dans le package d'installation"
    print_info "Assurez-vous que le dossier package_install est complet"
    exit 1
fi

print_success "Package d'installation vérifié"
echo ""

# ============================================
# ÉTAPE 1 : Vérification de l'image de fond
# ============================================
print_step "ÉTAPE 1 : Vérification de l'image de fond"

if [ ! -f "app/assets/images/background_wine.png" ]; then
    print_warning "L'image background_wine.png n'est pas trouvée !"
    print_info "Après l'installation, copiez manuellement l'image :"
    print_info "  - Renommez 'ChatGPT_Image_8_déc__2025__21_30_17.png'"
    print_info "  - en 'background_wine.png'"
    print_info "  - dans app/assets/images/background_wine.png"
    echo ""
    read -p "Voulez-vous continuer quand même ? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation annulée"
        exit 1
    fi
else
    print_success "Image de fond trouvée"
fi
echo ""

# ============================================
# ÉTAPE 2 : Sauvegarde des fichiers existants
# ============================================
print_step "ÉTAPE 2 : Sauvegarde des fichiers existants"

BACKUP_DIR="backup_taste_drink_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Liste des fichiers à sauvegarder
declare -A FILES_TO_BACKUP=(
    ["app/views/layouts/application.html.erb"]=""
    ["app/views/shared/_navbar.html.erb"]=""
    ["app/views/pages/home.html.erb"]=""
    ["app/views/meals/index.html.erb"]=""
    ["app/views/stocks/new.html.erb"]=""
    ["app/views/friends/index.html.erb"]=""
    ["app/assets/stylesheets/components/layout.scss"]=""
    ["app/assets/stylesheets/components/_navbar.scss"]=""
    ["app/assets/stylesheets/pages/_home.scss"]=""
    ["app/assets/stylesheets/pages/_events.scss"]=""
    ["app/assets/stylesheets/pages/_friends.scss"]=""
    ["app/assets/stylesheets/pages/_match.scss"]=""
    ["app/assets/stylesheets/pages/_index.scss"]=""
)

for file in "${!FILES_TO_BACKUP[@]}"; do
    if [ -f "$file" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname $file)"
        cp "$file" "$BACKUP_DIR/$file"
        print_success "Sauvegardé: $file"
    fi
done

print_success "Sauvegarde créée dans : $BACKUP_DIR"
echo ""

# ============================================
# ÉTAPE 3 : Installation des fichiers de vues
# ============================================
print_step "ÉTAPE 3 : Installation des fichiers de vues (.html.erb)"

# Copier application.html.erb
if [ -f "$SCRIPT_DIR/views/application.html.erb" ]; then
    cp "$SCRIPT_DIR/views/application.html.erb" "app/views/layouts/application.html.erb"
    print_success "app/views/layouts/application.html.erb"
fi

# Copier _navbar.html.erb
if [ -f "$SCRIPT_DIR/views/_navbar.html.erb" ]; then
    cp "$SCRIPT_DIR/views/_navbar.html.erb" "app/views/shared/_navbar.html.erb"
    print_success "app/views/shared/_navbar.html.erb"
fi

# Copier home.html.erb
if [ -f "$SCRIPT_DIR/views/home.html.erb" ]; then
    cp "$SCRIPT_DIR/views/home.html.erb" "app/views/pages/home.html.erb"
    print_success "app/views/pages/home.html.erb"
fi

# Copier meals_index.html.erb
if [ -f "$SCRIPT_DIR/views/meals_index.html.erb" ]; then
    cp "$SCRIPT_DIR/views/meals_index.html.erb" "app/views/meals/index.html.erb"
    print_success "app/views/meals/index.html.erb"
fi

# Copier stocks_new.html.erb
if [ -f "$SCRIPT_DIR/views/stocks_new.html.erb" ]; then
    cp "$SCRIPT_DIR/views/stocks_new.html.erb" "app/views/stocks/new.html.erb"
    print_success "app/views/stocks/new.html.erb"
fi

# Copier friends_index.html.erb
if [ -f "$SCRIPT_DIR/views/friends_index.html.erb" ]; then
    cp "$SCRIPT_DIR/views/friends_index.html.erb" "app/views/friends/index.html.erb"
    print_success "app/views/friends/index.html.erb"
fi

echo ""

# ============================================
# ÉTAPE 4 : Installation des styles (remplacements)
# ============================================
print_step "ÉTAPE 4 : Installation des styles à remplacer"

# Copier layout.scss
if [ -f "$SCRIPT_DIR/stylesheets/layout.scss" ]; then
    cp "$SCRIPT_DIR/stylesheets/layout.scss" "app/assets/stylesheets/components/layout.scss"
    print_success "app/assets/stylesheets/components/layout.scss"
fi

# Copier _navbar.scss
if [ -f "$SCRIPT_DIR/stylesheets/_navbar.scss" ]; then
    cp "$SCRIPT_DIR/stylesheets/_navbar.scss" "app/assets/stylesheets/components/_navbar.scss"
    print_success "app/assets/stylesheets/components/_navbar.scss"
fi

echo ""

# ============================================
# ÉTAPE 5 : Enrichissement des fichiers SCSS
# ============================================
print_step "ÉTAPE 5 : Enrichissement des fichiers SCSS existants"

# Ajouter à _home.scss
if [ -f "$SCRIPT_DIR/stylesheets/_home_nouveaux_styles.scss" ] && [ -f "app/assets/stylesheets/pages/_home.scss" ]; then
    echo "" >> "app/assets/stylesheets/pages/_home.scss"
    cat "$SCRIPT_DIR/stylesheets/_home_nouveaux_styles.scss" >> "app/assets/stylesheets/pages/_home.scss"
    print_success "Enrichi: app/assets/stylesheets/pages/_home.scss"
fi

# Ajouter à _events.scss
if [ -f "$SCRIPT_DIR/stylesheets/_events_nouveaux_styles.scss" ] && [ -f "app/assets/stylesheets/pages/_events.scss" ]; then
    echo "" >> "app/assets/stylesheets/pages/_events.scss"
    cat "$SCRIPT_DIR/stylesheets/_events_nouveaux_styles.scss" >> "app/assets/stylesheets/pages/_events.scss"
    print_success "Enrichi: app/assets/stylesheets/pages/_events.scss"
fi

# Ajouter à _friends.scss
if [ -f "$SCRIPT_DIR/stylesheets/_friends_nouveaux_styles.scss" ] && [ -f "app/assets/stylesheets/pages/_friends.scss" ]; then
    echo "" >> "app/assets/stylesheets/pages/_friends.scss"
    cat "$SCRIPT_DIR/stylesheets/_friends_nouveaux_styles.scss" >> "app/assets/stylesheets/pages/_friends.scss"
    print_success "Enrichi: app/assets/stylesheets/pages/_friends.scss"
fi

# Ajouter à _match.scss
if [ -f "$SCRIPT_DIR/stylesheets/_match_nouveaux_styles.scss" ] && [ -f "app/assets/stylesheets/pages/_match.scss" ]; then
    echo "" >> "app/assets/stylesheets/pages/_match.scss"
    cat "$SCRIPT_DIR/stylesheets/_match_nouveaux_styles.scss" >> "app/assets/stylesheets/pages/_match.scss"
    print_success "Enrichi: app/assets/stylesheets/pages/_match.scss"
fi

echo ""

# ============================================
# ÉTAPE 6 : Création du nouveau fichier _stock_new.scss
# ============================================
print_step "ÉTAPE 6 : Création de _stock_new.scss"

if [ -f "$SCRIPT_DIR/stylesheets/_stock_new.scss" ]; then
    cp "$SCRIPT_DIR/stylesheets/_stock_new.scss" "app/assets/stylesheets/pages/_stock_new.scss"
    print_success "Créé: app/assets/stylesheets/pages/_stock_new.scss"
    
    # Ajouter l'import dans _index.scss
    if [ -f "app/assets/stylesheets/pages/_index.scss" ]; then
        if ! grep -q '@import "stock_new";' "app/assets/stylesheets/pages/_index.scss"; then
            echo '@import "stock_new";' >> "app/assets/stylesheets/pages/_index.scss"
            print_success "Import ajouté dans _index.scss"
        else
            print_info "Import déjà présent dans _index.scss"
        fi
    fi
fi

echo ""

# ============================================
# ÉTAPE 7 : Installation du controller Stimulus
# ============================================
print_step "ÉTAPE 7 : Installation du controller Stimulus"

if [ -f "$SCRIPT_DIR/javascript/quantity_controller.js" ]; then
    mkdir -p "app/javascript/controllers"
    cp "$SCRIPT_DIR/javascript/quantity_controller.js" "app/javascript/controllers/quantity_controller.js"
    print_success "app/javascript/controllers/quantity_controller.js"
fi

echo ""

# ============================================
# RÉSUMÉ FINAL
# ============================================
echo ""
echo -e "${MAGENTA}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              ✨ INSTALLATION TERMINÉE ✨            ║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

print_success "Tous les fichiers ont été installés avec succès !"
echo ""

print_info "Fichiers installés :"
echo "  ✓ 6 fichiers de vues (.html.erb)"
echo "  ✓ 7 fichiers de styles (.scss)"
echo "  ✓ 1 controller Stimulus (.js)"
echo ""

print_info "Sauvegarde créée dans : $BACKUP_DIR"
echo ""

# ============================================
# ACTIONS POST-INSTALLATION
# ============================================
print_step "PROCHAINES ÉTAPES :"
echo ""

if [ ! -f "app/assets/images/background_wine.png" ]; then
    print_warning "ACTION REQUISE : Ajouter l'image de fond"
    echo "  1. Renommez 'ChatGPT_Image_8_déc__2025__21_30_17.png'"
    echo "  2. en 'background_wine.png'"
    echo "  3. Placez-la dans app/assets/images/background_wine.png"
    echo ""
fi

print_info "Redémarrer le serveur Rails :"
echo "  rails server"
echo ""

print_info "Tester les pages modifiées :"
echo "  → Page d'accueil (Home)"
echo "  → Page Events"
echo "  → Page Ajouter une bouteille"
echo "  → Page Mes Amis"
echo "  → Page Match"
echo ""

print_info "En cas de problème, restaurer la sauvegarde :"
echo "  cp -r $BACKUP_DIR/* ."
echo ""

echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  🍷  Votre application a été modernisée avec succès !║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
