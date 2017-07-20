class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  validates :user_id , presence: true
  validates :content , presence: true, length: {maximum: 140}
  default_scope  { order(:created_at => :desc) }

  def like_string user_id
    if Like.where(post_id: id, user_id: user_id).length > 0
  
      return "UnLike"
    else
      return "Like"
    end

  end
end
