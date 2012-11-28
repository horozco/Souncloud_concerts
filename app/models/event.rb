class Event < ActiveRecord::Base
  attr_accessible :artist_name, :date, :full_description, :price, :time,
                  :artist_track, :track, :event_image

  validates_presence_of :artist_track, :date, :full_description, :time

  belongs_to :user

  has_attached_file :event_image, :styles => { :medium => "400x400>", :thumb => "100x100>" },
            :url => "/assets/events/:id/:style/:basename.:extension",
            :path => ":rails_root/public/assets/events/:id/:style/:basename.:extension"
  validates_attachment :event_image,
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"]  },
  :size => { :less_than => 5.megabytes }

end
