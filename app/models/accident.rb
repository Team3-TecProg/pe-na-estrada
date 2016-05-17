class Accident < ActiveRecord::Base

    #uf means Federative Unity, which represent a state of Brazil;
    validates_presence_of :uf
    #km means distance in kilometers.
    validates_presence_of :km
    #br is a classification, given to the main roads on Brazil;
    validates_presence_of :br

    belongs_to :Highway

    # Description: Counts the number of accidents in one highway.
    # Parameters: none.
    # Return : group().
    def self.count_accidents
        # Number of the chosen highways.
        accidents_in_a_br = group(:br).count

        return accidents_in_a_br
    end

    # Description: The total of accidents thats happends in one highway.
    # Parameters: none.
    # Return : total_accidents.
    def self.total_accidents
        # Recives the number of total accidents in one especific highway.
 	    total_accidents = Accident.count

        return total_accidents
    end

    # Description: Take the accidents from the accident latitude perspective.
    # Parameters: none.
    # Return : accidents_latitudes
    def self.get_accidents_latitude
        accidents_latitudes = all.map(&:latitude)

        return accidents_latitudes
    end

    # Description: Take the accidents from the accident longitude perspective.
    # Parameters: none.
    # Return : accidents_longitudes
    def self.get_accidents_longitude
        accidents_longitudes = all.map(&:longitude)

        return accidents_longitudes
    end

    # Description: Create a array with the highway number where every
    # accident occurs.
    # Parameters: none.
    # Return : accidents_highway_number
    def self.get_accidents_highway_number
        accidents_highway_number = all.map(&:highway_number)

        return accidents_highway_number
    end
end
