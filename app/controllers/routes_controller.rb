######################################################################
# Class name: RoutesController
# File name: routes_controller.rb
# Description: Controller used by model Route to communicate with the view routes/index
######################################################################

#-*- encoding : utf-8 -*-

class RoutesController < ApplicationController

  def index
      @ROUTE = Route.new
  end

  def trace_route
      @ROUTE = Route.new(origin_params)
      @ORIGIN_INFORMED_BY_USER = @ROUTE.origin
      @DESTINATION_INFORMED_BY_USER = @ROUTE.destination

      get_accidents_data_to_sinalize

      render :index
  end

  def get_accidents_data_to_sinalize
      latitude = Accident.get_accidents_latitude
      longitude = Accident.get_accidents_longitude
      br = Accident.get_accidents_br

      remove_unusable_coordinates latitude, longitude, br
  end

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

  def send_accidents_data_to_js (latitude, longitude, br)
      gon.latitude = latitude
      gon.longitude = longitude
      gon.br = br
  end

  def origin_params
      params.require(:route).permit(:origin, :destination)
  end

end
