# db/migrate/20181227092237_add_quantity_to_products.rb
class AddQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :quantity, :integer, default: 0
  end
end
