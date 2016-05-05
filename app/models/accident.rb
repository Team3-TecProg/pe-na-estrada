class Accident < ActiveRecord::Base

    #uf means Federative Unity, which represent a state of Brazil;
    validates_presence_of :uf
    #km means distance in kilometers.
    validates_presence_of :km
    #br is a classification, given to the main roads on Brazil;
    validates_presence_of :br

    belongs_to :Highway

    def self.count_accidents
        group(:br).count
    end

    def self.total_accidents
 	      total_accidents = Accident.count
        return total_accidents
    end

    def self.get_accidents_latitude
        all.map &:latitude
    end

    def self.get_accidents_longitude
        all.map &:longitude
    end

    def self.get_accidents_highway_number
        all.map &:highway_number
    end
end
