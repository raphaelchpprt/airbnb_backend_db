# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
User.destroy_all
Listing.destroy_all
City.destroy_all
Reservation.destroy_all

a=1
10.times do
  City.create!(
    id: a, 
    name: Faker::Address.city,
    zip_code: Faker::Number.leading_zero_number(digits: 5),
    )
  a+=1
end

b=1
20.times do
  User.create!(
    id: b,
    email: Faker::Internet.email,
    phone_number: "+336" + Faker::Number.leading_zero_number(digits: 8),
    description: Faker::Lorem.paragraph
  )
  b+=1
end

c=1
50.times do
  Listing.create!(
    id: c,
    available_beds: Faker::Number.between(from: 1, to: 10),
    price: Faker::Number.between(from: 1, to: 200),
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: true),
    has_wifi: Faker::Boolean.boolean,
    admin: User.find(rand(1..20)),
    city: City.find(rand(1..10)),
    welcome_message: "Bienvenue !"
  )
  c+=1
end

d=1
5.times do
  Reservation.create!(
  id: d,
  start_date: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now - 5),
  end_date: Faker::Time.between(from: DateTime.now - 4, to: DateTime.now),
  listing: Listing.find(rand(1..50)),
  guest: User.find(rand(1..20))
  )
  d+=1
end

e=6
5.times do
  Reservation.create!(
  id: e,
  start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 4),
  end_date: Faker::Time.between(from: DateTime.now + 5, to: DateTime.now + 10), 
  listing: Listing.find(rand(1..50)),
  guest: User.find(rand(1..20))
  )
  e+=1
end