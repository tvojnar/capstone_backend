class AddImageUrlToHikes < ActiveRecord::Migration[5.1]
  def change
    add_column :hikes, :image_url, :string
  end
end
