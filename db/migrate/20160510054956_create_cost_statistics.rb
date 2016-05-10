class CreateCostStatistics < ActiveRecord::Migration
  def change
    create_table :cost_statistics do |t|
      t.integer :cost_of_goods, :cost_of_advertising, :cost_of_freight_in
      t.timestamps null: false
    end
  end
end