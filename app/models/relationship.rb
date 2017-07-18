class Relationship < ActiveRecord::Base
  belongs_to :user ,dependent: :destroy
  belongs_to :post ,dependent: :destroy

  validates :follower_id, presence: true
  validates :followee_id, presence: true
  validates :follower_id, :uniqueness => { :scope => :followee_id }
  validates :followee_id, :uniqueness => { :scope => :follower_id }
end
