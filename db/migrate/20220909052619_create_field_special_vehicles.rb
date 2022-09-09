class CreateFieldSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :field_special_vehicles do |t|
      t.string :uuid, null: false
      t.integer :vehicle_type, null: false
      t.string :carry_on_company_name, null: false
      t.string :owning_company_name, null: false
      t.string :use_company_name, null: false
      t.date :carry_on_date, null: false
      t.date :carry_out_date, null: false
      t.string :use_place, null: false
      t.integer :lease_type, null: false
      t.string :precautions
      t.json :content
      t.references :field_special_vehicleable, polymorphic: true
      
      t.timestamps
    end
  end
end
