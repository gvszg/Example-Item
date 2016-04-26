class AddCitiidAndStoreTypeToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :cityid, :string
    add_column :counties, :store_type, :integer
  end
end