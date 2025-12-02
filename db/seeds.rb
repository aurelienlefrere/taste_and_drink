# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create(email: "franckabeille33@gmail.com", password:"azerty", first_name: "Franck", last_name: "Abeille")

require 'csv'

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
