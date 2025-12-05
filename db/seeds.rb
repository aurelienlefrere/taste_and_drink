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
Meal.destroy_all
Stock.destroy_all
Friend.destroy_all
Guest.destroy_all
User.destroy_all
Drink.destroy_all


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
    dislike: 'Champagne'
  },
  {
    email: 'Franck@example.com',
    password: 'password123',
    first_name: 'Franck',
    last_name: 'Abeille',
    diet: 'Omnivore',
    allergy: 'Shellfish',
    like: 'White wines, Burgundy',
    dislike: 'Sweet wines'
  },
  {
    email: 'Vitor@example.com',
    password: 'password123',
    first_name: 'Vitor',
    last_name: 'de Castro',
    diet: 'Vegetarian',
    allergy: 'Gluten',
    like: 'Rosé wines, Provence',
    dislike: 'Dry wines'
  },
  {
    email: 'Tom@example.com',
    password: 'password123',
    first_name: 'Tom',
    last_name: 'Grenié',
    diet: 'Omnivore',
    allergy: 'Dairy',
    like: 'Sparkling wines, Champagne',
    dislike: 'Heavy wines'
  },
  {
    email: 'Bassam@example.com',
    password: 'password123',
    first_name: 'Bassam',
    last_name: 'Renaud',
    diet: 'Pescatarian',
    allergy: 'None',
    like: 'Italian wines, Tuscan',
    dislike: 'Bitter wines'
  },
  {
    email: 'Aurelien@example.com',
    password: 'password123',
    first_name: 'Aurelien',
    last_name: 'Lefrère',
    diet: 'Omnivore',
    allergy: 'Sulfites',
    like: 'Spanish wines, Rioja',
    dislike: 'Light wines'
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

# drinks.each do |drink|
#   Stock.create!(drink_id: drink.id, user_id: @mail_aureo.id, quantity: 1 )
# end

puts "\n✨ Seed terminé ! #{Drink.count} vins + #{User.count} utilisateurs + #{Friend.count} friends +
#{Stock.count} stock "
