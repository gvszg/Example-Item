class AddItemStyleToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :item_style, :string
  end
end