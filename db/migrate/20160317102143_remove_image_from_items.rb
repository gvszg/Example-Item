class RemoveImageFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :image
  end
end