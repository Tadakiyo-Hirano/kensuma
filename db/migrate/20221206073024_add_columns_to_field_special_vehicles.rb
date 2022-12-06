class AddColumnsToFieldSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :field_special_vehicles, :sub_driver_worker_id, :integer
    add_column :field_special_vehicles, :sub_driver_name, :string
    add_column :field_special_vehicles, :sub_driver_license, :string
  end
end
