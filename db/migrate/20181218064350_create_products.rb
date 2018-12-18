# db/migrate/20181218064350_create_products.rb
class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.boolean :published
      t.integer :user_id

      t.timestamps
    end
    add_index :products, :user_id
  end
end
