require 'faker'
#I had to nest it according to Rayhan because of ID issues.
puts "Destroy everything"
# ArtistTag.destroy_all
# ArtTag.destroy_all
# Tag.destroy_all
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

# puts "Creating art tags"
# Tag.art_types.each do |art_tag|
#   Tag.create!(name: art_tag)
# end

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
    tag_list: Artist.media.sample(3),
    tag_list: Artist.styles.sample(3),
    # form: artist_categories.sample(2),
  )
  artist.user = user
  artist.save!


end
puts 'Finished!'

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
    tag_list: Art.media.sample(3),
    tag_list: Art.styles.sample(3),
    price_cents: Faker::Commerce.price,
    likees_count: Faker::Number.between(from: 0, to: 4000),
    # remote_photo_url: Faker::Avatar.image,
    # photo: File.open(Rails.root.join('images', 'bourdain.jpg')),
    remote_photo_url: Faker::Avatar.image,
    artist: artist,
  )
  art.save!

  puts 'Finished!'
end

puts 'Creating 40 fake articles...'
article_mediums = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ]
article_styles = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ]
4.times do
  article = Article.new(
    title: Faker::FunnyName.name,
    body: Faker::Lorem.sentences(number: 7),
    completion_date: Faker::Date.between(from: 300.days.ago, to: Date.today),
    tag_list: Article.media.sample(3),
    tag_list: Article.styles.sample(3),
    likees_count: Faker::Number.between(from: 0, to: 4000),
    remote_photo_url: Faker::Avatar.image,
    artist: artist,
  )
  article.save!

  puts 'Finished!'
end

puts 'Creating 40 fake services...'
service_mediums = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ]
service_styles = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ]
4.times do
  service = Service.new(
    title: Faker::FunnyName.name,
    text: Faker::Lorem.sentences(number: 4),
    length: Faker::Lorem.sentences(number: 1),
    tag_list: Service.media.sample(3),
    tag_list: Service.styles.sample(3),
    likees_count: Faker::Number.between(from: 0, to: 4000),
    remote_photo_url: Faker::Avatar.image,
    price_cents: Faker::Commerce.price,
    artist: artist,
  )
  Service.save!

  puts 'Finished!'
end

puts 'Creating 40 fake collaborations...'
collaboration_mediums = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ]
collaboration_styles = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ]
4.times do
  collaboration = Collaboration.new(
    title: Faker::FunnyName.name,
    description: Faker::Lorem.sentences(number: 5),
    goal: Faker::Lorem.sentences(number: 3),
    tag_list: Collaboration.media.sample(3),
    tag_list: Collaboration.styles.sample(3),
    likees_count: Faker::Number.between(from: 0, to: 4000),
    remote_photo_url: Faker::Avatar.image,
    artist: artist,
  )
  Collaboration.save!
  puts 'Finished!'
end

puts 'Creating 40 fake lessons...'
lesson_mediums = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ]
lesson_styles = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ]
4.times do
  lesson = Lesson.new(
    title: Faker::FunnyName.name,
    description: Faker::Lorem.sentences(number: 4),
    subdescription: Faker::Quote.most_interesting_man_in_the_world,
    learnings: Faker::Lorem.sentences(number: 3),
    prerequisites: Faker::Lorem.sentences(number: 3),
    free: Faker::Boolean.boolean,
    price_cents: Faker::Commerce.price,
    tag_list: Lesson.media.sample(3),
    tag_list: Lesson.styles.sample(3),
    likees_count: Faker::Number.between(from: 0, to: 4000),
    artist: artist,
  )
  Lesson.save!

  puts 'Finished!'
end

#liked/followed/etc.
