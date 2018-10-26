# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create [
  127347, 127345, 127341, 127337, 127334, 127323, 127317, 127303, 127296,
  127295, 127292, 127281, 127277, 127272, 127270, 127268, 127259, 127249,
  127248, 127236, 127229, 127224, 127214, 127206, 127205, 127196, 126870
].map { |id| { id: id, email: "s#{id}@student.put.poznan.pl" }}
