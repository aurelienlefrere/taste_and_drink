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
Meal.destroy_all
Stock.destroy_all
Friend.destroy_all
User.destroy_all

MealDrink.destroy_all
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

puts "\n👥 Création des Stock..."
drinks = Drink.all
@mail_aureo = User.find_by(email: "aurelien@example.com")

csv_file = Rails.root.join('db', 'wines.csv')

if File.exist?(csv_file)
  puts "📥 Importation des vins en cours..."
  count = 0

  CSV.foreach(csv_file, headers: true, encoding: 'utf-8') do |row|
    sleep(10)
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
  # 20 Boissons alcoolisées hors vin
  { title: "Whisky", category: "Alcoolisée", region: "Écosse", year: 2018, photo: "whisky.jpg" },
  { title: "Rhum", category: "Alcoolisée", region: "Caraïbes", year: 2020, photo: "rum.jpg" },
  { title: "Vodka", category: "Alcoolisée", region: "Russie", year: 2019, photo: "vodka.jpg" },
  { title: "Gin", category: "Alcoolisée", region: "Angleterre", year: 2021, photo: "gin.jpg" },
  { title: "Tequila", category: "Alcoolisée", region: "Mexique", year: 2020, photo: "tequila.jpg" },
  { title: "Cognac", category: "Alcoolisée", region: "France", year: 2017, photo: "cognac.jpg" },
  { title: "Bière Blonde", category: "Alcoolisée", region: "Belgique", year: 2023, photo: "biere_blonde.jpg" },
  { title: "Bière Brune", category: "Alcoolisée", region: "Allemagne", year: 2022, photo: "biere_brune.jpg" },
  { title: "Bière IPA", category: "Alcoolisée", region: "USA", year: 2023, photo: "biere_ipa.jpg" },
  { title: "Saké", category: "Alcoolisée", region: "Japon", year: 2021, photo: "sake.jpg" },
  { title: "Amaretto", category: "Alcoolisée", region: "Italie", year: 2020, photo: "amaretto.jpg" },
  { title: "Baileys", category: "Alcoolisée", region: "Irlande", year: 2022, photo: "baileys.jpg" },
  { title: "Cachaça", category: "Alcoolisée", region: "Brésil", year: 2021, photo: "cachaca.jpg" },
  { title: "Mezcal", category: "Alcoolisée", region: "Mexique", year: 2022, photo: "mezcal.jpg" },
  { title: "Pisco", category: "Alcoolisée", region: "Pérou", year: 2020, photo: "pisco.jpg" },
  { title: "Pastis", category: "Alcoolisée", region: "France", year: 2019, photo: "pastis.jpg" },
  { title: "Grappa", category: "Alcoolisée", region: "Italie", year: 2018, photo: "grappa.jpg" },
  { title: "Whisky Japonais", category: "Alcoolisée", region: "Japon", year: 2021, photo: "japanese_whisky.jpg" },
  { title: "Porto", category: "Alcoolisée", region: "Portugal", year: 2020, photo: "porto.jpg" },
  { title: "Sherry", category: "Alcoolisée", region: "Espagne", year: 2019, photo: "sherry.jpg" },

  # 20 Boissons non alcoolisées
  { title: "Eau plate", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "eau_plate.jpg" },
  { title: "Eau gazeuse", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "eau_gazeuse.jpg" },
  { title: "Jus d'orange", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "jus_orange.jpg" },
  { title: "Jus de pomme", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "jus_pomme.jpg" },
  { title: "Coca-Cola", category: "Non alcoolisée", region: "USA", year: nil, photo: "coca_cola.jpg" },
  { title: "Pepsi", category: "Non alcoolisée", region: "USA", year: nil, photo: "pepsi.jpg" },
  { title: "Thé glacé", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "the_glace.jpg" },
  { title: "Limonade", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "limonade.jpg" },
  { title: "Smoothie fraise", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "smoothie_fraise.jpg" },
  { title: "Smoothie mangue", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "smoothie_mangue.jpg" },
  { title: "Café", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "cafe.jpg" },
  { title: "Thé vert", category: "Non alcoolisée", region: "Chine", year: nil, photo: "the_vert.jpg" },
  { title: "Thé noir", category: "Non alcoolisée", region: "Inde", year: nil, photo: "the_noir.jpg" },
  { title: "Eau de coco", category: "Non alcoolisée", region: "Tropicale", year: nil, photo: "eau_coco.jpg" },
  { title: "Ginger ale", category: "Non alcoolisée", region: "USA", year: nil, photo: "ginger_ale.jpg" },
  { title: "Kombucha", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "kombucha.jpg" },
  { title: "Orangina", category: "Non alcoolisée", region: "France", year: nil, photo: "orangina.jpg" },
  { title: "Tonic", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "tonic.jpg" },
  { title: "Sirop de grenadine", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "grenadine.jpg" },
  { title: "Chocolat chaud", category: "Non alcoolisée", region: "Mondiale", year: nil, photo: "chocolat_chaud.jpg" },

  # 20 Boissons improbables
  { title: "Kefir", category: "Improbable", region: "Caucase", year: nil, photo: "kefir.jpg" },
  { title: "Vin chaud sans alcool", category: "Improbable", region: "France", year: nil, photo: "vin_chaud.jpg" },
  { title: "Cidre brut", category: "Improbable", region: "France", year: 2021, photo: "cidre.jpg" },
  { title: "Cider japonais", category: "Improbable", region: "Japon", year: 2022, photo: "japanese_cider.jpg" },
  { title: "Ginger beer", category: "Improbable", region: "Angleterre", year: nil, photo: "ginger_beer.jpg" },
  { title: "Lassi salé", category: "Improbable", region: "Inde", year: nil, photo: "lassi_sale.jpg" },
  { title: "Thé fumé", category: "Improbable", region: "Chine", year: nil, photo: "the_fume.jpg" },
  { title: "Matcha latte", category: "Improbable", region: "Japon", year: nil, photo: "matcha_latte.jpg" },
  { title: "Shrub (vinaigre de fruit)", category: "Improbable", region: "USA", year: nil, photo: "shrub.jpg" },
  { title: "Tepache", category: "Improbable", region: "Mexique", year: 2023, photo: "tepache.jpg" },
  { title: "Pulque", category: "Improbable", region: "Mexique", year: 2022, photo: "pulque.jpg" },
  { title: "Bière de gingembre fermentée", category: "Improbable", region: "Mondiale", year: nil, photo: "biere_gingembre.jpg" },
  { title: "Kombucha épicé", category: "Improbable", region: "Mondiale", year: nil, photo: "kombucha_epice.jpg" },
  { title: "Shrub aux fruits rouges", category: "Improbable", region: "USA", year: nil, photo: "shrub_fruits.jpg" },
  { title: "Café infusé au citron", category: "Improbable", region: "Mondiale", year: nil, photo: "cafe_citron.jpg" },
  { title: "Soda artisanal au basilic", category: "Improbable", region: "Mondiale", year: nil, photo: "soda_basilic.jpg" },
  { title: "Jus de betterave", category: "Improbable", region: "Mondiale", year: nil, photo: "jus_betterave.jpg" },
  { title: "Infusion de romarin", category: "Improbable", region: "Mondiale", year: nil, photo: "infusion_romarin.jpg" },
  { title: "Cider au gingembre", category: "Improbable", region: "Angleterre", year: 2022, photo: "cider_gingembre.jpg" },
  { title: "Soda au concombre", category: "Improbable", region: "Mondiale", year: nil, photo: "soda_concombre.jpg" }
]

drinks.each do |drink|
  Drink.create!(drink)
end

puts "✅ 60 boissons insérées avec succès !"







# drinks.each do |drink|
#   Stock.create!(drink_id: drink.id, user_id: @mail_aureo.id, quantity: 1 )
# end

puts "\n✨ Seed terminé ! #{Drink.count} vins + #{User.count} utilisateurs + #{Friend.count} friends +
#{Stock.count} stock "
