class CreatePoints < ActiveRecord::Migration[5.1]
  def change
    create_table :points do |t|
      t.integer :trip_id
      t.float :lat
      t.float :lng
      t.string :description

      t.timestamps
    end
  end
end
