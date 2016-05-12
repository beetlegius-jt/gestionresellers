class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, :image_uid, :status
      t.text :description
      t.integer :package_quantity
      t.decimal :price, :package_price, precision: 15, scale: 2

      t.belongs_to :provider, foreign_key: true
      t.timestamps
    end
  end
end
