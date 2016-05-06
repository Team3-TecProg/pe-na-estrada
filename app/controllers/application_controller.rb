#####################################################################
# Class name: ApplicationController
# File name: application_controller.rb
# Description: Default parent controller, all others controllers
# inherit it
#####################################################################

class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def assert_error_null
    end

    def assert_error_type_of_object
    end

    # Assertion methods
    def assert_object_is_not_null( object )
        if( not object.nil? )
            # Object is not null, nothing to do
        else
            redirect_to assert_error_null_path
        end
    end

    def assert_type_of_object( type_is_correct )
        if( type_is_correct )
            # Object has the expected type, nothing to do
        else
            redirect_to assert_error_type_of_object_path
        end
    end
end
