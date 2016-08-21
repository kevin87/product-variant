class CreateSellables < ActiveRecord::Migration
  def change
    create_table :sellables do |t|
      t.string :sku, :null => false
      t.string :description, :null => false
      t.decimal :price, :null => false
      t.integer :quantity, :null => false, :default => 0
      t.integer :item_id, :null => false
      t.string :item_type, :null => false
      t.boolean :active, :null => false, :default => false
      t.boolean :unlimited_inventory, :null => false, :default => false
    end
  end
end
