class AddTrackpointNumToTrackpoints < ActiveRecord::Migration[5.1]
  def change
    add_column :trackpoints, :trackpoint_num, :integer
  end
end
