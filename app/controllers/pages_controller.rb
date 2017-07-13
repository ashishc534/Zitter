class PagesController < ApplicationController
  def index
    # if !user_session
    #   redirect_to root_path
    # else
    # end
  end
  
  def home

    if user_signed_in?
      respond_to do |format|
        format.html{  
          if current_user.profile_picture
            @feed = Post.all
            @post = Post.new
          else
            current_user.profile_picture = 'default.jpg'
            @posts = Post.all
            @post = Post.new
          end
        
        }
        format.js{
          @feed = Post.all
        }
      end
    else
      redirect_to '/'
    end
  end

  def profile
    respond_to do |format|
      
      format.html{
      	if (User.find_by_username(params[:id]))
      		@post = Post.new
          @username = params[:id]
          @feed = Post.all.where(user_id:User.find_by_username(params[:id]).id)
          
      	else
      		redirect_to root_path, :notice=> "Oh_Crap!! User Not found"
      	end
        
      }
      format.js{
        @feed = Post.all.where(user_id:User.find_by_username(params[:id]).id)
      }
  end
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
