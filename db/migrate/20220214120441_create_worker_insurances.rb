class CreateWorkerInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_insurances do |t|
      t.integer :health_insurance_type, null: false
      t.string :health_insurance_name
      t.integer :pension_insurance_type, null: false
      t.integer :employment_insurance_type, null: false
      t.string :employment_insurance_number
      t.integer :severance_pay_mutual_aid_type, null: false
      t.string :severance_pay_mutual_aid_name
      t.references :worker, foreign_key: true, null: false

      t.timestamps
    end
  end
end
