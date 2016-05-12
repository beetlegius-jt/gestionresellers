class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.date :date

      t.belongs_to :client, :provider, foreign_key: true
      t.timestamps
    end
  end
end
