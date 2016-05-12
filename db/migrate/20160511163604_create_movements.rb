class CreateMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :movements do |t|
      t.decimal :ammount, precision: 15, scale: 2

      t.references :order
      t.belongs_to :client, foreign_key: true
      t.timestamps
    end
  end
end
