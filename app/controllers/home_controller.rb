#####################################################################
# Class name: HomeController
# File name: home_controller.rb
# Description: Controller used to communicate with the view
# home/index
#####################################################################

class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Description: Shows the Highways objects to the user in a view.
  # Parameters: none.
  # Return: @highway.
  def index
  	  @highway = Highway.all_highways_by_accidents_rate
      return @highway
  end
end
