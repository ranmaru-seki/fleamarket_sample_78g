class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :for_family_name,      null: false
      t.string :for_first_name,       null: false
      t.string :for_family_name_kana, null: false
      t.string :for_first_name_kana,  null: false
      t.string :postcode,             null: false
      t.integer :region_id,           null: false
      t.string :city,                 null: false
      t.string :city_number,          null: false
      t.string :remarks
      t.string :phone_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
