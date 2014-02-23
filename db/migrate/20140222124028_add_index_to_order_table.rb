class AddIndexToOrderTable < ActiveRecord::Migration
  def change
    add_index "orders", ["id"], :name => "index_orders_on_id", :unique => true
  end
end
