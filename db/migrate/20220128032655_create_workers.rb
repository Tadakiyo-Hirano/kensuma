class CreateWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :workers do |t|
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :country, null: false
      t.string :my_address, null: false
      t.string :my_phone_number, null: false
      t.string :family_address, null: false
      t.string :family_phone_number, null: false
      t.date :birth_day_on, null: false
      t.integer :abo_blood_type, null: false, default: 0
      t.integer :rh_blood_type, null: false, default: 0
      t.integer :job_type, null: false, default: 0
      t.date :hiring_on, null: false
      t.integer :experience_term_before_hiring, null: false
      t.integer :blank_term, null: false
      t.string :carrier_up_id
      t.json :images
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
