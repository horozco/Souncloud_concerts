class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :date
      t.string :time
      t.string :artist_name
      t.float :price
      t.text :full_description

      t.timestamps
    end
  end
end
