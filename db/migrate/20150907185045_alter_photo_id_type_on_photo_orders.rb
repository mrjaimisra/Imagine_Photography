class AlterPhotoIdTypeOnPhotoOrders < ActiveRecord::Migration
  def change
    change_column :order_photos, :photo_id,
                                 'integer USING CAST(photo_id AS integer)'
  end
end
