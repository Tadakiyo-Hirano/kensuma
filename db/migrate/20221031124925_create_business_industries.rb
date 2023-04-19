class CreateBusinessIndustries < ActiveRecord::Migration[6.1]
  def change
    create_table :business_industries do |t|
      t.integer :construction_license_permission_type_minister_governor, comment: "建設許可証(許可種別) enum"
      t.integer :construction_license_governor_permission_prefecture, comment: "建設許可証(都道府県) enum"
      t.integer :construction_license_permission_type_identification_general, comment: "建設許可証(種別) enum"
      t.string :construction_license_number_double_digit, comment: "建設許可証(和暦年度)"
      t.string :construction_license_number_six_digits, comment: "建設許可証(番号)"
      t.string :construction_license_number, comment: "建設許可証(建設許可番号)"
      t.date :construction_license_updated_at, comment: "建設許可証(更新日)"
      t.references :business, null: false, foreign_key: true
      t.references :industry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
