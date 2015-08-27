class ChangeItemsToPhotos < ActiveRecord::Migration
  def change
    rename_table :items, :photos
  end
end
