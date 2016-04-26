class AddStoreTypeToTowns < ActiveRecord::Migration
  def change
    add_column :towns, :store_type, :integer
  end
end