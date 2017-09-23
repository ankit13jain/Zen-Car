class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :license_no
      t.string :manufacturer
      t.float :hourly_rate
      t.string :model
      t.string :location

      t.timestamps
    end
  end
end
