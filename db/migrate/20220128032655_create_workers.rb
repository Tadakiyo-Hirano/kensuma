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
      t.date :hiring_on, null: false
      t.integer :experience_term_before_hiring, null: false
      t.integer :blank_term, null: false
      t.string :career_up_id
      t.json :images
      t.references :business, foreign_key: true, null: false
      t.string :uuid, null: false
      t.string :job_title, null: false
      t.integer :employment_contract, null: false, default: 0   # 雇用契約書 enum
      t.string :family_name,null: false                         # 緊急連絡先-氏名
      t.string :relationship,null: false                        # 緊急連絡先-続柄
      t.string :email
      t.integer :sex, null: false, default: 0
      t.integer :status_of_residence
      t.date :maturity_date
      t.integer :confirmed_check
      t.date :confirmed_check_date
      t.string :passport_front
      t.string :passport_back
      t.string :residence_card_front
      t.string :residence_card_back
      t.string :employment_condition
      t.integer :post_code
      t.string :driver_licence
      t.integer :driver_licence_number
      t.string :seal
      t.json :employee_card

      t.timestamps
    end
  end
end
