class AddCulumnSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :special_vehicles, :personal_insurance_unlimited, :integer
    add_column :special_vehicles, :objective_insurance_unlimited, :integer
    add_column :special_vehicles, :passenger_insurance_unlimited, :integer
    add_column :special_vehicles, :other_insurance_unlimited, :integer
  end
end
