Business.all.each do |business|
  3.times do |n|
    BusinessIndustry.seed(:business_id, :industry_id,
      {
        business_id:         business.id,
        industry_id:         rand(1..29),
        construction_license_permission_type_minister_governor:      0,                           # 建設許可証(許可種別) enum
        construction_license_governor_permission_prefecture:         rand(0..46),                 # 建設許可証(都道府県) enum
        construction_license_permission_type_identification_general: 0,                           # 建設許可証(許可種別) enum
        construction_license_number_double_digit:                    29,                          # 建設許可証(番号)
        construction_license_number_six_digits:                      5000,                        # 建設許可証(番号)
        construction_license_number:                                 '国土交通大臣(特－29)第5000号', # 建設許可証(建設許可番号)
        construction_license_updated_at:                             Date.today                   # 建設許可証(更新日)
      }
    )
  end
end
