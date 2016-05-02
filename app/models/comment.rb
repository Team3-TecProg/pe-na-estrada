######################################################################
# Class name: CommentsModel
# File name: comment.rb
# Description: Represents all comments in application
######################################################################

class Comment < ActiveRecord::Base

    belongs_to :Highway #, :foreign_key => :idBr, class_name: 'Highway'
    #Contais the title of the comment.
  	validates_presence_of :title
    #Contais the text of the comment.
  	validates_presence_of :text
    #Contais the id of the comment.
  	validates_presence_of :idBr

    #Returns comments about the accidents.
  	def self.getComments
  		  all.reverse_order
  	end

end
