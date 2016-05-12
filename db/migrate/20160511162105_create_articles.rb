class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :serial_number
      t.boolean :in_stock, default: true

      t.references :order
      t.belongs_to :product, foreign_key: true
      t.timestamps
    end
  end
end
