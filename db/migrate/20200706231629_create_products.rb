class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :item_info, null: false
      t.string :brand
      t.integer :status_id, null: false
      t.string :size
      t.integer :delivery_id, null: false
      t.integer :region_id, null: false
      t.integer :day_id, null: false
      t.integer :price, null: false
      # t.integer :category_id, null: false, foreign_key: true
      # t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
