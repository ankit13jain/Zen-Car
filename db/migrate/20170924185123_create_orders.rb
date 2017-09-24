class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :checked_out_at
      t.datetime :reserved_at
      t.datetime :returned_at
      t.references :car, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :status
      t.float :total_charges

      t.timestamps
    end
  end
end
