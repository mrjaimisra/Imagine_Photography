class CreatePhotographers < ActiveRecord::Migration
  def change
    create_table :photographers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
