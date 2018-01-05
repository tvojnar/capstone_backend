class ChangeOldgrowthToBoolean < ActiveRecord::Migration[5.1]
  def change
    remove_column :hikes, :old_growth
    add_column :hikes, :old_growth, :boolean 
  end
end
