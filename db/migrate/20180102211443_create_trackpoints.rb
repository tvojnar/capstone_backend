class CreateTrackpoints < ActiveRecord::Migration[5.1]
  def change
    create_table :trackpoints do |t|
      t.integer :trip_id
      t.integer :trackpoint_number
      t.float :lat
      t.float :lng
      t.float :elevation

      t.timestamps
    end
  end
end
