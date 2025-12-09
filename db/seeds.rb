# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


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
    diet: 'Vegan',
    allergy: 'Nuts',
    like: 'Red wines, Bordeaux',
    dislike: 'Champagne',
    photo: 'Pierre.jpeg'
  },
  {
    email: 'Franck@example.com',
    password: 'password123',
    first_name: 'Franck',
    last_name: 'Abeille',
    diet: 'Omnivore',
    allergy: 'Shellfish',
    like: 'White wines, Burgundy',
    dislike: 'Sweet wines',
    photo: 'Franck.jpeg'
  },
  {
    email: 'Vitor@example.com',
    password: 'password123',
    first_name: 'Vitor',
    last_name: 'de Castro',
    diet: 'Vegetarian',
    allergy: 'Gluten',
    like: 'Rosé wines, Provence',
    dislike: 'Dry wines',
    photo: 'Vitor.jpeg'
  },
  {
    email: 'Tom@example.com',
    password: 'password123',
    first_name: 'Tom',
    last_name: 'Grenié',
    diet: 'Omnivore',
    allergy: 'Dairy',
    like: 'Sparkling wines, Champagne',
    dislike: 'Heavy wines',
    photo: 'Tom.jpeg'
  },
  {
    email: 'Bassam@example.com',
    password: 'password123',
    first_name: 'Bassam',
    last_name: 'Renaud',
    diet: 'Pescatarian',
    allergy: 'None',
    like: 'Italian wines, Tuscan',
    dislike: 'Bitter wines',
    photo: 'Bassam.jpeg'
  },
  {
    email: 'Aurelien@example.com',
    password: 'password123',
    first_name: 'Aurelien',
    last_name: 'Lefrère',
    diet: 'Omnivore',
    allergy: 'Sulfites',
    like: 'Spanish wines, Rioja',
    dislike: 'Light wines',
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

friends.each do |friend|
  Friend.create!(user_main_id: @mail_aureo.id,  user_friend_id: friend.id)
end


csv_file = Rails.root.join('db', 'wines.csv')

if File.exist?(csv_file)
  puts "📥 Importation des vins en cours..."
  count = 0

  CSV.foreach(csv_file, headers: true, encoding: 'utf-8') do |row|
    drink = Drink.find_or_create_by!(
      title: row['title'],
      year: row['year'],
      category: row['category'],
      region: row['region'],
      photo: row['photo']
    )
    count += 1
  end

  puts "✅ #{count} vins importés avec succès !"
else
  puts "❌ Erreur : wines.csv introuvable dans db/"
end

# db/seeds.rb

drinks = [

  { title: "Bordeaux Rouge", category: "Vin", region: "Bordeaux", year: 2019, photo: "Aurélien.jpeg" },
  { title: "Bourgogne Pinot Noir", category: "Vin", region: "Bourgogne", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Côtes du Rhône", category: "Vin", region: "Vallée du Rhône", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Beaujolais", category: "Vin", region: "Beaujolais", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Chianti", category: "Vin", region: "Italie - Toscane", year: 2019, photo: "Aurélien.jpeg" },
  { title: "Rioja", category: "Vin", region: "Espagne", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Merlot", category: "Vin", region: "France", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Cabernet Sauvignon", category: "Vin", region: "France", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Syrah", category: "Vin", region: "France", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Chardonnay", category: "Vin", region: "France", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Sauvignon Blanc", category: "Vin", region: "Loire", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Muscadet", category: "Vin", region: "Loire", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Riesling", category: "Vin", region: "Alsace", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Gewurztraminer", category: "Vin", region: "Alsace", year: 2019, photo: "Aurélien.jpeg" },
  { title: "Rosé de Provence", category: "Vin", region: "Provence", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Champagne Brut", category: "Vin", region: "Champagne", year: 2018, photo: "Aurélien.jpeg" },
  { title: "Vinho Verde", category: "Vin", region: "Portugal", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Lambrusco", category: "Vin", region: "Italie", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Cava", category: "Vin", region: "Espagne", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Pinot Grigio", category: "Vin", region: "Italie", year: 2021, photo: "Aurélien.jpeg" },

  # 20 Boissons alcoolisées hors vin
  { title: "Whisky", category: "Alcoolisée", region: "Écosse", year: 2018, photo: "Aurélien.jpeg" },
  { title: "Rhum", category: "Alcoolisée", region: "Caraïbes", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Vodka", category: "Alcoolisée", region: "Russie", year: 2019, photo: "Aurélien.jpeg" },
  { title: "Gin", category: "Alcoolisée", region: "Angleterre", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Tequila", category: "Alcoolisée", region: "Mexique", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Cognac", category: "Alcoolisée", region: "France", year: 2017, photo: "Aurélien.jpeg" },
  { title: "Bière Blonde", category: "Alcoolisée", region: "Belgique", year: 2023, photo: "Aurélien.jpeg" },
  { title: "Bière Brune", category: "Alcoolisée", region: "Allemagne", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Bière IPA", category: "Alcoolisée", region: "USA", year: 2023, photo: "Aurélien.jpeg" },
  { title: "Saké", category: "Alcoolisée", region: "Japon", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Amaretto", category: "Alcoolisée", region: "Italie", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Baileys", category: "Alcoolisée", region: "Irlande", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Cachaça", category: "Alcoolisée", region: "Brésil", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Mezcal", category: "Alcoolisée", region: "Mexique", year: 2022, photo: "Aurélien.jpeg" },
  { title: "Pisco", category: "Alcoolisée", region: "Pérou", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Pastis", category: "Alcoolisée", region: "France", year: 2019, photo: "Aurélien.jpeg" },
  { title: "Grappa", category: "Alcoolisée", region: "Italie", year: 2018, photo: "Aurélien.jpeg" },
  { title: "Whisky Japonais", category: "Alcoolisée", region: "Japon", year: 2021, photo: "Aurélien.jpeg" },
  { title: "Porto", category: "Alcoolisée", region: "Portugal", year: 2020, photo: "Aurélien.jpeg" },
  { title: "Sherry", category: "Alcoolisée", region: "Espagne", year: 2019, photo: "Aurélien.jpeg" },

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




puts "\n👥 Création des Stock..."
drinks = Drink.all
@mail_aureo = User.find_by(email: "aurelien@example.com")

csv_file = Rails.root.join('db', 'wines.csv')

if File.exist?(csv_file)
  puts "📥 Importation des vins en cours..."
  count = 0

  CSV.foreach(csv_file, headers: true, encoding: 'utf-8') do |row|

    drink = Drink.find_or_create_by!(
      title: row['title'],
      year: row['year'],
      category: row['category'],
      region: row['region'],
      photo: row['photo']
    )
    count += 1
  end

  puts "✅ #{count} vins importés avec succès !"
else
  puts "❌ Erreur : wines.csv introuvable dans db/"
end
