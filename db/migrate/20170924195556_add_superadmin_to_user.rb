class AddSuperadminToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :superadmin, :boolean, default: false
  end
end
