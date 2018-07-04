# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(first_name: "Tudor", last_name: "Maxim", email: "tudor.maxim@takeofflabs.com", password:"password",
                    password_confirmation: "password", admin: true)
user1.confirmed_at = Time.now
user2 = User.create(first_name: "First", last_name: "Friend", email: "first@friend.com", password:"password",
                    password_confirmation: "password")
user2.confirmed_at = Time.now
user3 = User.create(first_name: "Best", last_name: "Friend", email: "best@friend.com", password:"password",
                    password_confirmation: "password")
user3.confirmed_at = Time.now
user4 = User.create(first_name: "Second", last_name: "Friend", email: "second@firend.com", password:"password",
                    password_confirmation: "password")
user4.confirmed_at = Time.now
user5 = User.create(first_name: "Third", last_name: "Friend", email: "third@firend.com", password:"password",
                    password_confirmation: "password")
