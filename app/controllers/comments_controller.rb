#####################################################################
# Class name: CommentsController.
# File name: comments_controller.rb.
# Description: Controller used to communicate with the view
# highways/show and the model comment.
#####################################################################

class CommentsController < ApplicationController

    # This method call the view class.
    # Return a comment.
    def index
        @COMMENT = Comment.new
    end

    # Generates an object of the Highway model and saves it in the global
    # variable @HIGHWAY.
    def create
        # Get the highway where the id will receive the comment.
        @highway = Highway.find( params[ :highway_id ] )
        # Assert if the new object  @HIGHWAY is null.
        assert_object_is_not_null( @highway )

        # @COMMENT is a global variable thats contains the comment sent in the
        # params from the view.
        @COMMENT = Comment.new( comment_params )
        # Assert if the new object @COMMENT is null.
        assert_object_is_not_null( @COMMENT )

        # If can save the comment, is saved and after redirected to 
        # highway_path in view.
        if ( @COMMENT.save )
            @COMMENT.save
            redirect_to highway_path( @highway )
        else
            # Nothing to do
        end
    end

    # Fetches the parameters required by a comment object
    def comment_params
        params.fetch( :COMMENT, { } ).permit( :title, :text, :idBr )
    end
end
