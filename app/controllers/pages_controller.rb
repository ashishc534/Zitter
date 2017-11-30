class PagesController < ApplicationController
  # def index
    # if !user_session
    #   redirect_to root_path
    # else
    # end
  # end
  
  def home

    if user_signed_in?
      respond_to do |format|
        format.html{  
          if current_user.profile_picture
          else
            current_user.profile_picture = '/default.jpg'
          end
          if !current_user.theme
            current_user.theme = "rgb(29, 161, 242)"
          end
          @feed = Post.all
          @post = Post.new 
          @trending = []
          @feed.each do|post|
            if post.likes.count > 1
              @trending << post
            end
          end
          current_user.save!
        }
        format.js{
            @feed = current_user.active_relationships.posts
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
          @feed = User.find_by_username(params[:id]).posts
          @whotofollow = User.first(10)
          
      	else
      		redirect_to root_path, :notice=> "User Not found"
      	end
      }
      format.js{
        @feed = User.find_by_username(params[:id]).posts
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

  def relation
    
    respond_to do|format|
      format.html{
        followee_id = params[:followee_id]
        follow = Relationship.where(followee_id: followee_id , follower_id: current_user.id).first

        unless follow 
          follow = Relationship.new
          follow.followee_id = followee_id
          follow.follower_id = current_user.id
          follow.save!
        else
          follow.destroy!
        end
        redirect_to request.referrer
      }
      format.js{}
    end
  end

  def followers

    respond_to do|format|
      format.html{
            @followers = User.find_by_username(params[:id]).passive_relationships.pluck(:follower_id)
            @username = params[:id]
            # @feed = []
            # followee_id = User.find_by_username(params[:id]).passive_relationships.pluck(:follower_id)
            # followee_id.each do|followee_id|
            #   @feed <<  Post.find_by(user_id:followee_id)
            # end
            # @feed.sort!{|a,b| b.created_at <=> a.created_at}
            # @username = params[:id]
          }
          format.js{}
      end
  end

  def following
   respond_to do|format|
      format.html{

        @following = User.find_by_username(params[:id]).active_relationships.pluck(:followee_id)
        @username = params[:id]
        @following.delete(current_user.id)
            # @feed = []
            # follower_id = User.find_by_username(params[:id]).active_relationships.pluck(:followee_id)
            # follower_id.each do|follower_id|
            #   @feed <<  Post.order(created_at: :desc).find_by(user_id:follower_id)
            # end
            # @feed.sort!{|a,b| b.created_at <=> a.created_at}
            # @username = params[:id]
        }
      format.js{}
      end
    end

    def likes
      respond_to do|format|
        format.html{
          @username = params[:id]
          @likes = User.find_by_username(params[:id]).likes
          @feed = []

          @likes.each do|like|
            post = Post.find_by_id(like.post_id)
            @feed<<post
          end

          @feed
        }
      end
    end

    def theme
    end

    def theme_submit
      colour = params[:colour]
      current_user.theme = colour
      current_user.save!
      redirect_to '/'
    end

    def developer
    end
end
