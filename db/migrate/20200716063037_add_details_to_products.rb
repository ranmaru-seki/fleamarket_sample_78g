class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :purchase_id, :integer
  end
end
