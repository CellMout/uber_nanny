# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Booking.destroy_all
Nanny.destroy_all
User.destroy_all

User.create(email: "elie.celka@gmail.com", password: "password")
10.times do
  url = "https://randomuser.me/api/"
  user_serialized = URI.parse(url).read
  user = JSON.parse(user_serialized)
  User.create(email: user["results"][0]["email"], password: "password")
end


User.all.each do |user|
  2.times do
    url = "https://randomuser.me/api/"
    user_serialized = URI.parse(url).read
    data = JSON.parse(user_serialized)
    user.nannies << Nanny.create(name: data["results"][0]["name"]["first"], description: Faker::Lorem.paragraph, hour_rate: rand(8.0..25.5).round(1), photo_url: data["results"][0]["picture"]["large"])
  end
end
User.all.each do |user|
  Booking.create(user: user, address: Faker::Address.street_address + ", city: " + Faker::Address.city, nanny: Nanny.all.sample, start_time: DateTime.now, end_time: DateTime.parse("2024-12-30T21:20:44+09:00"), status: "pending")
end

puts "created #{User.count} users"
puts "created #{Nanny.count} nannies"
puts "created #{Booking.count} bookings"
