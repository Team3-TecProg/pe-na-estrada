# This file contain all the record creation needed to seed the database with
# its default values.

# Route.
# Create 5 generic routes.
5.times do |i|
  Route.create(origin: "Origin ##{i}", destination: "Destination ##{i}")
end