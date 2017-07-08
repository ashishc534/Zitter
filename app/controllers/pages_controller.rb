class PagesController < ApplicationController
  def index
    # if !user_session
    #   redirect_to root_path
    # else
    # end
  end

  def home
    if user_signed_in?
      @posts = Post.all
      @newPost = Post.new
    else
      redirect_to root_path
    end
  end

  def profile

  	if (User.find_by_username(params[:id]))
  		@username = params[:id]
  	else
  		redirect_to root_path, :notice=> "Oh_Crap!! User Not found"
  	end
    @posts = Post.all.where(user_id:User.find_by_username(params[:id]).id)
    @newPost = Post.new
  end

  def explore
    @posts = Post.all
  end
end
