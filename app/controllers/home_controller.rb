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

  def index
  	  @highway = Highway.all_highways_by_accidentsRate
      return @highway
  end
end
