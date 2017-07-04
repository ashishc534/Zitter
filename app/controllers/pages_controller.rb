class PagesController < ApplicationController
  def index
    if !user_session
      redirect_to root_path
    else
    end
  end

  def home
  end

  def profile

  	if (User.find_by_username(params[:id]))
  		@username = params[:id]
  	else
  		redirect_to root_path, :notice=> "Oh_Crap!! User Not found"
  	end

  end

  def explore
  end
end
