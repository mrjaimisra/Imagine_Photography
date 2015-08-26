class RemoveStreetNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :street_name, :string
  end
end
