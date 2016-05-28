#####################################################################
# Class name: RoutesController
# File name: routes_controller.rb
# Description: Controller used by model Route to communicate with the
# view routes/index.
#####################################################################

class RoutesController < ApplicationController
    include Assertions

    # Description: This method is called from the view package to show the web
    # page to the user.
    # Parameters: none.
    # Return: @route.
    def index
        @ROUTE = Route.new
    end

    # Description: This method return the result of other method
    # 'get_accidents_data_to_sinalize' and render the index of this part of the
    # software.
    # Parameters: none.
    # Return: none.
    def trace_route
        @ROUTE = Route.new(origin_params)
        @ORIGIN_INFORMED_BY_USER = @ROUTE.origin
        @destination_informed_by_user = @ROUTE.destination

        get_accidents_data_to_sinalize

        render :index
    end

    # Description: This method returns the method 'remove_unusable_coordinates'
    # with latitude, longitude and 'highway_number' with parameters.
    # Parameters: none.
    # Return: none.
    def get_accidents_data_to_sinalize
        latitude = Accident.get_accidents_latitude
        longitude = Accident.get_accidents_longitude
        highway_number = Accident.get_accidents_highway_number

        remove_unusable_coordinates latitude, longitude, highway_number
    end


    # Description: This method  returns the call of the method
    #'send_accidents_data_to_js' giving three arrays in the parameters.
    # Parameters: latitude, longitude, highway_number.
    # Return: latitudes_counter.
    def remove_unusable_coordinates (latitude, longitude, highway_number)
        # Arrays to store the usables coordinates and highways
        latitude_usable = []
        longitude_usable = []
        highways = []

        latitudes_counter = 0 # Counter to get the latitudes from database
        index = 0 # Get the latitude, longitude e highway_number usables
        iterator_sum = 1
        while latitudes_counter < latitude.length
            if latitude[latitudes_counter].blank? == false
                latitude_usable[index] = latitude[latitudes_counter]
                longitude_usable[index] = longitude[latitudes_counter]
                highways[index] = highway_number[latitudes_counter]
                index = index + iterator_sum
            else
                # Nothing to do
            end

            latitudes_counter = latitudes_counter + iterator_sum
            return latitudes_counter
        end

        send_accidents_data_to_js latitude_usable, longitude_usable, highways
    end

    # Description: This method have 'latitude', 'longitude' and 'highway_number'
    # as parameters. After that, all the variables are changed to java script mode
    # Parameters: latitude, longitude, highway_number.
    # Return: gon.latitude, gon.longitude and gon.highway_number.
    def send_accidents_data_to_js (latitude, longitude, highway_number)
        gon.latitude = latitude
        gon.longitude = longitude
        gon.highway_number = highway_number

        return gon
    end

    # Description: This method take the data from url to be used in this class.
    # The data are 'origin' and 'destination' of the ROUTE.
    # Parameters: none.
    # Return: none.
    def origin_params
        params.require(:ROUTE).permit(:origin, :destination)
    end

end
