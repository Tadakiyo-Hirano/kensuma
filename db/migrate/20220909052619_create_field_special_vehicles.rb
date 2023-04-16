class CreateFieldSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :field_special_vehicles do |t|
      t.string :uuid, null: false
      t.integer :driver_worker_id
      t.string :driver_name
      t.json :driver_licenses
      t.integer :sub_driver_worker_id
      t.string :sub_driver_name
      t.json :sub_driver_licenses
      t.string :vehicle_name, null: false
      t.json :content, null: false
      t.string :carry_on_company_name
      t.string :use_company_name
      t.date :carry_on_date
      t.date :carry_out_date
      t.string :use_place
      t.integer :lease_type
      t.string :contact_prevention
      t.string :precautions
      t.references :field_special_vehicleable, polymorphic: true
      
      t.timestamps
    end
  end
end
