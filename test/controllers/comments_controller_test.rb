require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @COMMENT = Comment.new
    @COMMENTS = Comment.all
    @highways = Highway.all
  end 

  test "route" do
    assert_recognizes({:controller => "highways", :action => "show", id:"40"}, {:path => "highways/40", :method => :get})
  end


  test "Not should comment nil" do 
    {:action=>"index", :COMMENT=>{:idBr=>comments(:two).idBr, :title=>comments(:two).title, :text=>comments(:two).text}, :controller=>"highways/"}
    assert_nil assigns(:COMMENT)
  end
  
end
