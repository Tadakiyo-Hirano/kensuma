class CreateSpecialVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :special_vehicles do |t|
      t.string :uuid, null: false
      t.string :name
      t.string :maker
      t.string :standards_performance
      t.date :year_manufactured
      t.string :control_number
      t.date :check_exp_date_year, null: false
      t.date :check_exp_date_month, null: false
      t.date :check_exp_date_specific, null: false
      t.date :check_exp_date_machine, null: false
      t.date :check_exp_date_car, null: false
      t.integer :personal_insurance
      t.integer :objective_insurance
      t.integer :passenger_insurance
      t.integer :other_insurance
      t.integer :exp_date_insurance
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
