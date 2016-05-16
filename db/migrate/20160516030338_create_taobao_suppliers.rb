class CreateTaobaoSuppliers < ActiveRecord::Migration
  def change
    create_table :taobao_suppliers do |t|
      t.string :name, :link
      t.timestamps null: false
    end
  end
end