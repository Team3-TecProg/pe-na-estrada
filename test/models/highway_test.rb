#####################################################################
# Class name: HighwayTest
# File name: highway_test.rb
# Description: Test class that contains all the unit tests for
# highway model.
#####################################################################

require 'test_helper'

class HighwayTest < ActiveSupport::TestCase
		def setup
				@HIGHWAYS = Highway.all
				@HIGHWAY = Highway.new

		 		@EXPECTED_THIRD_HIGHWAY = Highway.new
		 		@EXPECTED_THIRD_HIGHWAY.accidentsRate = 15
		 		@EXPECTED_THIRD_HIGHWAY.accidentsRatePercent = 15
		 		@EXPECTED_THIRD_HIGHWAY.idBr = 20
		 		@EXPECTED_THIRD_HIGHWAY.save

		 		@expected_second_highway = Highway.new
		 		@expected_second_highway.accidentsRate = 20
		 		@expected_second_highway.accidentsRatePercent = 20
		 		@expected_second_highway.idBr = 21
		 		@expected_second_highway.save

		 		@expected_first_highway = Highway.new
		 		@expected_first_highway.accidentsRate = 25
		 		@expected_first_highway.accidentsRatePercent = 25
		 		@expected_first_highway.idBr = 22
		 		@expected_first_highway.save
		end

		QUANTITY_OF_FIXTURES = 6

		test "should get the highways in descending order according
		 its accidentsRate number" do
		 		ordered_highways = Highway.all_highways_by_accidents_rate

		 		assert_equal ordered_highways.first.accidentsRate, 25
		 		assert_equal ordered_highways.second.accidentsRate, 20
		 		assert_equal ordered_highways.third.accidentsRate, 15
		end

		test "should get the highways in descending order according
		 its accidentsRatePercentage number" do
		 		ordered_highways = Highway.all_highways_by_accidents_rate_percentage

		 		assert_equal ordered_highways.first.accidentsRatePercent, 25
		 		assert_equal ordered_highways.second.accidentsRatePercent, 20
		 		assert_equal ordered_highways.third.accidentsRatePercent, 15
		end

		# Based on fixtures
		test "Test if are at least one highway is registered on DB" do
				assert_instance_of Highway, Highway.first, 
				"Object on DB not correspond to it's expected class"
				assert_not_nil Highway.first, "Object registered on DB cannot be null"
		end

		# Based on fixtures
		test "Should be equal to 6 the quantity of Highway objects on DB" do
				assert_equal QUANTITY_OF_FIXTURES, Highway.count, 
				"Registered data does not match the actual quantity registered"
		end

		# Based on fixtures
		test "Test if all idBr's registered is present" do
				@HIGHWAYS.each do |highway|
						assert highway.idBr.present?, "idBr  must be present!"
				end
		end

		# Based on fixtures
		test "Test if the instance on fixtures matches" do
				assert_equal "121", highways(:one).idBr, 
				"idBr from first fixture does not matches with the previous\
				 instantiated."
				assert_equal 1500, highways(:one).mileage, 
				"mileage from first fixture does not matches with the previous\
				 instantiated."
				assert_equal "987", highways(:two).idBr, 
				"idBr from second fixture does not matches with the previous\
				 instantiated."
				assert_equal 2570, highways(:two).mileage, 
				"mileage from second fixture does not matches with the previous\
				 instantiated."
		end

		# Test validates_uniqueness_of :idBr
		test "Should not save duplicated data on DB" do
				@HIGHWAY.idBr = "121"
				@HIGHWAY.mileage = "1500"

				assert_not @HIGHWAY.save, 
				"This idBr already exists. Cannot save duplicated idBr"
		end

		# Begin tests to 'validates_presence_of :idBr
		test "Should save a valid Highway object" do
				@HIGHWAY.idBr = "131"
				@HIGHWAY.mileage = 124

				assert @HIGHWAY.save, "Could not save this object"
		end

		test "Should not save a empty object" do
				assert_not @HIGHWAY.save, "Cannot save an empty object"
		end

		test "Should not save without an idBr" do
				@HIGHWAY.mileage = 1200

				assert_not @HIGHWAY.save, "Cannot save without an idBr"
		end

		test "Should not save with a empty idBr" do
				@HIGHWAY.idBr = ""

				assert_not @HIGHWAY.save, "Cannot save with an empty idBr"
		end

		test "Should not save with a null idBr" do
				@HIGHWAY.idBr = nil

				assert_not @HIGHWAY.save, "Cannot save with a null idBr"
		end
		# End of tests to 'validates_presence_of :idBr'

		# Begin tests to 'validates_length_of :idBr'
		test "Should save an Highway object with an idBr in the range 2..3 of\
		 length. Test the maximum edge." do
				@HIGHWAY.idBr = "111"
				assert @HIGHWAY.save, "Cannot save an idBr out of range 2..3"
		end

		test "Should save an Highway object with an idBr in the range 2..3 of\
		 length. Test the minimum edge" do
				@HIGHWAY.idBr = "50"
				assert @HIGHWAY.save, "Cannot save an idBr out of range 2..3"
		end

		test "Should not save an Highway object with an idBr out of range 2..3 of\
		 length. Test a shorter than 2 idBr length" do
				@HIGHWAY.idBr = "1"
				assert_not @HIGHWAY.save, "Too short idBr. Cannot save an idBr with a\
				 length shorter than 2 characters"
		end

		test "Should not save an Highway object with an idBr out of range 2..3 of\
		 length. Test a greater than 2 idBr length" do
				@HIGHWAY.idBr = "2222"
				assert_not @HIGHWAY.save, "Too long idBr. Cannot save an idBr with a\
				 length greater than 3 characters"
		end
		#End of tests to 'validates_length_of :idBr'

		# Begin tests to 'validates_numericality_of :mileage'
		test "Should save an Highway object with a mileage greater than 1" do
				@HIGHWAY.idBr = "111"
				@HIGHWAY.mileage = 200

				assert @HIGHWAY.save, "Cannot save a mileage shorter than 1"
		end

		test "Should save an Highway object with a mileage equal to 1" do
				@HIGHWAY.idBr = "111"
				@HIGHWAY.mileage = 1

				assert @HIGHWAY.save, "Cannot save a mileage shorter than 1"
		end

		test "Should not save an Highway object with a mileage equal to 0" do
				@HIGHWAY.idBr = "111"
				@HIGHWAY.mileage = 0

				assert_not @HIGHWAY.save, "Cannot save a mileage shorter than 1"
		end

		test "Should not save an Highway object with a negative mileage" do
				@HIGHWAY.idBr = "111"
				@HIGHWAY.mileage = -1

				assert_not @HIGHWAY.save, "Cannot save a mileage shorter than 1"
		end

		test "Should save an Highway object with a null mileage" do
				@HIGHWAY.idBr = "111"
				@HIGHWAY.mileage = nil

				assert @HIGHWAY.save, "Could not save a null mileage"
		end
		# End of tests to 'validates_numericality_of :mileage'

		test "Test the 'exists_highway' method" do
				# Passing first fixture
				@HIGHWAY_exists_result_first = Highway.exists_highway "121"

				# Passing second fixture
				@HIGHWAY_exists_result_second = Highway.exists_highway "987"

				# Passing a unregistered highway
				@HIGHWAY_exists_result_third = Highway.exists_highway "123"

				# Passing a invalid highway idBr
				@HIGHWAY_exists_result_fourth = Highway.exists_highway "!Jkfsd"

				assert @HIGHWAY_exists_result_first,
				 "This highway informed does not exists on DB"
				assert @HIGHWAY_exists_result_second,
				 "This highway informed does not exists on DB"
				assert_not @HIGHWAY_exists_result_third,
				 "This highway informed should not exists on DB"
				assert_not @HIGHWAY_exists_result_fourth,
				 "This highway informed should not exists on DB"
		end

	test "Test the 'exists_highway' method with nil argument" do

		# Using a unregistered highway
		@HIGHWAY_exists_result = Highway.exists_highway nil

		assert_not @HIGHWAY_exists_result,
		 "Should not exists a nil highway idBr on DB"

	end

	test "Test the 'exists_highway' method with empty argument" do

		# Using a unregistered highway
		@HIGHWAY_exists_result = Highway.exists_highway ""

		assert_not @HIGHWAY_exists_result,
		 "Should not exists an empty highway idBr on DB"

	end

	test "Test the 'search_for_highway' method with valid argument" do

		@HIGHWAY_search_result = Highway.search_for_highway "121"

		assert_kind_of ActiveRecord::Relation, @HIGHWAY_search_result,
		 "Not a instance of ActiveRecord::Relation returned\
		  from the method 'search_for_highway'"

		@HIGHWAY_search_result.each do |highway|

			assert_instance_of Highway, highway,
			 "Result from search is not a Highway object"
			assert_not_nil highway,
			 "Result from search is a null Highway object"
			assert_instance_of String, highway.idBr,
			 "The Highway object idBr from search is not a String"
			assert_instance_of Fixnum, highway.mileage,
			 "The Highway object mileage from search is not a Fixnum"
			assert_equal highway.idBr,
			 "121", "The idBr got is not the same that was registered"
			assert_equal highway.mileage, 1500,
			 "The mileage got is not the same that was registered"

		end

	end

	test "Test the 'search_for_highway' method with an unregistred highway" do
			@HIGHWAY_search_result = Highway.search_for_highway "123"

			assert_kind_of ActiveRecord::Relation, @HIGHWAY_search_result,
			 "Not a instance of ActiveRecord::Relation returned\
			  from the method 'search_for_highway'"
			assert_nil @HIGHWAY_search_result.first,
			 "This relation should be nill."
	end

	test "Test the 'search_for_highway' method with a empty highway. Should\
	 be return all highways o DB." do
			@HIGHWAY_search_result = Highway.search_for_highway ""

			assert_kind_of ActiveRecord::Relation, @HIGHWAY_search_result,
			 "Not a instance of ActiveRecord::Relation returned\
			  from the method 'search_for_highway'"

			assert_equal QUANTITY_OF_FIXTURES, Highway.count,
			 "Should be equal to the quantity of registers on DB"

			@HIGHWAY_search_result.each do |highway|
					assert_not_nil highway, "This object should not be null"
					assert_not_nil highway.idBr, "The idBr should not be null"
					assert_instance_of String, highway.idBr,
					 "The idBr should be a String."
			end
	end

	test "Test the 'search_for_highway' method with a null highway.\
	 Should be return all highways o DB." do

		@HIGHWAY_search_result = Highway.search_for_highway nil

		assert_kind_of ActiveRecord::Relation, @HIGHWAY_search_result,
		 "Not a instance of ActiveRecord::Relation returned\
		  from the method 'search_for_highway'"

		assert_equal QUANTITY_OF_FIXTURES, Highway.count,
		 "Should be equal to the quantity of registers on DB"

		@HIGHWAY_search_result.each do |highway|

			assert_not_nil highway, "This object should not be null"
			assert_not_nil highway.idBr, "The idBr should not be null"
			assert_instance_of String, highway.idBr, "The idBr should\
			 be a String."

		end

	end

end
