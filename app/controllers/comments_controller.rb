#####################################################################
# Class name: CommentsController
# File name: comments_controller.rb
# Description: Controller used to communicate with the view
# highways/show and the model comment.
#####################################################################

class CommentsController < ApplicationController

    # Description: This method calls the view class.
    # Parameters: none.
    # Return: @COMMENT.
    def index
        @COMMENT = Comment.new
        assert_object_is_not_null ( @COMMENT )
    end

    # Description: Generates an object of the Highway model and saves it in the 
    # instance variable @HIGHWAY.
    # Parameters: none.
    # Return: none.
    def create
        # Get the highway where the id will receive the comment.
        @HIGHWAY = Highway.find( params[ :highway_id ] )
        # Assert if the new object  @HIGHWAY is null.
        assert_object_is_not_null( @HIGHWAY )
        # @COMMENT is an instance variable thats contains the comment sent in 
        # the params from the view.
        @COMMENT = Comment.new( comment_params )
        # Asserts if the new object @COMMENT is null.
        assert_object_is_not_null( @COMMENT )

        # If can save the comment, is saved and after redirected to 
        # highway_path in view.
        if ( @COMMENT.save )
            @COMMENT.save
            redirect_to highway_path( @HIGHWAY )
        else
            # Nothing to do
        end
    end

    # Description: Fetches the parameters required by a comment object.
    # Parameters: none.
    # Return: none.
    def comment_params
        params.fetch( :comment, { } ).permit( :title, :text, :idBr )
    end
end
