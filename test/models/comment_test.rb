require 'test_helper'

class CommentTest < ActiveSupport::TestCase

	  def setup
				@comment = Comment.new
		end

		test "test_comment" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:one).text
				assert @comment.save, "Cannot be null"
		end

		test "test_presenceOf_comments" do
				@comment.idBr = comments(:two).idBr
				@comment.title = comments(:two).title
				@comment.text = comments(:two).text
				assert_not @comment.save, "Cannot be null"
		end

		test "test_presenceOf_idBr" do
				@comment.idBr = comments(:two).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:one).text
				assert_not @comment.save, "Cannot be null"
		end

		test "test_presenceOf_title" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:two).title
				@comment.text = comments(:one).text
				assert_not @comment.save, "Cannot be null"
		end

		test "test_presenceOf_text" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:two).text
				assert_not @comment.save, "Cannot be null"
		end

		test "Checking if idBr is empty" do
				@comment.idBr = comments(:three).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:one).text
				assert_not @comment.save, "Cannot be invalid"
		end

		test "Checking if title is empty" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:three).title
				@comment.text = comments(:one).text
				assert_not @comment.save, "Cannot be invalid"
		end

		test "Checking if text is empty" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:three).text
				assert_not @comment.save, "Cannot be invalid"
		end

		test "Checking if the comments are in reverse order" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = comments(:one).text
				@comment.save!
				@comment_reverse = Comment.getComments
				assert_equal comments(:one).idBr, @comment_reverse.first.idBr, "The comments are not in reverse order"
		end

		test "get comments on reverse order" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = "first comment"
				@comment.save!

				@comment_2 = Comment.new
				@comment_2.idBr = comments(:one).idBr
				@comment_2.title = comments(:one).title
				@comment_2.text = "second comment"
				@comment_2.save!

				expected_text = "second comment"
				@comments_reverse = Comment.getComments
				assert_equal @comments_reverse.first.text,expected_text
		end

		test "check if comments are in reverse order" do
				@comment.idBr = comments(:one).idBr
				@comment.title = comments(:one).title
				@comment.text = "first comment"
				@comment.save!

				@comment_2 = Comment.new
				@comment_2.idBr = comments(:one).idBr
				@comment_2.title = comments(:one).title
				@comment_2.text = "second comment"
				@comment_2.save!

				expected_text = "first comment"
				@comments_reverse = Comment.getComments
				assert_not_equal @comments_reverse.first.text,expected_text
		end
end
