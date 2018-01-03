class AddForeighKeyRelationships < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :waypoints, :hikes
    add_foreign_key :points, :hikes
    add_foreign_key :trackpoints, :hikes 
  end
end
