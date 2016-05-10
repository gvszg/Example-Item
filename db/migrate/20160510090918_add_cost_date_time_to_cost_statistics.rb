class AddCostDateTimeToCostStatistics < ActiveRecord::Migration
  def change
    add_column :cost_statistics, :cost_date, :date
    add_index :cost_statistics, :cost_date
  end
end