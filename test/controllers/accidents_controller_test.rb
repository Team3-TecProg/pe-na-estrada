#####################################################################
# Class name: AccidentsControllerTest
# File name: accidents_controller_test.rb
# Description: Test class that contains all functional tests for
# accidents controller
#####################################################################

require 'test_helper'

class AccidentsControllerTest < ActionController::TestCase

    test "route" do
        assert_recognizes( { :controller => "accidents", :action => "index" }, { :path => "accidents", :method => :get } )
        assert_recognizes( { :controller => "accidents", :action => "create" }, { :path => "accidents", :method => :post } )
        assert_recognizes( { :controller => "accidents", :action => "show", :id => "40" }, { :path => "accidents/40", :method => :get } )
        assert_recognizes( { :controller => "accidents", :action => "update", :id => "40" }, { :path => "accidents/40", :method => :put } )
        assert_recognizes( { :controller => "accidents", :action => "destroy", :id => "40" }, { :path => "accidents/40", :method => :delete } )
    end

end
