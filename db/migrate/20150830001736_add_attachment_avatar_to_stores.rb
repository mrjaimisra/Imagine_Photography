class AddAttachmentAvatarToStores < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :stores, :avatar
  end
end
