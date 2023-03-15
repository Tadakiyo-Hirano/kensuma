class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :uuid, null: false
      t.integer :business_type, null: false
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :branch_name, null: false
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
      t.json :tem_industry_ids
      t.integer :specific_skilled_foreigners_exist
      t.integer :foreign_construction_workers_exist
      t.integer :foreign_technical_intern_trainees_exist
      t.string :employment_manager_name
      t.string :employment_manager_post
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
