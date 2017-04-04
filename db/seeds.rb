# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Books', 'TV Shows', 'Movies', 'Clothes', 'Music', 'Food'].each do |category|
  Category.create(name: category)
end

1000.times do
  category = Category.all.sample

  Product.create title: Faker::Hacker.say_something_smart,
                 description: Faker::Hipster.paragraph,
                 price: rand(100),
                 category_id: category.id
end

puts Cowsay.say 'Created 1000 products', :cow


100.times do
  review = Review.all.sample
  Review.create rating: rand(6),
                body: Faker::Hipster.paragraph
end

puts Cowsay.say 'Created 100 reviews', :cow
