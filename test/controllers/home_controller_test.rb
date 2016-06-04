#####################################################################
# Class name: HomeControllerTest
# File name: home_controller_test.rb
# Description: Test class that contains all functional tests for
# home controller
#####################################################################

require 'test_helper'

class HomeControllerTest < ActionController::TestCase

    # Description: This method is called to instance and create objects
    # and any other thing needed to run the tests.
    # Parameters: none.
    # Return : none.
    def setup
        Highway.create( :idBr => 10, :accidentsRate => 15 )
        Highway.create( :idBr => 11, :accidentsRate => 20 )
        Highway.create( :idBr => 12, :accidentsRate => 25 )
    end

    test "Should show highways ordered by their accident rates" do
        get :index
        assert_response :success
        assert_equal assigns( :HIGHWAY ).first.accidentsRate, 25
        assert_equal assigns( :HIGHWAY ).second.accidentsRate, 20
        assert_equal assigns( :HIGHWAY ).third.accidentsRate, 15
    end
end
