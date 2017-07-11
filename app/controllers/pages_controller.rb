class PagesController < ApplicationController
  def index
    # if !user_session
    #   redirect_to root_path
    # else
    # end
  end

  def home
    if user_signed_in? 
     
     if current_user.profile_picture
        @posts = Post.all
        @newPost = Post.new
     else
      current_user.profile_picture = 'default.jpg'
        @posts = Post.all
        @newPost = Post.new
      end
     
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

  def upload_image
  end

  def upload_image_submit
    uploaded_file = params[:image]
    filename = SecureRandom.hex + "." +uploaded_file.original_filename.split('.')[1]
    filepath = Dir.pwd + "/public/uploads/" + filename
    
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
  end

  current_user.profile_picture = filename
  current_user.save!
     redirect_to home_path 
  end

end
