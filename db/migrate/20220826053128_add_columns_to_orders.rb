class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :general_contractor_name, :string, null: :false
    add_column :orders, :health_insurance_status, :string, null: :false
    add_column :orders, :welfare_pension_insurance_join_status, :string, null: :false
    add_column :orders, :employment_insurance_join_status, :string, null: :false
  end
end
