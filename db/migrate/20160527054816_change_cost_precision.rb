class ChangeCostPrecision < ActiveRecord::Migration
  def change
    change_column :items, :cost, :decimal, precision: 6, scale: 2
  end
end