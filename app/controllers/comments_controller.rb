class CommentsController < ApplicationController
	
	def new
		@comment = Comment.new
		@comment.post_id = params[:tweet_id]
		@comment.user_id = current_user.id
		@comment.content = params[:content]
		
		if(@comment.save)
			respond_to do|format|
				format.html{redirect_to request.referer}
				format.js{@comments = Post.find_by_id(tweet_id).comments}
			end
		end
	end

	def comment
		@tweet = Post.find_by_id(params[:tweet_id])
		@comments = @tweet.comments
	end
end
