class AddStatusRefToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :status
  end
end
