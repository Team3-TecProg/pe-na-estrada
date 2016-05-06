#####################################################################
# Class name: CommentsController
# File name: comments_controller.rb
# Description: Controller used to communicate with the view
# highways/show and the model comment.
#####################################################################

class CommentsController < ApplicationController

    # This method calls the view class.
    # Returns a comment.
    def index
        @comment = Comment.new
        assert_object_is_not_null ( )
    end

    # Generates an object of the Highway model and saves it in the instance
    # variable @highway.
    def create
        # Get the highway where the id will receive the comment.
        @highway = Highway.find( params[ :highway_id ] )
        # Assert if the new object  @HIGHWAY is null.
        assert_object_is_not_null( @highway )
        # @comment is an instance variable thats contains the comment sent in 
        # the params from the view.
        @comment = Comment.new( comment_params )
        # Asserts if the new object @comment is null.
        assert_object_is_not_null( @comment )

        # If can save the comment, is saved and after redirected to 
        # highway_path in view.
        if ( @comment.save )
            @comment.save
            redirect_to highway_path( @highway )
        else
            # Nothing to do
        end
    end

    # Fetches the parameters required by a comment object
    def comment_params
        params.fetch( :comment, { } ).permit( :title, :text, :idBr )
    end
end
