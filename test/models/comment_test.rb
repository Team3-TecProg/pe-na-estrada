require 'test_helper'

class CommentTest < ActiveSupport::TestCase

	  def setup
				@COMMENT = Comment.new
		end

		test "test_comment" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:one).text
				assert @COMMENT.save, "Cannot be null"
		end

		test "test_presenceOf_comments" do
				@COMMENT.idBr = comments(:two).idBr
				@COMMENT.title = comments(:two).title
				@COMMENT.text = comments(:two).text
				assert_not @COMMENT.save, "Cannot be null"
		end

		test "test_presenceOf_idBr" do
				@COMMENT.idBr = comments(:two).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:one).text
				assert_not @COMMENT.save, "Cannot be null"
		end

		test "test_presenceOf_title" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:two).title
				@COMMENT.text = comments(:one).text
				assert_not @COMMENT.save, "Cannot be null"
		end

		test "test_presenceOf_text" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:two).text
				assert_not @COMMENT.save, "Cannot be null"
		end

		test "Checking if idBr is empty" do
				@COMMENT.idBr = comments(:three).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:one).text
				assert_not @COMMENT.save, "Cannot be invalid"
		end

		test "Checking if title is empty" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:three).title
				@COMMENT.text = comments(:one).text
				assert_not @COMMENT.save, "Cannot be invalid"
		end

		test "Checking if text is empty" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:three).text
				assert_not @COMMENT.save, "Cannot be invalid"
		end

		test "Checking if the comments are in reverse order" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = comments(:one).text
				@COMMENT.save!
				@COMMENT_reverse = Comment.getComments
				assert_equal comments(:one).idBr, @COMMENT_reverse.first.idBr, "The comments are not in reverse order"
		end

		test "get comments on reverse order" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = "first comment"
				@COMMENT.save!

				@COMMENT_2 = Comment.new
				@COMMENT_2.idBr = comments(:one).idBr
				@COMMENT_2.title = comments(:one).title
				@COMMENT_2.text = "second comment"
				@COMMENT_2.save!

				expected_text = "second comment"
				@COMMENTS_REVERSE = Comment.getComments
				assert_equal @COMMENTS_REVERSE.first.text,expected_text
		end

		test "check if comments are in reverse order" do
				@COMMENT.idBr = comments(:one).idBr
				@COMMENT.title = comments(:one).title
				@COMMENT.text = "first comment"
				@COMMENT.save!

				@COMMENT_2 = Comment.new
				@COMMENT_2.idBr = comments(:one).idBr
				@COMMENT_2.title = comments(:one).title
				@COMMENT_2.text = "second comment"
				@COMMENT_2.save!

				expected_text = "first comment"
				@COMMENTS_REVERSE = Comment.getComments
				assert_not_equal @COMMENTS_REVERSE.first.text,expected_text
		end
end
