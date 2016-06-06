#####################################################################
# Class name: HighwaysController
# File name: highways_controller.rb
# Description: Controller used to communicate with the view
# highways/show and the model highway.
#####################################################################

class HighwaysController < ApplicationController
    include Assertions

    # Description: Receives a highway informed by the user, checks
    # if it exists in the database, clean any ‘0’s on the left of its name, and
    # holds it in a variable.
    # Parameters: none.
    # Return: none.
    def index
        @HIGHWAY_INFORMED_BY_USER = params[ :highway_search ]
        assert_object_is_not_null ( @HIGHWAY_INFORMED_BY_USER )
        @HIGHWAY_NUMBER_EXISTS  = check_length_and_if_exists \
                                  ( @HIGHWAY_INFORMED_BY_USER )
        assert_object_is_not_null ( @HIGHWAY_NUMBER_EXISTS  )
        @HIGHWAY = setup_highway  ( @HIGHWAY_INFORMED_BY_USER )
        assert_object_is_not_null ( @HIGHWAY )
    end

    # Description: Shows a given Highway model object in its HTML view page.
    # Parameters: none.
    # Return: none.
    def show
        @HIGHWAY = Highway.find ( params[:id] )
        @COMMENT = Comment.new
        @COMMENTS = @HIGHWAY.comments
    end

    public

    # Description: Checks the length of a highway informed and if it exists on
    # the database.
    # Parameters: highway_to_check.
    # Return: check_result.
    def check_length_and_if_exists ( highway_to_check )
        assert_object_is_not_null ( highway_to_check )

        # Check return of check_highway_number () method.
        verify_highway_number = check_highway_number ( highway_to_check )

        if ( verify_highway_number.class == String &&
             verify_highway_number.to_i >= 0 )
            cleaned_highway_to_check = verify_highway_number
        else
            # Nothing to do.
        end

        assert_object_is_not_null ( cleaned_highway_to_check )
        
        # Check return of check_highway_exists () method.
        valid_lenght =  check_highway_number_length ( cleaned_highway_to_check )

        if ( valid_lenght == true )
            check_result = check_highway_exists ( cleaned_highway_to_check )
        else
            check_result = false
        end

        return check_result
    end

    # Description: Defines the maximum length permitted to a highway name.
    # Parameters: none.
    # Return: max_highway_number_length.
    def max_highway_number_length
        # In Brazil, there are no highways with numbers longer than 3 digits.
        max_highway_number_length = 3

        return max_highway_number_length
    end

    # Description: Checks if a highway exists on the database.
    # Parameters: highway_to_check.
    # Return: check_result.
    def check_highway_exists ( highway_to_check )
        assert_object_is_not_null ( highway_to_check )
        if ( Highway.exists_highway ( highway_to_check ) )
            check_result = true
        else
            check_result =  false
        end

        return check_result
    end

    # Description: Sets up the instance variable '@HIGHWAY' on index with the
    # result from 'search_for_highway' method.
    # Parameters: highway.
    # Return: result.
    def setup_highway ( highway )
        if ( highway )
            result = search_for_highway ( highway )
        else
            result = nil
        end

        return result
    end

    # Description: Searches for a highway on the database.
    # Parameters: highway_to_search.
    # Return: search_result.
    def search_for_highway ( highway_to_search )
        assert_object_is_not_null ( highway_to_search )
        highway_cleaned = check_highway_number ( highway_to_search )
        assert_object_is_not_null ( highway_cleaned )
        search_result = Highway.search_for_highway ( highway_cleaned )
        assert_object_is_not_null( search_result )

        return search_result
    end

    # Description: Checks the length of the highway number informed.
    # Parameters: highway_number.
    # Return: check_result.
    def check_highway_number_length ( highway_number )
        assert_object_is_not_null ( highway_number )
        if ( !highway_number.blank? )
            highway_number_length = highway_number.size
            if ( highway_number_length >  max_highway_number_length )
                check_result = false
            else
                check_result = true
            end
        else
            check_result = false
        end

        return check_result
    end

    # Description: Ignores '0's on the left of a highway number.
    # Parameters: highway_number.
    # Return: highway_number.
    def check_highway_number ( highway_number )
        assert_object_is_not_null ( highway_number )
        if ( !highway_number.blank? )
            array_index = 0
            iterator_array_sum = 1;
            while highway_number.at( array_index ) == "0"
                highway_number = highway_number.from( array_index +
                iterator_array_sum )
            end
        else
            # Nothing to do.
        end
        return highway_number
    end

    # Description: Calculates the percentage of accidents based on the accidents
    # number on a given highway and the total of accidents registered. Receives
    # the accidents_number and the total_accidents parameters.
    # Parameters: accidents_number, mileage_highway.
    # Return: rate.
    def calculate_accidents_rate ( accidents_number, mileage_highway )
        assert_object_is_not_null ( accidents_number )
        assert_object_is_not_null ( mileage_highway )
        if ( mileage_highway.blank? )
            rate = 0.0
        else
            rate = accidents_number / mileage_highway.to_f
        end

        return rate
    end

    # Description: Saves the amount of Accident model objects in an @ACCIDENT
    # variable.
    # Parameters: none.
    # Return: @ACCIDENT.
    def count_accidents_by_highway
        @ACCIDENT = Accident.new.count_accidents
        assert_object_is_not_null ( @ACCIDENT )

        return @ACCIDENT
    end

    # Description: Saves all the highways from the database in a variable,
    # all the accidents from the database in another variable, and calls the
    # find_highway_to_accident_percentage method.
    # Parameters: none.
    # Return: none.
    def accidents_percentage_ranking
        @ALL_HIGHWAYS = Highway.all
        assert_object_is_not_null ( @ALL_HIGHWAYS )
        # Count the accidents
        @ACCIDENT_COUNT = Accident.new.total_accidents
        assert_object_is_not_null ( @ACCIDENT_COUNT )
        # Order the accidents
        find_highway_to_accident_percentage
    end

    # Description: Calculates the percentage of accidents based on the accidents
    # number on a given highway and the total of accidents registered.
    # Parameters: accidents_number, total_accidents.
    # Return: rate.
    def calculate_accidents_rate_percentage ( accidents_number, total_accidents )
        assert_object_is_not_null ( accidents_number )
        assert_object_is_not_null ( total_accidents )
        zero_acidentes = 0

        if ( accidents_number == zero_acidentes )
            rate = 0.0
        else
            total = total_accidents.to_s
            percentage = 100
            rate =  ( accidents_number / total.to_f ) * percentage
        end

        return rate
    end

    # Description: Saves all the highways on the database in a variable and
    # calls the find_highway_to_accident method.
    # Parameters: none.
    # Return: none.
    def accidents_ranking
        @HIGHWAYS = Highway.all
        assert_object_is_not_null ( @HIGHWAYS )
        find_highway_to_accident
    end

    private

    # Description: Saves the accidents percentage rate of a highway in its
    # respective highway object, provided there was at least one accident there.
    # Parameters: none.
    # Return: none.
    def find_highway_to_accident_percentage
        order_accidents_by_accidents_rate_percentage
        count_accidents_by_highway

        @ACCIDENT.each do |br, count|
            br_accident = br
            @ALL_HIGHWAYS.each do |highway|
                mileage_br = highway.mileage.to_s
                if ( highway.idBr == br_accident )
                    highway.accidents_rate_percentage =
                    calculate_accidents_rate_percentage( count,@ACCIDENT_COUNT )
                    highway.save
                else
                    # Nothing to do.
                end
            end
        end
    end

    # Description: Saves all the highways in the database ordered by their
    # accident rates in a variable.
    # Parameters: none.
    # Return: highways_by_accidents_rate
    def order_accidents_by_accidents_rate_percentage
        highways_by_accidents_rate =
        Highway.all_highways_by_accidents_rate_percentage
        assert_object_is_not_null ( highways_by_accidents_rate )

        return highways_by_accidents_rate
    end

    # Description: Saves the position of a highway in a ranking, based on their
    # accident rates.
    # Parameters: none.
    # Return: none.
    def create_position
        iterator_position_current = 0
        sum_iterator_position = 1

        @HIGHWAY.each do |highway|
            iterator_position_current += sum_iterator_position
            highway.rankingPosition = iterator_position_current
            highway.save
        end
    end

    # Description: Saves the accidents rate of a highway in its respective
    # highway object, provided there was an accident there.
    # Parameters: none.
    # Return: none.
    def find_highway_to_accident
        order_accidents_by_accidents_rate
        count_accidents_by_highway

        @ACCIDENT.each do |br, count|
            # The acronym 'br' represents a Brazilian highway that is the
            # federal government's responsibility.
            br_accident = br
            assert_object_is_not_null ( br_accident )
            @HIGHWAYS.each do |highway|
                assert_object_is_not_null ( highway )
                mileage_br = highway.mileage.to_s
                if ( highway.idBr == br_accident )
                    highway.accidents_rate = calculate_accidents_rate( count,
                    mileage_br)
                    highway.save
                else
                    # Nothing to do.
                end
            end
        end
    end

    # Description: Orders the highways by their accident rates in reverse order
    # (higher accident rates first), saves them in the @HIGHWAY variable and
    # calls the create_position method to rank them.
    # Parameters: none.
    # Return: none.
    def order_accidents_by_accidents_rate
        @HIGHWAY = Highway.all_highways_by_accidents_rate
        assert_object_is_not_null ( @HIGHWAY )
        create_position
    end
end
