#####################################################################
# Class name: HighwaysController.
# File name: highways_controller.rb.
# Description: Controller used to communicate with the view
# highways/show and the model highway.
#####################################################################

class HighwaysController < ApplicationController

    # Receives a highway informed by the user, checks if it exists in
    # the database, clean any ‘0’s on the left of its name, and
    # holds it in a variable.
    def index
        @highway_informed_by_user = params[:highway_search]
        @highway_number_exists = check_length_and_if_exists  ( @highway_informed_by_user )
        @highway = setup_highway  ( @highway_informed_by_user )
    end

    # Set up the instance variable '@highway' on index with the
    # result from 'search_for_highway' method.
    def setup_highway ( highway )
        if ( highway )
            search_for_highway  ( highway )
        else
            return nil
        end
    end

    # Check the length of a highway informed and if it exists on DB.
    def check_length_and_if_exists ( highway_to_check )
        cleaned_highway_to_check = check_highway_number ( highway_to_check )
        length_is_ok =  check_highway_number_length  ( cleaned_highway_to_check )

        if ( length_is_ok )
            check_highway_exists  ( cleaned_highway_to_check )
        else
            return false
        end
    end

    # Search for a highway on DB.
    def search_for_highway ( highway_to_search )
        highway_cleaned = check_highway_number ( highway_to_search )
        Highway.search_for_highway ( highway_cleaned )
    end

    def max_highway_number_length
      # Represents the maximum length permitted to a highway name.
      max_highway_number_length = 3
      return max_highway_number_length
    end

    # Check the length of the highway number informed.
    def check_highway_number_length ( highway_number )
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

    # Check if a highway exists on DB.
    def check_highway_exists ( highway_to_check )
        if ( Highway.exists_highway ( highway_to_check ) )
            return true
        else
            return false
        end
    end

    # Ignore '0's on left on highway number.
    def check_highway_number ( highway_number )
        if ( not highway_number.blank? )
            array_index = 0

            while highway_number.at(array_index) == "0"
                highway_number = highway_number.from ( array_index + 1 )
            end

            return highway_number
        else
            return highway_number
        end
    end

    # Saves the amount of Accident model objects in an @accident
    # variable.
    def count_accidents_by_highway
        @accident = Accident.count_accidents
    end

    # Order the highways by their accident rates in reverse
    # order (higher accident rates first), saves them in
    # the @highway variable and calls the create_position
    # method to rank them.
    def order_accidents_by_accidents_rate
        @highway = Highway.all_highways_by_accidents_rate
        create_position
    end

    # Calculates the percentage of accidents based on the
    # accidents number on a hiven highway and the total
    # of accidents registered. Receives the accidents_number
    # and the total_accidents parameters.
    def calculate_accidents_rate ( accidents_number, mileage_highway )
        if ( mileage_highway.blank? )
            rate = 0.0
        else
            rate = accidents_number/mileage_highway.to_f
        end

        return rate
    end

    # Saves the accidents rate of a highway in its respective highway object,
    # provided there was an accident there.
    def find_highway_to_accident
        order_accidents_by_accidents_rate
        count_accidents_by_highway

        br_accident = nil
        count_accident = nil
        mileage_br = nil

        @accident.each do |br, count|
            br_accident = br
            @highways.each do |highway|
                mileage_br = highway.mileage.to_s
                if ( highway.idBr == br_accident )
                    highway.accidents_rate = calculate_accidents_rate( count, mileage_br )
                    highway.save
                else
                    # Nothing to do.
                end
            end
        end

    end

    # Saves the position of a highway in a ranking, based on their accident
    # rates.
    def create_position
        iterator_position_position = 0
        @highway.each do |highway|
            iterator_position = iterator_position + 1
            highway.ranking_position = iterator_position
            highway.save
        end
    end

    # Saves all the highways on the database in a variable and calls the
    # find_highway_to_accident method.
    def accidents_ranking
        @highways = Highway.all
        find_highway_to_accident
    end

    # Calculates the percentage of accidents based on the accidents number on a # hiven highway and the total of accidents registered.
    def calculate_accidents_rate_percentage ( accidents_number, total_accidents )
        if ( accidents_number == 0 )
            rate = 0.0
        else
            total = total_accidents.to_s
            rate =  ( accidents_number / total.to_f ) * 100
        end

        return rate
    end

    # Saves all the highways in the database ordered by their
    # accident rates in a variable.
    def order_accidents_by_accidents_rate_percentage
        @highways_by_accidents_rate = Highway.all_highways_by_accidents_rate_percentage
    end

    # Saves all the highways from the database in a variable,
    # all the accidents from the database in another variable,
    # and calls the find_highway_to_accident_percentage method.
    def accidents_percentage_ranking
        @all_highways = Highway.all
        #count the accidents
        @accidents_count = Accident.total_accidents
        #order the accidents
        find_highway_to_accident_percentage
    end

    # Saves the accidents percentage rate of a highway in
    # its respective highway object, provided there was
    # at least one accident there.
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
                    highway.accidents_rate_percentage = calculate_accidents_rate_percentage count, @accidents_count
                    highway.save
                end
            end
        end
    end

    # Shows a given Highway model object in its HTML view page.
    def show
        @highway = Highway.find ( params[:id] )
        @comment = Comment.new
        @comments = Comment.getComments
    end

end
