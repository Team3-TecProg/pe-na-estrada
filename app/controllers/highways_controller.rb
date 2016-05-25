#####################################################################
# Class name: HighwaysController
# File name: highways_controller.rb
# Description: Controller used to communicate with the view
# highways/show and the model highway.
#####################################################################

class HighwaysController < ApplicationController

    # Description: Receives a highway informed by the user, checks
    # if it exists in the database, clean any ‘0’s on the left of its name, and
    # holds it in a variable.
    # Parameters: none.
    # Return: @highway.
    def index
        @highway_informed_by_user = params[ :highway_search ]
        assert_object_is_not_null ( @highway_informed_by_user )
        @highway_number_exists  = check_length_and_if_exists \
                                  ( @highway_informed_by_user )
        assert_object_is_not_null ( @highway_number_exists  )
        @highway = setup_highway  ( @highway_informed_by_user )
        assert_object_is_not_null ( @highway )
    end

    # Description: Shows a given Highway model object in its HTML view page.
    # Parameters: none.
    # Return: @highway and @comment.
    def show
        @highway = Highway.find ( params[:id] )
        @comment = Comment.new
        @comment = Comment.getComments
    end

    # Description: Set up the instance variable '@highway' on index with the
    # result from 'search_for_highway' method.
    # Parameters: highway.
    # Return: none or nil.
    def setup_highway ( highway )
        if ( highway )
            search_for_highway ( highway )
        else
            return nil
        end
    end

    # Description: Check the length of a highway informed and if it exists on
    # the database.
    # Parameters: highway_to_check
    # Return: none or false.
    def check_length_and_if_exists ( highway_to_check )
        assert_object_is_not_null ( highway_to_check )
        cleaned_highway_to_check = check_highway_number ( highway_to_check )
        assert_object_is_not_null ( cleaned_highway_to_check )
        valid_lenght =  check_highway_number_length ( cleaned_highway_to_check )

        if ( valid_lenght == true )
            check_highway_exists ( cleaned_highway_to_check )
        else
            return false
        end
    end

    # Description: Search for a highway on DB.
    # Parameters: highway_to_search.
    # Return: none.
    def search_for_highway ( highway_to_search )
        assert_object_is_not_null ( highway_to_search )
        highway_cleaned = check_highway_number ( highway_to_search )
        assert_object_is_not_null ( highway_cleaned )
        Highway.search_for_highway ( highway_cleaned )
    end

    # Description: Defines the maximum length permitted to a highway name.
    # Parameters: none.
    # Return: max_highway_number_length.
    def max_highway_number_length
      # In Brazil, there are no highways with numbers longer than 3 digitos.
      max_highway_number_length = 3
      return max_highway_number_length
    end

    # Description: Check the length of the highway number informed.
    # Parameters: highway_number.
    # Return: true or false.
    def check_highway_number_length ( highway_number )
        assert_object_is_not_null ( highway_number )
        if ( not highway_number.blank? )
            highway_number_length = highway_number.size
            if ( highway_number_length >  max_highway_number_length )
                return false
            else
                return true
            end
        else
            return false
        end
    end

    # Description: Check if a highway exists on DB.
    # Parameters: highway_to_check.
    # Return: true or false.
    def check_highway_exists ( highway_to_check )
        assert_object_is_not_null ( highway_to_check )
        if ( Highway.exists_highway ( highway_to_check ) )
            return true
        else
            return false
        end
    end

    # Description: Ignore '0's on left on highway number.
    # Parameters: highway_number.
    # Return: highway_number.
    def check_highway_number ( highway_number )
        assert_object_is_not_null ( highway_number )
        if ( not highway_number.blank? )
            array_index = 0
            iterator_array_sum = 1;
            while highway_number.at( array_index ) == "0"
                highway_number = highway_number.from ( array_index + iterator_array_sum )
            end

            return highway_number
        else
            return highway_number
        end
    end

    # Description: Saves the amount of Accident model objects in an @accident
    # variable.
    # Parameters: none.
    # Return: @accident.
    def count_accidents_by_highway
        @accident = Accident.count_accidents
        assert_object_is_not_null ( @accident )
        return @accident
    end

    # Description: Order the highways by their accident rates in rev Paerse order
    # (higher accident rates first), saves them in the @highway variable and
    # calls the create_position method to rank them.
    # Parameters: none.
    # Return: @highway
    def order_accidents_by_accidents_rate
        @highway = Highway.all_highways_by_accidents_rate
        assert_object_is_not_null ( @highway )
        create_position
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

    # Description: Saves the accidents rate of a highway in its respective
    # highway object, provided there was an accident there.
    # Parameters: none.
    # Return: none.
    def find_highway_to_accident
        order_accidents_by_accidents_rate
        count_accidents_by_highway

        # The acronyme 'br' represents a Brazilian highway that is the federal
        # government's responsibility.
        br_accident = nil
        count_accident = nil
        mileage_br = nil

        @accident.each do |br, count|
            br_accident = br
            assert_object_is_not_null ( br_accident )
            @highways.each do |highway|
                assert_object_is_not_null ( highway )
                mileage_br = highway.mileage.to_s
                if ( highway.idBr == br_accident )
                    highway.accidents_rate = calculate_accidents_rate count, mileage_br
                    highway.save
                else
                    # Nothing to do.
                end
            end
        end
    end

    # Description: Saves the position of a highway in a ranking, based on their
    # accident rates.
    # Parameters: none.
    # Return: none.
    def create_position
        iterator_position_current = 0
        sum_iterator_position = 1
        @highway.each do |highway|
            iterator_position_current = iterator_position_current + sum_iterator_position
            highway.rankingPosition = iterator_position_current
            highway.save
        end
    end


    # Description: Saves all the highways on the database in a variable and
    # calls the find_highway_to_accident method.
    # Parameters: none.
    # Return: none.
    def accidents_ranking
        @highways = Highway.all
        assert_object_is_not_null ( @highways )
        find_highway_to_accident
    end

    # Description: Calculates the percentage of accidents based on the accidents
    # number on a given highway and the total of accidents registered.
    # Parameters: accidents_number, total accidents.
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

    # Description: Saves all the highways in the database ordered by their
    # accident rates in a variable.
    # Parameters: none.
    # Return: @highways_by_accidents_rate
    def order_accidents_by_accidents_rate_percentage
        @highways_by_accidents_rate = Highway.all_highways_by_accidents_rate_percentage
        assert_object_is_not_null ( @highways_by_accidents_rate )
    end

    # Description: Saves all the highways from the database in a variable,
    # all the accidents from the database in another variable, and calls the
    # find_highway_to_accident_percentage method.
    # Parameters: none.
    # Return: none.

    def accidents_percentage_ranking
        @all_highways = Highway.all
        assert_object_is_not_null ( @all_highways )
        # Count the accidents
        @accidents_count = Accident.total_accidents
        assert_object_is_not_null ( @accidents_count )
        # Order the accidents
        find_highway_to_accident_percentage
    end

    # Description: Saves the accidents percentage rate of a highway in its
    # respective highway object, provided there was at least one accident there.
    # Parameters: none.
    # Return: none.
    def find_highway_to_accident_percentage
        br_accident = nil
        count_accident = nil
        mileage_br = nil

        order_accidents_by_accidents_rate_percentage
        count_accidents_by_highway

        @accident.each do |br, count|
            br_accident = br
            @all_highways.each do |highway|
                mileage_br = highway.mileage.to_s
                if ( highway.idBr == br_accident )
                    highway.accidents_rate_percentage = calculate_accidents_rate_percentage( count, @accidents_count )
                    highway.save
                end
            end
        end
    end

end
