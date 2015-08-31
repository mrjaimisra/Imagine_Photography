class AddAttachmentHeaderToStores < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.attachment :header
    end
  end

  def self.down
    remove_attachment :stores, :header
  end
end
