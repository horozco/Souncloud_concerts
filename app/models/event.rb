class Event < ActiveRecord::Base
  attr_accessible :artist_name, :date, :full_description, :price, :time,
                  :artist_track, :track

  validates_presence_of :artist_track, :date, :full_description, :time

  belongs_to :user
end
