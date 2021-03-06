class PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id  #Assign the post to the user_id who created it
		respond_to do |f|
			if(@post.save)
				f.html{ redirect_to ""}
				f.js { }
			else
				f.html{ redirect_to "",notice:"Error: Post not Saved"}
			end
		end
	end

	def delete
		id = params[:id]
		byebug
	end
	private
	def post_params #allows certain data to be passed via form.. (Strong Parameters)
		params.require(:post).permit(:user_id,:content)
	end
end