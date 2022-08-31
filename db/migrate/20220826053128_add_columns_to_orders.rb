class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :content, :json
  end
end
