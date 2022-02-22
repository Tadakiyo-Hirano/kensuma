class CreateCarInsuranceCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :car_insurance_companies do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
