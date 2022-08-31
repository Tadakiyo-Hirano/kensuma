class AddColumnsToRequestOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :request_orders, :content, :json
  end
end
