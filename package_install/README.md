# 🚀 Installation Automatique - Taste & Drink

## ⚡ Installation Ultra-Rapide

### 1️⃣ Téléchargez le dossier `package_install`

### 2️⃣ Ouvrez un terminal dans votre projet Taste & Drink
```bash
cd /chemin/vers/votre/projet/taste_and_drink
```

### 3️⃣ Exécutez le script d'installation
```bash
bash /chemin/vers/package_install/install.sh
```

**C'est tout ! ✨**

Le script fait automatiquement :
- ✅ Sauvegarde de tous vos fichiers existants
- ✅ Installation de tous les nouveaux fichiers
- ✅ Ajout des nouveaux styles aux fichiers existants
- ✅ Création du controller Stimulus
- ✅ Vérifications et rapport détaillé

---

## 📋 Étapes détaillées

### Avant l'installation

**Important** : Ajoutez l'image de fond dans votre projet :

1. Renommez `ChatGPT_Image_8_déc__2025__21_30_17.png`
2. en `background_wine.png`
3. Placez-la dans `app/assets/images/background_wine.png`

(Le script vous rappellera si vous oubliez)

### Pendant l'installation

Le script va :

1. **Vérifier** que vous êtes dans un projet Rails
2. **Créer** une sauvegarde complète (dans un dossier `backup_taste_drink_YYYYMMDD_HHMMSS`)
3. **Copier** tous les fichiers de vues
4. **Remplacer** les fichiers de styles globaux (layout, navbar)
5. **Enrichir** les fichiers de styles de pages (ajoute à la fin)
6. **Créer** le nouveau fichier _stock_new.scss
7. **Installer** le controller Stimulus
8. **Afficher** un rapport détaillé

### Après l'installation

```bash
# Redémarrer le serveur
rails server

# Ouvrir dans le navigateur
http://localhost:3000
```

---

## 🎯 Résultat

Votre application aura :

✅ Fond avec image de vin rouge élégante  
✅ Logo doré "Taste & Drink" centré dans la navbar  
✅ Logo flottant animé sur la page d'accueil  
✅ Message de bienvenue personnalisé  
✅ Cards events compactes et modernes  
✅ Formulaire stock avec beaux boutons +/- roses  
✅ Cards amis bien organisées  
✅ Page match cohérente et élégante  

---

## 🐛 En cas de problème

### Restaurer la sauvegarde
```bash
# Le script a créé un dossier de sauvegarde
# Il vous indique le nom exact à la fin

cp -r backup_taste_drink_YYYYMMDD_HHMMSS/* .
```

### L'image de fond ne s'affiche pas
1. Vérifiez : `app/assets/images/background_wine.png` existe
2. Le nom doit être EXACTEMENT `background_wine.png`
3. Redémarrez le serveur : `rails server`
4. Videz le cache : Ctrl+Shift+R dans le navigateur

### Les styles ne s'appliquent pas
1. Vérifiez la console du navigateur (F12)
2. Redémarrez le serveur Rails
3. Videz le cache du navigateur

### Les boutons +/- ne fonctionnent pas
1. Vérifiez : `app/javascript/controllers/quantity_controller.js` existe
2. Ouvrez la console du navigateur (F12)
3. Redémarrez le serveur

---

## 📁 Contenu du package

```
package_install/
├── install.sh                          # Script d'installation automatique
├── README.md                           # Ce fichier
├── views/                              # Fichiers de vues
│   ├── application.html.erb
│   ├── _navbar.html.erb
│   ├── home.html.erb
│   ├── meals_index.html.erb
│   ├── stocks_new.html.erb
│   └── friends_index.html.erb
├── stylesheets/                        # Fichiers de styles
│   ├── layout.scss                     (à remplacer)
│   ├── _navbar.scss                    (à remplacer)
│   ├── _home_nouveaux_styles.scss      (à ajouter)
│   ├── _events_nouveaux_styles.scss    (à ajouter)
│   ├── _friends_nouveaux_styles.scss   (à ajouter)
│   ├── _match_nouveaux_styles.scss     (à ajouter)
│   └── _stock_new.scss                 (nouveau fichier)
└── javascript/                         # Controller Stimulus
    └── quantity_controller.js
```

---

## 💡 Conseils

- **Testez** après l'installation sur chaque page
- **Gardez** le dossier de sauvegarde jusqu'à être sûr que tout fonctionne
- **Personnalisez** les couleurs selon vos goûts si vous le souhaitez
- **Lisez** les guides dans le dossier parent pour comprendre les modifications

---

## 📚 Documentation complète

Pour comprendre en détail chaque modification, consultez :
- `../MODIFICATIONS_TASTE_AND_DRINK.md` - Guide complet avec explications
- `../APERCU_VISUEL.md` - Visualisation avant/après
- `../README.md` - Documentation générale

---

## ✨ C'est tout !

Le script fait tout pour vous en quelques secondes.

**Bon développement ! 🍷**
