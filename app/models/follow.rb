class Follow < ActiveRecord::Base
  attr_accessible :follower_id, :user_id

  #define the relationship
  belongs_to :user
  belongs_to :follower, :class_name => 'User'

end
