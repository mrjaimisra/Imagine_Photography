class RenameOrderItemsToOrderPhotos < ActiveRecord::Migration
  def change
    rename_table :order_items, :order_photos
  end
end
