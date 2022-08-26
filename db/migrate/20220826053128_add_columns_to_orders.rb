class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :general_contractor_name, :string, null: :false
  end
end
