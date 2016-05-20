######################################################################
# Class name: Highway
# File name: highway.rb
# Description: Represents a brazilian highway, a main road that usually connects
# major cities.
######################################################################

class Highway < ActiveRecord::Base

    has_many :Comment
    validates_presence_of :idBr, message: 'idBr cannot be null.'
    validates_length_of :idBr, within: 2..3, too_short: 'The idBr is too short. Must be in the range 2..3.', too_long:'The idBr is too long. Must be in the range 2..3.'
    validates_uniqueness_of :idBr, message: "This idBr already exists on data base."

    # Change this if the type of mileage change on schema
    validates_numericality_of :mileage, greater_than_or_equal_to: 1, allow_nil: true, message: 'Mileage cannot be shorter than 1.'


    def self.search_for_highway id_to_search
        if id_to_search.blank?
            id_to_search = ""
        else
            # Nothing to do
        end
        # Return all highways registered if id_to_search is empty
        where("idBr LIKE ?", "%#{id_to_search}%").order(:idBr)
    end

    # Description: Check the existence of highways.
    # Parameters: none.
    # Return : verify_exists_highway.
    def self.exists_highway ( highway_to_check )
        # Boolean variable to show if the highway exists or not.
        verify_exists_highway = false
        if highway_to_check.present?
            verify_exists_highway = exists?(['idBr LIKE ?', "%#{highway_to_check}%"])
        else
            # verify_exists_highway begins with false value, but here the false value
            # is used to make it explicit.
            verify_exists_highway = false
        end

        return verify_exists_highway
    end

    # Description: Returns all highways by accidents rate.
    # Parameters: none.
    # Return : all.
    def self.all_highways_by_accidents_rate
          all.order(:accidentsRate).reverse_order
    end

    # Description: Returns all highways by accidents rate percentage.
    # Parameters: none.
    # Return : all.
    def self.all_highways_by_accidents_rate_percentage
          all.order(:accidentsRatePercent).reverse_order
    end

end
