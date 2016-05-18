require 'test_helper'

class AccidentTest < ActiveSupport::TestCase

		def setup
				@accident = Accident.new
				@total_accidents = Accident.count
		end

		test "test_accident_one" do
				@accident.latitude = accidents(:one).longitude
				@accident.longitude = accidents(:one).latitude
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				assert @accident.save
		end

		test "test_presenceOf_Accidents" do
				@accident.latitude = accidents(:two).longitude
				@accident.longitude = accidents(:two).latitude
				@accident.uf = accidents(:two).uf
				@accident.km = accidents(:two).km
				@accident.br = accidents(:two).br
				assert_not @accident.save, "Cannot be null"
		end

		test "test_presenceOf_uf" do
				@accident.latitude = accidents(:one).longitude
				@accident.longitude = accidents(:one).latitude
				@accident.uf = accidents(:two).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				assert_not @accident.save, "Cannot be null"
		end

		test "test_presenceOf_km" do
				@accident.latitude = accidents(:one).longitude
				@accident.longitude = accidents(:one).latitude
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:two).km
				@accident.br = accidents(:one).br
				assert_not @accident.save, "Cannot be null"
		end

		test "test_presenceOf_br" do
				@accident.latitude = accidents(:one).longitude
				@accident.longitude = accidents(:one).latitude
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:two).br
				assert_not @accident.save, "Cannot be null"
		end

		test "Checking if uf is empty" do
				@accident.latitude = accidents(:one).latitude
				@accident.longitude = accidents(:one).longitude
				@accident.uf = accidents(:three).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				assert_not @accident.save, "Cannot be invalid"
		end

		test "Checking if br is empty" do
				@accident.latitude = accidents(:one).latitude
				@accident.longitude = accidents(:one).longitude
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:three).br
				assert_not @accident.save, "Cannot be invalid"
		end

		test "get accidents longitude at position 4 of the array" do
				assert_equal Accident.get_accidents_longitude[4], accidents(:five).longitude,
				 "test if get accidents longitude at position 4 of the array"
		end

		test "get accidents longitude at position 1 of the array" do
				assert_equal Accident.get_accidents_longitude[1], accidents(:four).longitude,
				 "test if get accidents longitude at position 1 of the array"
		end

	 	test "get accidents latitude at position 4 of the array" do
				assert_equal Accident.get_accidents_latitude[4], accidents(:five).latitude,
				 "test if get accidents latidude at position 4 of the array"
		end

		test "get accidents latitude at position 1 of the array" do
				assert_equal Accident.get_accidents_latitude[1], accidents(:four).latitude,
				 "test if get accidents latitude at position 1 of the array"
		end

		test "get correct total of accidents" do
				assert_equal Accident.total_accidents,@total_accidents
		end

		test "get correct total of accidents after one more intantiates of accident" do
				@accident.latitude = accidents(:one).longitude
				@accident.longitude = accidents(:one).latitude
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				@accident.save!
				assert_equal Accident.total_accidents,@total_accidents + 1
		end

		test "get the latitudes for an accidents" do
				latitude_test = 21
				longitude_test = 22
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				@accident.latitude = latitude_test
				@accident.longitude  = longitude_test
				@accident.save!
				expected_latitude = 21.to_s
				accident_latitude = Accident.get_accidents_latitude.last
				assert_equal expected_latitude,accident_latitude
		end

		test "get the longitude for an accidents" do
				latitude_test = 21
				longitude_test = 22
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = accidents(:one).br
				@accident.latitude = latitude_test
				@accident.longitude  = longitude_test
				@accident.save!
				expected_latitude = 22.to_s
				accident_latitude = Accident.get_accidents_longitude.last
				assert_equal expected_latitude,accident_latitude
		end

		test "get the number of accidents that ocurred in a br" do
				br_number_test = 21
				@accident.uf = accidents(:one).uf
				@accident.km = accidents(:one).km
				@accident.br = br_number_test
				@accident.save!
				brs_number_of_accidents = Accident.where(br: br_number_test).count
				hash = Accident.count_accidents
				assert_equal Accident.count_accidents[br_number_test.to_s],brs_number_of_accidents
		end


end
