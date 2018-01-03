class ChangeTripIdToHikeId < ActiveRecord::Migration[5.1]
  def change
    remove_column :points, :trip_id
    add_column :points, :hike_id, :integer

    remove_column :trackpoints, :trip_id
    add_column :trackpoints, :hike_id, :integer

    remove_column :waypoints, :trip_id
    add_column :waypoints, :hike_id, :integer 
  end
end
