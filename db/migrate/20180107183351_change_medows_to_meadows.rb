class ChangeMedowsToMeadows < ActiveRecord::Migration[5.1]
  def change
    rename_column :hikes, :medows, :meadows  
  end
end
