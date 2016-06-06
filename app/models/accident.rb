######################################################################
# Class name: Accident
# File name: accident.rb
# Description: Represents eventual accidents that happen in a highway.
######################################################################

class Accident < ActiveRecord::Base
    include Assertions

    #federative_unity represents a state of Brazil.
    validates_presence_of :federative_unity
    #kilometer represents the distance of a highway.
    validates_presence_of :kilometer
    #br is a classification, given to the main roads on Brazil.
    validates_presence_of :highway_number

    belongs_to :Highway

    public

    # Description: The total of accidents thats happends in one highway.
    # Parameters: none.
    # Return : total_accidents.
    def total_accidents
        # Recives the number of total accidents in one especific highway.
        total_accidents = Accident.count
        assert_object_is_not_null( total_accidents )

        return total_accidents
    end

    # Description: Take the accidents from the accident latitude perspective.
    # Parameters: none.
    # Return : accidents_latitudes
    def get_accidents_latitude
        accidents_latitudes = Accident.all.map( &:latitude )
        assert_object_is_not_null( accidents_latitudes )

        return accidents_latitudes
    end

    # Description: Take the accidents from the accident longitude perspective.
    # Parameters: none.
    # Return : accidents_longitudes
    def get_accidents_longitude
        accidents_longitudes = Accident.all.map( &:longitude )
        assert_object_is_not_null( accidents_longitudes )

        return accidents_longitudes
    end

    # Description: Create a array with the highway number where every
    # accident occurs.
    # Parameters: none.
    # Return : accidents_highway_number
    def get_accidents_highway_number
        accidents_highway_number = Accident.all.map( &:highway_number )
        assert_object_is_not_null( accidents_highway_number )

        return accidents_highway_number
    end

    # Description: Counts the number of accidents in one highway.
    # Parameters: none.
    # Return : group().
    def count_accidents
        # Number of the chosen highways.
        accidents_in_a_br = Accident.group( :highway_number ).count
        assert_object_is_not_null( accidents_in_a_br )

        return accidents_in_a_br
    end
end
