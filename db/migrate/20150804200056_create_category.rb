class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
  end

  def change
    add_reference :items, :category
  end
end
