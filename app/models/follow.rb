class Follow < ActiveRecord::Base
  attr_accessible :follower_id, :user_id

  #define the relationship
  belongs_to :user
  belongs_to :follower, :class_name => 'User'
  #Un usuario no puede seguir a otro usuario varias veces
  validates_uniqueness_of :follower_id, :scope => :user_id

end
