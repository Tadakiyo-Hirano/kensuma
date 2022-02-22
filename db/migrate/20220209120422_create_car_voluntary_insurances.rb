class CreateCarVoluntaryInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_voluntary_insurances do |t|
      t.integer :personal_insurance
      t.integer :objective_insurance
      t.references :car_voluntary, foreign_key: { to_table: :cars }, null: false
      t.references :company_voluntary, foreign_key: { to_table: :car_insurance_companies }, null: false
      
      t.timestamps
    end
  end
end
