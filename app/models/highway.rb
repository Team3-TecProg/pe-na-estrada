######################################################################
# Class name: Highway
# File name: highway.rb
# Description: Represents a Brazilian highway, a main road that
# usually connects major cities.
######################################################################

class Highway < ActiveRecord::Base
    extend Assertions

    has_many :comments

    validates_presence_of :idBr, message: 'idBr cannot be null.'
    validates_length_of :idBr, within: 2..3,
        too_short: 'The idBr is too short. Must be in the range 2..3.',
        too_long:'The idBr is too long. Must be in the range 2..3.'
    validates_uniqueness_of :idBr,
        message: "This idBr already exists on data base."
    validates_numericality_of :mileage, greater_than_or_equal_to: 1,
        allow_nil: true, message: 'Mileage cannot be shorter than 1.'

    public

    # Description: Searches for highways based on a query provided by the user.
    # If no query is provided, returns all highways.
    # Parameters: id_to_search.
    # Return: none.
    def self.search_for_highway ( id_to_search )
        assert_object_is_not_null( id_to_search )

        if ( id_to_search.blank? )
            id_to_search = ""
        else
            # Nothing to do
        end

        # Returns all highways registered if id_to_search is empty
        where( "idBr LIKE ?", "%#{id_to_search}%" ).order( :idBr )
    end

    # Description: Checks the existence of highways.
    # Parameters: highway_to_check.
    # Return : verify_exists_highway.
    def self.exists_highway ( highway_to_check )
        assert_object_is_not_null( highway_to_check )
        # Boolean variable to show if the highway exists or not
        verify_exists_highway = false
        if highway_to_check.present?
            verify_exists_highway = exists?( ['idBr LIKE ?',
                "%#{highway_to_check}%"] )
        else
            # verify_exists_highway begins with false value, but here the false
            # value is used to make it explicit.
            verify_exists_highway = false
        end
        assert_object_is_not_null( verify_exists_highway )

        return verify_exists_highway
    end

    # Description: Returns all highways by accidents rate in descending order.
    # Parameters: none.
    # Return : highways_ordered_by_accidents_rate.
    def self.all_highways_by_accidents_rate
        highways_ordered_by_accidents_rate = Highway.
            order( accidentsRate: :desc )
        assert_object_is_not_null( highways_ordered_by_accidents_rate )

        return highways_ordered_by_accidents_rate
    end

    # Description: Returns all highways by accidents rate percentage in
    # in descending order.
    # Parameters: none.
    # Return: highways_ordered_by_accidents_rate_percentage.
    def self.all_highways_by_accidents_rate_percentage
        highways_ordered_by_accidents_rate_percentage = Highway.
            order( accidentsRatePercent: :desc )
        assert_object_is_not_null(
         highways_ordered_by_accidents_rate_percentage
        )

        return highways_ordered_by_accidents_rate_percentage
    end
end
