class RemoveZipcodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :zipcode, :integer
  end
end
