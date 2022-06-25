# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'asd@a',
  password: 'asdfgh',
)

genres = %w(膵臓癌 大腸がん 胃がん 肺がん その他)
genres.each do |genre|
    Genre.find_or_create_by(name: genre)
end

