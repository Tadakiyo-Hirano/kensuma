class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :owner_name, null: false
      t.string :safety_manager
      t.string :vehicle_model, null: false
      t.string :vehicle_number, null: false
      t.date :vehicle_inspection_start_on, null: false
      t.date :vehicle_inspection_end_on, null: false
      t.string :liability_securities_number, null: false
      t.date :liability_insurance_start_on, null: false
      t.date :liability_insurance_end_on, null: false
      t.string :voluntary_securities_number
      t.date :voluntary_insurance_start_on
      t.date :voluntary_insurance_end_on
      t.json :images
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
