######################################################################
# Class name: Comment
# File name: comment.rb
# Description: Represents all comments in application
######################################################################

class Comment < ActiveRecord::Base

    belongs_to :Highway, :foreign_key => :idBr, class_name: 'Highway'
    #Contais the title of the comment.
  	validates_presence_of :title
    #Contais the text of the comment.
  	validates_presence_of :text
    #Contais the id of the comment.
  	validates_presence_of :idBr

    # Description: Returns comments about the accidents.
    # Parameters: none.
    # Return : all_coments_in_reverse_order
  	def self.getComments
        # Take all comments in reverse order.
  		  all_coments_in_reverse_order = all.reverse_order

        return all_coments_in_reverse_order
  	end

end
