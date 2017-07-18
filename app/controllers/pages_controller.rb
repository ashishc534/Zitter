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
            current_user.profile_picture = '/default.jpg'
            @feed = Post.all
            @post = Post.new
          end
          @whotofollow = User.first(10)
        current_user.save!
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

      if(params[:search])
        params[:id] = params[:search]
      end

      format.html{
      	if (User.find_by_username(params[:id]))
      		@username = params[:id]
          @feed = Post.all.where(user_id:User.find_by_username(params[:id]).id)
          @whotofollow = User.first(10)
          
      	else
      		redirect_to root_path, :notice=> "Oh_Crap!! User Not found"
      	end
      }
      format.js{
        @feed = Post.all.where(user_id:User.find_by_username(params[:id]).id)
        @feed = Post.all.where(user_id:User.find_by_username(params[:search]).id)
      }
  end
end
  
  def explore
    @feed = Post.all.order(created_at: :desc)
    @users = User.all.where("id!=?",current_user.id)
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

  def upload_cover_image
    
  end

  def upload_cover_image_submit
    uploaded_file = params[:image]
    filename = SecureRandom.hex + "." +uploaded_file.original_filename.split('.')[1]
    filepath = Dir.pwd + "/public/uploads/" + filename
    
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
  end

  current_user.cover_image = filename
  current_user.save!
     redirect_to home_path
  end

  def relation
    followee_id = params[:followee_id]
    follow = Relationship.where(followee_id: followee_id , follower_id: current_user.id).first

    unless follow 
      follow = Relationship.new
      follow.followee_id = followee_id
      follow.follower_id = current_user.id
      follow.save
    else
      follow.destroy
    end
    redirect_to request.referrer
  end

  def followers

    respond_to do|format|
      format.html{
            # @feed = []
            # followee_id = User.find_by_username(params[:id]).passive_relationships.pluck(:follower_id)
            # followee_id.each do|followee_id|
            #   @feed <<  Post.find_by(user_id:followee_id)
            # end
            # @feed.sort!{|a,b| b.created_at <=> a.created_at}
            # @username = params[:id]
          }
      end
  end

  def following
   respond_to do|format|
      format.html{

        @followers = User.find_by_username(params[:id]).active_relationships.pluck(:followee_id)
        @username = params[:id]
            # @feed = []
            # follower_id = User.find_by_username(params[:id]).active_relationships.pluck(:followee_id)
            # follower_id.each do|follower_id|
            #   @feed <<  Post.order(created_at: :desc).find_by(user_id:follower_id)
            # end
            # @feed.sort!{|a,b| b.created_at <=> a.created_at}
            # @username = params[:id]
        }
      end
    end
end
