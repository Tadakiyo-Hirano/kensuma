class CreateSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :special_vehicles do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :maker, null: false
      t.string :standards_performance, null: false
      t.string :owning_company_name, null: false
      t.integer :vehicle_type
      t.date :year_manufactured, null: false
      t.string :control_number, null: false
      t.date :check_exp_date_year, null: false
      t.date :check_exp_date_month, null: false
      t.date :check_exp_date_specific
      t.date :check_exp_date_machine, null: false
      t.date :check_exp_date_car, null: false
      t.date :exp_date_insurance
      t.integer :personal_insurance
      t.integer :objective_insurance
      t.integer :passenger_insurance
      t.integer :other_insurance
      t.json :periodic_self_inspections
      t.json :in_house_inspections
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
