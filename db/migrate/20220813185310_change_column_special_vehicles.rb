class ChangeColumnSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    change_column :special_vehicles, :name, :string, null: false
    change_column :special_vehicles, :maker, :string, null: false
    change_column :special_vehicles, :standards_performance, :string, null: false
    change_column :special_vehicles, :year_manufactured, :date, null: false
    change_column :special_vehicles, :control_number, :string, null: false
  end
end
