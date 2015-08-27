class AddDefaultValueToRole < ActiveRecord::Migration
  def change
    change_column_default :roles, :name, "registered_user"
    remove_index :roles, :name
    add_index :roles, :name, unique: true
  end
end
