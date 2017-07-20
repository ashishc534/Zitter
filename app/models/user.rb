class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def Can_follow id,current_user_id
  	return !(id === current_user_id)
  end

  def already_following id,current_user_id
    Relationship.where(follower_id:current_user_id,followee_id:id).count >0
  end
  
  has_many :posts, dependent: :destroy 
  has_many :active_relationships,class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships,class_name: "Relationship",foreign_key: "followee_id", dependent: :destroy
  has_many :likes
  validates_length_of :username , :maximum=>15 

end
