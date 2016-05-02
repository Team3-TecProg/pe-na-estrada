######################################################################
# Class name: CommentsController
# File name: comments_controller.rb
# Description: Controller used to communicate with the view highways/show
######################################################################

class CommentsController < ApplicationController
    def index
        @comment = Comment.new
    end

    #Generates an object of the Highway model and saves it in the @highway variable
    def create
        # Get the highway that will receive the comment
        @highway = Highway.find( params[ :highway_id ] )
        @comment = Comment.new( comment_params )
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
