class RemoveItemIdFromOrderPhotos < ActiveRecord::Migration
  def change
    remove_column :order_photos, :item_id, :integer
  end
end
