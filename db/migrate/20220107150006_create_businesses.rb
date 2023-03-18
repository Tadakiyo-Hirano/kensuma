class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :uuid, null: false
      t.integer :business_type, null: false
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :branch_name, null: false
      t.string :branch_address
      t.string :representative_name, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :post_code, null: false
      t.string :phone_number, null: false
      t.string :fax_number
      t.string :career_up_id
      t.json :career_up_card_copy
      t.json :stamp_images
      t.json :occupation_ids
      t.json :industry_ids
      t.integer :specific_skilled_foreigners_exist
      t.integer :foreign_construction_workers_exist
      t.integer :foreign_technical_intern_trainees_exist
      t.integer :construction_license_status, null: false, comment: "建設許可証(取得状況) enum"
      t.string :foreigners_employment_manager                 #雇用管理責任者(氏名)
      t.string :employment_manager_name
      t.string :employment_manager_post
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
