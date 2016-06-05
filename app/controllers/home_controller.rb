#####################################################################
# Class name: HomeController
# File name: home_controller.rb
# Description: Controller used to communicate with the view
# home/index.
#####################################################################

class HomeController < ApplicationController
    include Assertions

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    # Description: Returns the highways objects accordign its
    # accidents rate.
    # Parameters: none.
    # Return: @HIGHWAY.
    def index
    	  @HIGHWAY = Highway.all_highways_by_accidents_rate

        return @HIGHWAY
    end
end
