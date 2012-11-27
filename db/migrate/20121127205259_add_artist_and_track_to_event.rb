class AddArtistAndTrackToEvent < ActiveRecord::Migration
  def change
    add_column :events, :artist_track, :string
    add_index :events, :artist_track
    add_column :events, :track, :string
    add_index :events, :track
  end
end
