class AddStoreTypeToRoads < ActiveRecord::Migration
  def change
    add_column :roads, :store_type, :integer
  end
end