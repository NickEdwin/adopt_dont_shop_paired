# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter = Shelter.create(name: "Braun Farm", address: '4242 Farm Rd.', city: 'Eustis', state: 'FL', zip: 33790)
shelter2 = Shelter.create(name: "Jax Rescue", address: '30 Matanzas Way.', city: 'Jacksonville', state: 'FL', zip: 33578)

pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id)

pet2 = Pet.create(name: 'Marley', approx_age: 12, sex: "female", image: "https://s3-eu-west-1.amazonaws.com/w3.cdn.gpd/gb.pedigree.56/large_e6bfdad9-6951-407b-a11f-bbd0c25bd796.jpg", shelter_id: shelter.id)

pet3 = Pet.create(name: 'Leo', approx_age: 7, sex: 'male', image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12235957/Border-Collie-On-White-01.jpg", shelter_id: shelter2.id)
