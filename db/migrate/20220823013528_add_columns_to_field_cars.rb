class AddColumnsToFieldCars < ActiveRecord::Migration[6.1]
  def change
    add_column :field_cars, :driver_worker_id, :integer
    add_column :field_cars, :driver_address, :string
    add_column :field_cars, :driver_birth_day_on, :date
  end
end
