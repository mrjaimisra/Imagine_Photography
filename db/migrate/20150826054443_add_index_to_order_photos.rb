class AddIndexToOrderPhotos < ActiveRecord::Migration
  def change
    add_column :order_photos, :photo_id, :string
    add_index :order_photos, :photo_id, using: :btree
  end
end
