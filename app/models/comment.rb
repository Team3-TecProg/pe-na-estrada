######################################################################
# Class name: Comment
# File name: comment.rb
# Description: Represents all comments in application
######################################################################

class Comment < ActiveRecord::Base
    extend Assertions

    belongs_to :highway
    #Contais the title of the comment.
  	validates_presence_of :title
    #Contais the text of the comment.
  	validates_presence_of :text
    #Contais the id of the comment.
  	validates_presence_of :idBr

    public

    # Description: Returns comments about the accidents.
    # Parameters: none.
    # Return : all_coments_in_reverse_order
  	def self.get_comments_in_reverse_order
        # Take all comments in reverse order.
  		all_coments_in_reverse_order = Comment.all.reverse_order
        assert_object_is_not_null( all_coments_in_reverse_order )

        return all_coments_in_reverse_order
  	end

end
