#####################################################################
# Class name: RouteTest
# File name: route_test.rb
# Description: Test class that contains all the unit tests for
# route model.
#####################################################################

require 'test_helper'

class RouteTest < ActiveSupport::TestCase

	def setup
		@ROUTE = Route.new
	end

	test "Should not save route without any data" do
		@ROUTE.origin = routes( :two ).origin
		@ROUTE.destination = routes( :two ).destination
		assert_not @ROUTE.save, "Should not saved because both fields\
		 are null."
	end

	test "Should not save route without origin" do
		@ROUTE.origin = routes( :two ).origin
		@ROUTE.destination = routes( :one ).destination
		assert_not @ROUTE.save, "Should not saved because the origin field\
		 is null."
	end

	test "Should not save route without destination" do
		@ROUTE.origin = routes( :one ).origin
		@ROUTE.destination = routes( :two ).destination
		assert_not @ROUTE.save, "Should not saved because the destination\
		 field is null."
	end

	test "Should not save route with empty destination" do
		@ROUTE.origin = routes( :one ).origin
		@ROUTE.destination = routes( :three ).destination
		assert_not @ROUTE.save, "Should not saved because the destination\
		 field is empty."
	end

	test "Should not save route with null origin and empty destination" do
		@ROUTE.origin = routes( :two ).origin
		@ROUTE.destination = routes( :three ).destination
		assert_not @ROUTE.save, "Should not saved because the origin field\
		 is null and the destination field is empty."
	end

	test "Should not save route with null origin" do
		@ROUTE.origin = routes( :three ).origin
		@ROUTE.destination = routes( :one ).destination
		assert_not @ROUTE.save, "Should not saved because the origin field\
		 is empty."
	end

	test "Should not save route with null origin and null destination" do
		@ROUTE.origin = routes( :three ).origin
		@ROUTE.destination = routes( :two ).destination
		assert_not @ROUTE.save, "Should not saved because the origin field\
		 is empty and the destination field is null."
	end

	test "Should not save route with empty origin and empty destination" do
		@ROUTE.origin = routes( :three ).origin
		@ROUTE.destination = routes( :three ).destination
		assert_not @ROUTE.save, "Should not saved because both fields\
		 are empty."
	end

	test "Should save route with data" do
		@ROUTE.origin = routes( :one ).origin
		@ROUTE.destination = routes( :one ).destination
		assert @ROUTE.save
	end

end
