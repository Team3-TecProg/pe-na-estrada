######################################################################
# Class name: CommentsController.
# File name: comments_controller.rb.
# Description: Controller used to communicate with the view
# highways/show and the model comment.
######################################################################

class CommentsController < ApplicationController

    #This method returns a variable called '@route' that contains
    #a new object of the route.
    #This method is called from the view package to show the web
    #page to the user too.
    def index
        @comment = Comment.new
    end

    #Generates an object of the Highway model and saves it in the
    #@highway variable.
    def create
        # Get the highway that will receive the comment
        @highway = Highway.find( params[ :highway_id ] )
        assert_object_is_not_null( @highway )
        @comment = Comment.new( comment_params )
        assert_object_is_not_null( @comment )
        if ( @comment.save )
            @comment.save
            redirect_to highway_path( @highway )
        else
            # Nothing to do
        end
    end

    #Fetches the parameters required by a comment object
    def comment_params
        params.fetch( :comment, { } ).permit( :title, :text, :idBr )
    end
end
