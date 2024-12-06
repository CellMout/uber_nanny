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

User.create(email: "admin@gmail.com", password: "password", first_name: "First_Name", last_name: "Last_Name")
10.times do
  url = "https://randomuser.me/api/"
  user_serialized = URI.parse(url).read
  user = JSON.parse(user_serialized)
  User.create(email: user["results"][0]["email"], password: "password", first_name: user["results"][0]["name"]["first"], last_name: user["results"][0]["name"]["last"])
end

User.all.each do |user|
  2.times do
    url = "https://randomuser.me/api/"
    user_serialized = URI.parse(url).read
    data = JSON.parse(user_serialized)

    file = URI.parse(data["results"][0]["picture"]["large"]).open
    nanny = Nanny.create(name: data["results"][0]["name"]["first"], description: Faker::Lorem.paragraph, hour_rate: rand(8.00..25.50).round(2), photo_url: data["results"][0]["picture"]["large"])
    nanny.photo.attach(io: file, filename: "#{nanny.name}.jpg", content_type: "image/jpg")
    user.nannies << nanny
  end
end

User.all.each do |user|
  Booking.create(user: user, address: Faker::Address.street_address + ", city: " + Faker::Address.city, nanny: Nanny.all.sample, start_time: DateTime.now, end_time: DateTime.parse("2024-12-30T21:20:44+09:00"), status: "pending")
end

2.times do
  Booking.create(user: User.find_by(email: "admin@gmail.com"), address: Faker::Address.street_address + ", city: " + Faker::Address.city, nanny: User.find_by( email: "admin@gmail.com" ).nannies.first, start_time: DateTime.now, end_time: DateTime.parse("2024-12-30T21:20:44+09:00"), status: "pending")
  Booking.create(user: User.all.sample, address: Faker::Address.street_address + ", city: " + Faker::Address.city, nanny: User.find_by( email: "admin@gmail.com" ).nannies.first, start_time: DateTime.now, end_time: DateTime.parse("2024-12-30T21:20:44+09:00"), status: "pending")
  Booking.create(user: User.all.sample, address: Faker::Address.street_address + ", city: " + Faker::Address.city, nanny: User.find_by( email: "admin@gmail.com" ).nannies.last, start_time: DateTime.now, end_time: DateTime.parse("2024-12-30T21:20:44+09:00"), status: "pending")
end

puts "created #{User.count} users"
puts "created #{Nanny.count} nannies"
puts "created #{Booking.count} bookings"
