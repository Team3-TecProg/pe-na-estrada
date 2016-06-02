#####################################################################
# Class name: RoutesControllerTest
# File name: routes_controller_test.rb
# Description: Test class that contains all functional tests for
# routes controller
#####################################################################

require 'test_helper'

class RoutesControllerTest < ActionController::TestCase

    test "content is not blank" do
        latitudes = { }
        counter = 15
        latitudes[15] = "filled"
        expected_result = true
        boolean_result = @controller.latitudes_is_blank( latitudes, counter )

        assert_equal expected_result, boolean_result
    end

    test "content is blank" do
        latitudes = { }
        counter = 15
        expected_result = false
        boolean_result = @controller.latitudes_is_blank( latitudes, counter )

        assert_equal expected_result, boolean_result
    end

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
