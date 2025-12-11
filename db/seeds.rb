require 'csv'
Guest.destroy_all
MealDrink.destroy_all
Meal.destroy_all
Stock.destroy_all
Friend.destroy_all
User.destroy_all
Drink.destroy_all

#Drink.destroy_all

puts "\n👥 Création des utilisateurs..."
#USER
users_data = [
  {
    email: 'Pierre@example.com',
    password: 'password123',
    first_name: 'Pierre',
    last_name: 'Gozard',
    diet: 'Vegetarien',
    allergy: '',
    like: 'Vin rouge, Bordeaux',
    dislike: 'Champagne',
    photo: 'Pierre.jpeg'
  },
    {
    email: 'chuck@example.com',
    password: 'password123',
    first_name: 'Chuck',
    last_name: 'Norris',
    diet: 'Omnivore',
    allergy: '',
    like: 'Chuck Norris',
    dislike: '',
    photo: 'chuck.png'
  },
  {
    email: 'Franck@example.com',
    password: 'password123',
    first_name: 'Franck',
    last_name: 'Abeille',
    diet: 'Omnivore',
    allergy: '',
    like: 'vins rouges, wisky',
    dislike: 'vin blanc',
    photo: 'Franck.jpeg'
  },
  {
    email: 'Vitor@example.com',
    password: 'password123',
    first_name: 'Vitor',
    last_name: 'de Castro',
    diet: 'Omnivore',
    allergy: 'Gluten',
    like: 'bières, vins rouges',
    dislike: 'vodka',
    photo: 'Vitor.jpeg'
  },
  {
    email: 'Tom@example.com',
    password: 'password123',
    first_name: 'Tom',
    last_name: 'Grenié',
    diet: 'Omnivore',
    allergy: '',
    like: 'bières, tequila',
    dislike: 'gin',
    photo: 'Tom.jpeg'
  },
  {
    email: 'Bassam@example.com',
    password: 'password123',
    first_name: 'Bassam',
    last_name: 'Renaud',
    diet: 'Hallal',
    allergy: 'None',
    like: 'thé glaçé',
    dislike: 'boissons alcoolisés',
    photo: 'Bassam.jpeg'
  },
  {
    email: 'Aurelien@example.com',
    password: 'password123',
    first_name: 'Aurelien',
    last_name: 'Lefrère',
    diet: 'Omnivore',
    allergy: '',
    like: 'vins rouges',
    dislike: 'vins rosés',
    photo: 'Aurélien.jpeg'
  }
]

users_data.each do |user_data|
  user = User.find_or_create_by!(email: user_data[:email]) do |u|
    u.password = user_data[:password]
    u.password_confirmation = user_data[:password]
    u.first_name = user_data[:first_name]
    u.last_name = user_data[:last_name]
    u.diet = user_data[:diet]
    u.allergy = user_data[:allergy]
    u.like = user_data[:like]
    u.dislike = user_data[:dislike]
    u.photo = user_data[:photo]
  end
  puts "✅ #{user.first_name} #{user.last_name} (#{user.email})"
end
puts "\n👥 Création des friends..."
friends = User.where.not(id: User.last.id)
@mail_aureo = User.find_by(email: "aurelien@example.com")
@mail_pierre = User.find_by(email: "pierre@example.com")

friends.each do |friend|
  Friend.create!(user_main_id: @mail_aureo.id,  user_friend_id: friend.id)
end

puts "\n👥 Création des friends aléatoires entre les autres users (sauf Aurélien)..."
other_users = User.where.not(email: "Aurelien@example.com")

other_users.each do |user|
  # Chaque user a entre 2 et 4 amis aléatoires (sauf lui-même et sauf Aurélien)
  potential_friends = other_users.where.not(id: user.id)
  random_friends = potential_friends.sample(rand(2..4))

  random_friends.each do |friend|
    # Vérifier que la relation n'existe pas déjà dans les deux sens
    unless Friend.exists?(user_main_id: user.id, user_friend_id: friend.id) ||
           Friend.exists?(user_main_id: friend.id, user_friend_id: user.id)
      Friend.create!(user_main_id: user.id, user_friend_id: friend.id)
      puts "✅ #{user.first_name} est ami avec #{friend.first_name}"
    end
  end
end




# db/seeds.rb
puts "\n Création des vins..."
 # 30 vins
drinks = [
  { title: "Château Margaux, Bordeaux", category: "Vin", region: "Bordeaux", year: 2007, photo: "margaux.png" },
  { title: "Château Lafite Rothschild, Pauillac", category: "Vin", region: "Bordeaux", year: 2013, photo: "rothschild.png" },
  { title: "Château Mouton Rothschild, Pauillac", category: "Vin", region: "Bordeaux", year: 2011, photo: "rothschild.png" },
  { title: "Château Latour, Pauillac", category: "Vin", region: "Bordeaux", year: 2015, photo: "latour.png" },
  { title: "Château Haut-Brion, Pessac-Léognan", category: "Vin", region: "Bordeaux", year: 2017, photo: "hautbrion.png" },
  { title: "Romanée-Conti, Domaine de la Romanée-Conti", category: "Vin", region: "Burgundy", year: 2014, photo: "romane.png" },
  { title: "La Tâche, Domaine de la Romanée-Conti", category: "Vin", region: "Burgundy", year: 2005, photo: "romane.png" },
  { title: "Richebourg, Domaine de la Romanée-Conti", category: "Vin", region: "Burgundy", year: 2014, photo: "richebourg.png" },
  { title: "Clos Vougeot, Grand Cru", category: "Vin", region: "Burgundy", year: 2011, photo: "vougeot.png" },
  { title: "Musigny, Grand Cru", category: "Vin", region: "Burgundy", year: 2014, photo: "musigny.png" },
  { title: "Cristal, Louis Roederer", category: "Vin", region: "Champagne", year: 2007, photo: "cristal.png" },
  { title: "Dom Pérignon, Moët & Chandon", category: "Vin", region: "Champagne", year: 2007, photo: "dom.png" },
  { title: "Krug Clos d'Ambonnay", category: "Vin", region: "Champagne", year: 2013, photo: "krug.png" },
  { title: "Salon Blanc de Blancs", category: "Vin", region: "Champagne", year: 2012, photo: "salon.png" },
  { title: "Taittinger Comtes de Champagne", category: "Vin", region: "Champagne", year: 2008, photo: "tai.png" },
  { title: "Sassicaia, Tenuta San Guido", category: "Vin", region: "Tuscany", year: 2015, photo: "sassicaia.png" },
  { title: "Ornellaia, Tenuta dell'Ornellaia", category: "Vin", region: "Tuscany", year: 2016, photo: "ornellaia.png" },
  { title: "Masseto, Tenuta dell'Ornellaia", category: "Vin", region: "Tuscany", year: 2014, photo: "masseto.png" },
  { title: "Tignanello, Antinori", category: "Vin", region: "Tuscany", year: 2015, photo: "tignanello.png" },
  { title: "Brunello di Montalcino, Biondi-Santi", category: "Vin", region: "Tuscany", year: 2010, photo: "brunello.png" },



  # 20 Boissons alcoolisées hors vin
  { title: "Whisky", category: "Alcoolisée", region: "Écosse", year: 2018, photo: "wisky.png" },
  { title: "Rhum", category: "Alcoolisée", region: "Caraïbes", year: 2020, photo: "rhum.png" },
  { title: "Vodka", category: "Alcoolisée", region: "Russie", year: 2019, photo: "wodka.png" },
  { title: "Gin", category: "Alcoolisée", region: "Angleterre", year: 2021, photo: "gin.png" },
  { title: "Tequila", category: "Alcoolisée", region: "Mexique", year: 2020, photo: "tequila.png" },
  { title: "Cognac", category: "Alcoolisée", region: "France", year: 2017, photo: "cognac.png" },
  { title: "Bière Blonde", category: "Alcoolisée", region: "Belgique", year: 2023, photo: "biere.jpg" },
  { title: "Bière Brune", category: "Alcoolisée", region: "Allemagne", year: 2022, photo: "biere brune.png" },
  { title: "Bière IPA", category: "Alcoolisée", region: "USA", year: 2023, photo: "biere ipa.png" },
  { title: "Saké", category: "Alcoolisée", region: "Japon", year: 2021, photo: "sake.png" },
  { title: "Amaretto", category: "Alcoolisée", region: "Italie", year: 2020, photo: "amaretto.png" },
  { title: "Baileys", category: "Alcoolisée", region: "Irlande", year: 2022, photo: "baileys.png" },
  { title: "Cachaça", category: "Alcoolisée", region: "Brésil", year: 2021, photo: "Cachaça.png" },
  { title: "Mezcal", category: "Alcoolisée", region: "Mexique", year: 2022, photo: "mezcal.png" },
  { title: "Pisco", category: "Alcoolisée", region: "Pérou", year: 2020, photo: "pisco.png" },
  { title: "Pastis", category: "Alcoolisée", region: "France", year: 2019, photo: "pastis.png" },
  { title: "Grappa", category: "Alcoolisée", region: "Italie", year: 2018, photo: "grappa.png" },
  { title: "Whisky Japonais", category: "Alcoolisée", region: "Japon", year: 2021, photo: "wisky jap.png" },
  { title: "Porto", category: "Alcoolisée", region: "Portugal", year: 2020, photo: "porto.png" },
  { title: "Sherry", category: "Alcoolisée", region: "Espagne", year: 2019, photo: "sherry.png" },


  # 20 Boissons non alcoolisées
  { title: "Eau plate", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "eau plate.png" },
  { title: "Eau gazeuse", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "eau gazeuse.png" },
  { title: "Jus d'orange", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "jus d'orange.png" },
  { title: "Jus de pomme", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "jus de pomme.png" },
  { title: "Coca-Cola", category: "Non alcoolisée", region: "USA", year: nil, photo: "coca.png" },
  { title: "Pepsi", category: "Non alcoolisée", region: "USA", year: nil, photo: "coca.png" },
  { title: "Thé glacé", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "thé glacé.png" },
  { title: "Limonade", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "limonade.png" },
  { title: "Smoothie fraise", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "smoothie fraise.png" },
  { title: "Smoothie mangue", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "smoothie mangue.png" },
  { title: "Café", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "café.png" },
  { title: "Thé vert", category: "Non alcoolisée", region: "Chine", year: nil, photo: "thé.jpg" },
  { title: "Thé noir", category: "Non alcoolisée", region: "Inde", year: nil, photo: "thé.jpg" },
  { title: "Eau de coco", category: "Non alcoolisée", region: "Tropicale", year: nil, photo: "eau de coco.png" },
  { title: "Ginger ale", category: "Non alcoolisée", region: "USA", year: nil, photo: "ginger ale.png" },
  { title: "Kombucha", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "kombucha.png" },
  { title: "Orangina", category: "Non alcoolisée", region: "France", year: nil, photo: "orangina.png" },
  { title: "Tonic", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "limonade.png" },
  { title: "Sirop de grenadine", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "grenadine.png" },
  { title: "Chocolat chaud", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "chocolat chaud.png" },

  # 20 Boissons improbables
  { title: "Kefir", category: "Improbable", region: "Caucase", year: nil, photo: "Kefir.png" },
  { title: "Vin chaud sans alcool", category: "Improbable", region: "France", year: nil, photo: "Vin chaud.jpg" },
  { title: "Cidre brut", category: "Improbable", region: "France", year: 2021, photo: "cidre.jpg" },
  { title: "Cider japonais", category: "Improbable", region: "Japon", year: 2022, photo: "Cidre japonais.jpg" },
  { title: "Ginger beer", category: "Improbable", region: "Angleterre", year: nil, photo: "Ginger Beer.png" },
  { title: "Lassi salé", category: "Improbable", region: "Inde", year: nil, photo: "lassi.jpg" },
  { title: "Thé fumé", category: "Improbable", region: "Chine", year: nil, photo: "thé.jpg" },
  { title: "Matcha latte", category: "Improbable", region: "Japon", year: nil, photo: "matcha.jpg" },
  { title: "Shrub (vinaigre de fruit)", category: "Improbable", region: "USA", year: nil, photo: "Shrub.png" },
  { title: "Tepache", category: "Improbable", region: "Mexique", year: 2023, photo: "Tepache.jpg" },
  { title: "Pulque", category: "Improbable", region: "Mexique", year: 2022, photo: "Pulque.png" },
  { title: "Bière de gingembre fermentée", category: "Improbable", region: "Mondiale", year: nil, photo: "biere.jpg" },
  { title: "Kombucha épicé", category: "Improbable", region: "Mondiale", year: nil, photo: "kombucha.png" },
  { title: "Shrub aux fruits rouges", category: "Improbable", region: "USA", year: nil, photo: "Shrub.png" },
  { title: "Café infusé au citron", category: "Improbable", region: "Mondiale", year: nil, photo: "café citron.jpg" },
  { title: "Soda artisanal au basilic", category: "Improbable", region: "Mondiale", year: nil, photo: "soda basilic.png" },
  { title: "Jus de betterave", category: "Improbable", region: "Mondiale", year: nil, photo: "jus de bettrave.png" },
  { title: "Infusion de romarin", category: "Improbable", region: "Mondiale", year: nil, photo: "infusion romarin.png" },
  { title: "Cider au gingembre", category: "Improbable", region: "Angleterre", year: 2022, photo: "cidre.jpg" },
  { title: "Soda au concombre", category: "Improbable", region: "Mondiale", year: nil, photo: "soda concombre.png" }
]

drinks.each do |drink|

  Drink.create!(drink)
end

puts "✅ 80 boissons insérées avec succès !"

# Création des stocks pour Aurélien
puts "\n📦 Création des stocks pour Aurélien..."


# 5 vins aléatoires avec des quantités variables
wine_drinks = Drink.where(category: "Vin").sample(5)

wine_drinks.each do |drink|
  stock = Stock.create!(
    user: @mail_aureo,
    drink: drink,
    quantity: rand(1..6),
    rating: rand(3..5)
  )
  puts "✅ Stock créé: #{drink.title} - Quantité: #{stock.quantity}"
end

# Création de repas avec des meal_drinks
puts "\n🍽️ Création des repas et meal_drinks pour Aurélien..."

meals_data = [
  { dish_name: "Boeuf Bourguignon", date: Date.today - 7.days, with_stock: true },
  { dish_name: "Magret de canard", date: Date.today - 3.days, with_stock: true },
  { dish_name: "Risotto aux champignons", date: Date.today - 1.day, with_stock: false }
]

meals_data.each_with_index do |meal_data, index|
  meal = Meal.create!(
    user: @mail_aureo,
    dish_name: meal_data[:dish_name],
    date: meal_data[:date],
    with_stock: meal_data[:with_stock]
  )

  # Ajouter Pierre comme invité au dernier repas
  if index == meals_data.length - 1

    Guest.create!(
      user: @mail_pierre,
      meal: meal
    )
    puts "👤 Pierre ajouté comme invité au repas: #{meal.dish_name}"
  end

  # Ajouter 2-3 boissons par repas
  selected_drinks = Drink.all.sample(rand(2..3))
  selected_drinks.each do |drink|
    MealDrink.create!(
      meal: meal,
      drink: drink,
      status: ["suggested", "selected", "served"].sample
    )
  end

  puts "✅ Repas créé: #{meal.dish_name} avec #{selected_drinks.count} boissons"
end
# Création de plusieurs repas avec des meal_drinks
puts "\n🍽️ Création des événements (meals) avec boissons sélectionnées..."

meals_data = [
  {
    dish_name: "Boeuf Bourguignon",
    date: Date.new(2025, 10, 15),
    with_stock: true,
    nb_drinks: 2
  },
  {
    dish_name: "Magret de canard",
    date: Date.new(2025, 11, 3),
    with_stock: true,
    nb_drinks: 3
  },
  {
    dish_name: "Risotto aux champignons",
    date: Date.new(2025, 11, 20),
    with_stock: false,
    nb_drinks: 1
  },
  {
    dish_name: "pâtes au pesto vert",
    date: Date.new(2025, 12, 5),
    with_stock: true,
    nb_drinks: 1,
    add_guest: true
  }
]

meals_data.each do |meal_data|
  meal = Meal.create!(
    user: @mail_aureo,
    dish_name: meal_data[:dish_name],
    date: meal_data[:date],
    with_stock: meal_data[:with_stock]
  )

  # Ajouter Pierre comme invité au dernier repas (pâtes au pesto vert)
  if meal_data[:add_guest]
    Guest.create!(
      user: @mail_pierre,
      meal: meal
    )
    puts "👤 Pierre ajouté comme invité au repas: #{meal.dish_name}"
  end

  # Ajouter les boissons sélectionnées
  nb_drinks = meal_data[:nb_drinks]

  if meal_data[:add_guest]
    # Pour le dernier repas, sélectionner 1 vin aléatoire
    selected_wine = Drink.where(category: "Vin").sample(1)
    selected_wine.each do |drink|
      MealDrink.create!(
        meal: meal,
        drink: drink,
        status: "validated"
      )
    end
    puts "✅ Repas créé: #{meal.dish_name} avec #{selected_wine.count} vin sélectionné"
  else
    # Pour les autres repas, sélectionner 1-3 boissons aléatoires
    selected_drinks = Drink.all.sample(nb_drinks)
    selected_drinks.each do |drink|
      MealDrink.create!(
        meal: meal,
        drink: drink,
        status: "validated"
      )
    end
    puts "✅ Repas créé: #{meal.dish_name} avec #{selected_drinks.count} boissons sélectionnées"
  end
end


puts "\n✨ Seed complété avec succès!"
