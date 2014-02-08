# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

testuser = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password")

Character.create(name: "Borsk", player_name: "Isaac", gender: "Male", height: "1.4m", build: "Medium", hair: "Brown", eyes: "Brown", user: testuser)
