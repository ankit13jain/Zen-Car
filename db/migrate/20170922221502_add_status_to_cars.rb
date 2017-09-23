class AddStatusToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :status, :string
    add_column :cars, :style, :string
  end
end
