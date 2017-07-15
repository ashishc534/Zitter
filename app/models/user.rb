class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def Can_follow id,current_user_id
  	return !(id === current_user_id)
  end

  has_many :posts, dependent: :destroy 
  validates_length_of :username , :maximum=>15 ,:message=>"Username Should be less than %d characters."	

end
