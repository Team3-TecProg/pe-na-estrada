#####################################################################
# Class name: RoutesControllerTest
# File name:key => "value",  routes_controller_test.rb
# Description: Test class that contains all functional tests for
# routes controller
#####################################################################

require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
    test "route to index" do
        assert_recognizes( { :controller => "routes", :action => "index" },
         { :path => "routes", :method => :get } )
    end

    test "route to create" do
        assert_recognizes( { :controller => "routes", :action => "create" },
         { :path => "routes", :method => :post } )
    end

    test "should trace route" do
        post :trace_route, :ROUTE => { :origin => routes( :one ).origin,
        :destination => routes( :one ).destination }
        assert_not_nil assigns( :ROUTE )
    end

    test "test index" do
        get :index
        assert_response :success
        assert_not_nil assigns( :ROUTE )
    end

    test "datas of accidents sent to java script" do
        latitude = 25
        longitude = 25
        highway_number = 25
        returned_gon_object = @controller.send_accidents_data_to_js(latitude,
         longitude,highway_number)
        assert_equal returned_gon_object.latitude, latitude
        assert_equal returned_gon_object.longitude, longitude
        assert_equal returned_gon_object.highway_number, highway_number
    end
end
