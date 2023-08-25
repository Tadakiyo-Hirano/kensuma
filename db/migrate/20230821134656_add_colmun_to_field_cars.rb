class AddColmunToFieldCars < ActiveRecord::Migration[6.1]
  def change
    add_column :field_cars, :driver_licences, :json
    add_column :field_cars, :driver_licence_number, :string
  end
end
