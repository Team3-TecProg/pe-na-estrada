######################################################################
# Class name: Route
# File name: route.rb
# Description: Represents a path that connects two points (a origin and a 
# destination), passing through one or more highways.
######################################################################

class Route < ActiveRecord::Base

  	validates_presence_of :origin , message: "Origin field must be present."
  	validates_presence_of :destination, message: "Destination field must be 
                                                  present."

  	geocoded_by :address
	after_validation :geocode
end
