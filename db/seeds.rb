require 'faker'
#I had to nest it according to Rayhan because of ID issues.
puts "Destroy everything"
ArtistTag.destroy_all
ArtTag.destroy_all
Tag.destroy_all
Art.destroy_all
Artist.destroy_all
User.destroy_all
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating art tags"
Tag.art_types.each do |art_tag|
  Tag.create!(name: art_tag)
end

puts 'Creating 20 fake users...'
20.times do
  user = User.new(
  email: Faker::Internet.unique.email,
  username: Faker::Alphanumeric.alpha(number: 10),
  password: '1234567'
  )
  user.save!
  artist_categories = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance']
  artist_cities = ['Chicago', 'Taipei', 'Moscow', 'Helsinki', 'Quito', 'New York', 'Rio De Janeiro', 'Melbourne', 'Geneva', 'Zurich', 'Almaty', 'Jakarta', 'Canggu', 'Singapore', 'Tunis', 'Copenhagen', 'Milan', 'Sydney', 'Cape Town', 'Vladivostok', 'Berlin', 'London', 'Paris', 'Stockholm', 'Algiers', 'Istanbul', 'Athens', 'Izmir', 'Osaka', 'Tokyo', 'Seoul', 'Beijing', 'Hanoi', 'Goa', 'Karachi', 'Kabul', 'Tehran', 'Tashkent', 'Dushanbe', 'Casablanca', 'Cairo', 'Beirut', 'Auckland', 'Santa Monica', 'Vancouver', 'Tijuana', 'Mexico', 'Khartoum', 'Kazan', 'Shiraz', 'Baghdad', 'Dhaka', 'Lisbon', 'Barcelona', 'Warsaw', 'Oslo', 'Havana', 'Salvador', 'Santiago', 'Lima', 'Manila', 'Bangkok', 'Lagos', 'Nairobi', 'Accra', 'Kinhasa', 'Toronto', 'Perth', 'Mexico City', 'Minsk', 'Kiev', 'Jerusalem', 'Riyadh', 'Dubai', 'Muscat']
  # puts 'Creating 200 fake artists...'
  # 200.times do
  artist = Artist.new(
  first_name:    Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  artist_name:  Faker::Artist.name,
  remote_photo_url: Faker::Avatar.image,
  bio: Faker::Quote.most_interesting_man_in_the_world,
  age: Faker::Number.between(from: 1, to: 100),
  birth_place: CountryStateSelect.countries_collection.map { |country| country[1].to_s }.sample,
  # city: Faker::Address.city,
  city: artist_cities.sample,
  country: CountryStateSelect.countries_collection.map { |country| country[1].to_s }.sample,
  # form: artist_categories.sample(2),
  )
  artist.user = user
  artist.save!

    puts 'Linking artist to tags'
    Tag.art_kinds.sample(2).each do |tag|
      t = Tag.create!(name: tag)
      ArtistTag.create!(artist: artist, tag: t)
    end


  # end
  # puts 'Finished!'
  art_mediums = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ]
  art_styles = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ]
  puts 'Creating 50 fake arts...'
  5.times do
    art = Art.new(
    title: Faker::FunnyName.name,
    description: Faker::Lorem.sentences(number: 1),
    completion_date: Faker::Date.between(from: 300.days.ago, to: Date.today),
    inspiration: Faker::Lorem.sentences(number: 1),
    available: Faker::Boolean.boolean,
    # styles: art_styles.sample(2),
    # kind: art_mediums.sample,
    price_cents: Faker::Commerce.price,
    likees_count: Faker::Number.between(from: 0, to: 4000),
    artist: artist
    )
    art.save!

    # Create Art Tags for kind too!  Tag IDS?
    puts 'Linking art type via tags'
    Tag.art_types.sample(2).each do |tag|
      t = Tag.create!(name: tag)
      ArtTag.create!(art: art, tag: t)
    end

    puts 'Linking art kind via tags'
    Tag.art_kinds.sample(2).each do |tag|
      t = Tag.create!(name: tag)
      ArtTag.create!(art: art, tag: t)
    end

    photo = Photo.new(
    # remote_photo_url: Faker::LoremPixel.image,
    photo: File.open(Rails.root.join('images', 'bourdain.jpg')),
    art: art
    )
    photo.save!
  end
  puts 'Finished!'
end
puts 'Finished!'

