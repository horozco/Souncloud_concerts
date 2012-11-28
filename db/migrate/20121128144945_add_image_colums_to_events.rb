class AddImageColumsToEvents < ActiveRecord::Migration
   def self.up
    add_attachment :events, :event_image
  end

  def self.down
    remove_attachment :events, :event_image
  end
end
