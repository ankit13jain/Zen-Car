class AddNameToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :name, :string
  end
end
