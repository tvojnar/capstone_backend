class CreateWaypoints < ActiveRecord::Migration[5.1]
  def change
    create_table :waypoints do |t|
      t.integer :trip_id
      t.float :lat
      t.float :lng
      t.datetime :time
      t.string :description

      t.timestamps
    end
  end
end
