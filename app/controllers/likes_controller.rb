class LikesController < ApplicationController
	def toggle_like
		@tweet = Post.find(params[:tweet_id])
		like = Like.where(user: current_user, post: @tweet).first
		if like
			like.destroy!
			@is_liked = false	
		else
			Like.create(user: current_user, post: @tweet)
			@is_liked = true
		end

		respond_to do |format|
			format.js {}
		end
	end
end
