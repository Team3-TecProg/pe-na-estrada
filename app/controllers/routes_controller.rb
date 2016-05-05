#####################################################################
# Class name: RoutesController
# File name: routes_controller.rb
# Description: Controller used by model Route to communicate with the
# view routes/index.
#####################################################################


class RoutesController < ApplicationController

  # This method returns a variable called '@route' that contains a new object of  # the route.
  # This method is called from the view package to show the web page to the user
  def index
      @ROUTE = Route.new
  end

  # This method return the result of other method
  # 'get_accidents_data_to_sinalize' and render the index of this part of the software.
  def trace_route
      @ROUTE = Route.new(origin_params)
      @ORIGIN_INFORMED_BY_USER = @ROUTE.origin
      @DESTINATION_INFORMED_BY_USER = @ROUTE.destination

      get_accidents_data_to_sinalize

      render :index
  end

  # This method returns the method 'remove_unusable_coordinates' with latitude,
  # longitude and 'br' with parameters.
  def get_accidents_data_to_sinalize
      latitude = Accident.get_accidents_latitude
      longitude = Accident.get_accidents_longitude
      br = Accident.get_accidents_br

      remove_unusable_coordinates latitude, longitude, br
  end


  # This method  returns the call of the method 'send_accidents_data_to_js'
  # giving three arrays in the parameters.
  def remove_unusable_coordinates (latitude, longitude, br)
      # Arrays to store the usables coordinates and highways
      latitudeUsable = [];
      longitudeUsable = [];
      highways = [];

      i = 0; #Counter to get the latitudes from database
      j = 0; #Get the latitude, longitude e br usables

      while i < latitude.length
          if latitude[i].blank? == false
              latitudeUsable[j] = latitude[i]
              longitudeUsable[j] = longitude[i]
              highways[j] = br[i]
              j = j + 1
          else
              #nothing to do
          end

          i = i + 1
          return i
      end

    send_accidents_data_to_js latitudeUsable, longitudeUsable, highways
  end

  # This method have 'latitude', 'longitude' and 'br' as parameters
  # After that, all the variables are changed to java script mode
  def send_accidents_data_to_js (latitude, longitude, br)
      gon.latitude = latitude
      gon.longitude = longitude
      gon.br = br
  end

  # This method take the data from url to be used in this class. The data are
  # 'origin' and 'destination' of the route.
  def origin_params
      params.require(:route).permit(:origin, :destination)
  end

end
