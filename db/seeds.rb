# This file contain all the record creation needed to seed the database with
# its default values.

# Route.
# Create 5 generic routes.
5.times do |i|
	Route.create(origin: "Origin ##{i}", destination: "Destination ##{i}")
end

# Accidents.
# Create 5 generic accidents.
5.times do |i|
	Accident.create(latitude: "Latitude ##{i}", longitude: "Latitude ##{i}",
		federative_unity: "Unidade Federativa ##{i}", kilometer: "#{i}",
      	highway_number: "Número da Rodovia ##{i}")
end

# Comment.
# Create 5 Comments.
5.times do |i|
	Comment.create(title: "Título ##{i}", text: "Texto ##{i}",idBr: "Id da Rodovia ##{i}")
end

# Single comment to be used in creation of Higways.
comment_default = Comment.create(title: "Título default", text: "Texto default")

# Highway.
# Create 5 Highways.
5.times do |i|
	Highway.create(idBr: "Id da Rodovia ##{i}", mileage: "#{i}")
end