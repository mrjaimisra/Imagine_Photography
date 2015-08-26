class AddStoreIdToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :store, index: true, foreign_key: true
  end
end
