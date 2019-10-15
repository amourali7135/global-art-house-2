require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating 100 fake artists...'
100.times do
  artist = Artist.new(
  first_name:    Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  artist_name: Faker::FunnyName.name, 
  photo: 
  bio:
  age: Faker::Number.between(from: 1, to: 100),
  birth_place:
  instagram:
  facebook:
  website:
  city:
  country:
  form: 
  )
  restaurant.save!
end
puts 'Finished!'