class DropPhotographersTable < ActiveRecord::Migration
  def up
    drop_table :photographers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
