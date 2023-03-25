User.where(role: 'admin').all.each do |user|
  Business.seed(:id,
    {
      user_id:                                          user.id,
      name:                                             "テスト建設#{user.id}",
      name_kana:                                        "テストケンセツ#{user.id}",
      branch_name:                                      "テスト支店#{user.id}",
      representative_name:                              user.name,
      email:                                            "test_kensetu#{user.id}@email.com",
      address:                                          "東京都テスト区1-2-#{user.id}",
      post_code:                                        '0123456',
      phone_number:                                     '01234567898',
      career_up_id:                                     'abc123',
      business_type:                                    0,
      business_health_insurance_status:                 rand(0..2),                  # 健康保険(加入状況)
      business_health_insurance_association:            "テスト#{user.id}健康保険組合", # 健康保険(組合名)
      business_health_insurance_office_number:          '01234567',                  # 健康保険(事業所整理記号及び事業所番号)
      business_welfare_pension_insurance_join_status:   rand(0..2),                  # 厚生年金保険(加入状況)
      business_welfare_pension_insurance_office_number: '01234567890123',            # 厚生年金保険(事業所整理記号)
      business_pension_insurance_join_status:           rand(0..2),                  # 年金保険(加入状況)
      business_employment_insurance_join_status:        rand(0..2),                  # 雇用保険(加入状況)
      business_employment_insurance_number:             '01234567890',               # 雇用保険(番号)
      business_retirement_benefit_mutual_aid_status:    rand(0..1),                  # 退職金共済制度(加入状況)
      construction_license_status:                      0,                           # 建設許可証(取得状況) enum
    }
  )
end
