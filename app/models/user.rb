class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name

  has_many :events

  has_many :follows
  has_many :followers, :through => :follows
end