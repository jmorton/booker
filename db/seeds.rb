# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Guest.create(name: "YOU")
Guest.create(name: "HER")
Guest.create(name: "HIM")

Unit.create(name: "SF01", address: "200 S Phillips Ave, Sioux Falls, SD 57104", latitude: 43.5458516, longitude: -96.7266059)
Unit.create(name: "SF02", address: "332 S Phillips Ave, Sioux Falls, SD 57104", latitude: 43.5436269, longitude: -96.7265842)
Unit.create(name: "SF03", address: "2101 W 41st St,     Sioux Falls, SD 57105", latitude: 43.5126624, longitude: -96.7532896)
