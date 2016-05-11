class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.decimal :account_balance, precision: 15, scale: 2

      t.timestamps
    end
  end
end
