# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

User.create(email: "elie.celka@gmail.com", password: "password")
10.times do
  url = "https://randomuser.me/api/"
  user_serialized = URI.parse(url).read
  user = JSON.parse(user_serialized)
  User.create(email: user["results"][0]["email"], password: "password")
end

User.all

puts "created #{User.count} users"
