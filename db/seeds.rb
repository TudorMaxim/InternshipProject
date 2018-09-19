# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#

User.all.each do |u|
  BoughtSkin.create(user_id: u.id,
                    name: Skin.first.name,
                    skin_type: Skin.first.skin_type,
                    selected: true,
                    image: Skin.first.image
                  )
  BoughtSkin.create(user_id: u.id,
                    name: Skin.second.name,
                    skin_type: Skin.second.skin_type,
                    selected: true,
                    image: Skin.second.image )
  BoughtSkin.create(user_id: u.id,
                    name: Skin.third.name,
                    skin_type: Skin.third.skin_type,
                    selected: true,
                    image: Skin.third.image )

end
# User.create!(first_name:  "Tudor",
#              last_name: "Maxim",
#              email: "tudor.maxim@takeofflabs.com",
#              password:              "password",
#              password_confirmation: "password",
#              admin: true,
#              confirmed_at: DateTime.now)
# #Users
# 99.times do |n|
#   first_name  = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   u = User.create!(first_name:  first_name,
#                last_name: last_name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                confirmed_at: DateTime.now)
# end
#
# #Friendships
# a = User.first
# (2..65).to_a.each do |i|
#   b = User.find_by(id: i)
#   b.invite a
#   a.accept b
#   (1..10).to_a.each do |j|
#     c = User.find_by(id: i + j)
#     b.invite c
#     c.accept a
#   end
# end
#
# #challenges
# choices = ["rock", "paper", "scissors"]
#
# (2..11).to_a.each do |i|
#   b = User.find_by(id: i)
#   a.challenge b
#   b.accept_challenge a
#   c = Challenge.find_by(sender_id: 1, receiver_id: i)
#   c1 = Random.rand(3)
#   c2 = Random.rand(3)
#   c.make_choice(a, choices[c1])
#   c.make_choice(b, choices[c2])
# end
#
# 100.times do |i|
#   a = User.find_by(id: Random.rand(99) + 1)
#   b = User.find_by(id: Random.rand(99) + 1)
#   if a != b
#     if !a.friend_with? b
#       a.invite b
#       b.accept a
#     end
#     a.challenge b
#     b.accept_challenge a
#     c = Challenge.find_by(sender_id: a.id, receiver_id: b.id)
#     c1 = Random.rand(3)
#     c2 = Random.rand(3)
#     c.make_choice(a, choices[c1])
#     c.make_choice(b, choices[c2])
#   end
# end
#
# Notification.destroy_all
