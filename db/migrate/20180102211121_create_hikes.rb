class CreateHikes < ActiveRecord::Migration[5.1]
  def change
    create_table :hikes do |t|
      t.string :name
      t.float :start_lat
      t.float :start_lng
      t.string :region
      t.string :description
      t.string :notes
      t.date :start_date
      t.date :end_date
      t.float :num_days
      t.float :miles
      t.float :elevation_gain
      t.float :max_elevation
      t.boolean :coast
      t.boolean :rivers
      t.boolean :lakes
      t.boolean :waterfalls
      t.float :old_growth
      t.boolean :fall_foliage
      t.boolean :wildflowers
      t.boolean :medows
      t.boolean :mountain_views
      t.boolean :summits
      t.boolean :established_campsites
      t.boolean :day_hike
      t.boolean :overnight

      t.timestamps
    end
  end
end
