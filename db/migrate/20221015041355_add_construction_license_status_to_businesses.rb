class AddConstructionLicenseStatusToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :construction_license_status, :integer, null: false                    # 建設許可証(取得状況) enum
    add_column :businesses, :construction_license_permission_type_minister_governor, :integer       # 建設許可証(種別) enum
    add_column :businesses, :construction_license_governor_permission_prefecture, :integer          # 建設許可証(都道府県) enum
    add_column :businesses, :construction_license_permission_type_identification_general, :integer  # 建設許可証(種別) enum
    add_column :businesses, :construction_license_number_double_digit, :string                     # 建設許可証(番号)
    add_column :businesses, :construction_license_number_six_digits, :string                       # 建設許可証(番号)
    add_column :businesses, :construction_license_number, :string                                  # 建設許可証(建設許可番号)
    add_column :businesses, :construction_license_updated_at, :date                                # 建設許可証(更新日)
  end
end
