class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.decimal :unit_price, precision: 15, scale: 2
      t.integer :quantity, default: 1

      t.belongs_to :product, :order, foreign_key: true
      t.timestamps
    end
  end
end
