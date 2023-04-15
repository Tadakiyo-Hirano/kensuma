3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id:                       n+1,
      business_id:              1,
      name:                     'クレーン',
      maker:                    'トヨタ',
      owning_company_name:      'テスト建設',
      standards_performance:    '幅2.5M',
      year_manufactured:        Date.today.ago(3.years),
      control_number:           SecureRandom.hex(5),
      uuid:                     SecureRandom.uuid,
      check_exp_date_year:      '2020-01-01',
      check_exp_date_month:     '2020-02-01',
      check_exp_date_specific:  '2020-03-01',
      check_exp_date_machine:   '2020-04-01',
      check_exp_date_car:       '2020-05-01',
      vehicle_type:             0,
      personal_insurance:       1,
      objective_insurance:      2,
      passenger_insurance:      3,
      other_insurance:          4,
      exp_date_insurance:       '2023-01-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id:                        n+4,
      business_id:               2,
      name:                     'コンテナ用セミトレーラ',
      maker:                    'ヤマハ',
      owning_company_name:      'テスト建設',
      standards_performance:    '幅2.5M',
      year_manufactured:        Date.today.ago(3.years),
      control_number:           SecureRandom.hex(5),
      uuid:                     SecureRandom.uuid,
      check_exp_date_year:      '2020-01-01',
      check_exp_date_month:     '2020-02-01',
      check_exp_date_specific:  '2020-03-01',
      check_exp_date_machine:   '2020-04-01',
      check_exp_date_car:       '2020-05-01',
      vehicle_type:             0,
      personal_insurance:       1,
      objective_insurance:      2,
      passenger_insurance:      3,
      other_insurance:          4,
      exp_date_insurance:       '2023-01-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id:                        n+7,
      business_id:               3,
      name:                     'タンク型セミトレーラ',
      maker:                    '日産',
      owning_company_name:      'テスト建設',
      standards_performance:    '幅2.5M',
      year_manufactured:        Date.today.ago(3.years),
      control_number:           SecureRandom.hex(5),
      uuid:                     SecureRandom.uuid,
      check_exp_date_year:      '2020-01-01',
      check_exp_date_month:     '2020-02-01',
      check_exp_date_specific:  '2020-03-01',
      check_exp_date_machine:   '2020-04-01',
      check_exp_date_car:       '2020-05-01',
      vehicle_type:             0,
      personal_insurance:       1,
      objective_insurance:      2,
      passenger_insurance:      3,
      other_insurance:          4,
      exp_date_insurance:       '2023-01-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id:                        n+10,
      business_id:               4,
      name:                     'フルトレーラ',
      maker:                    '三菱',
      owning_company_name:      'テスト建設',
      standards_performance:    '幅2.5M',
      year_manufactured:        Date.today.ago(3.years),
      control_number:           SecureRandom.hex(5),
      uuid:                     SecureRandom.uuid,
      check_exp_date_year:      '2020-01-01',
      check_exp_date_month:     '2020-02-01',
      check_exp_date_specific:  '2020-03-01',
      check_exp_date_machine:   '2020-04-01',
      check_exp_date_car:       '2020-05-01',
      vehicle_type:             0,
      personal_insurance:       1,
      objective_insurance:      2,
      passenger_insurance:      3,
      other_insurance:          4,
      exp_date_insurance:       '2023-01-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id:                       n+13,
      business_id:              5,
      name:                     'ポールトレーラ',
      maker:                    'いすゞ',
      owning_company_name:      'テスト建設',
      standards_performance:    '幅2.5M',
      year_manufactured:        Date.today.ago(3.years),
      control_number:           SecureRandom.hex(5),
      uuid:                     SecureRandom.uuid,
      check_exp_date_year:      '2020-01-01',
      check_exp_date_month:     '2020-02-01',
      check_exp_date_specific:  '2020-03-01',
      check_exp_date_machine:   '2020-04-01',
      check_exp_date_car:       '2020-05-01',
      vehicle_type:             0,
      personal_insurance:       1,
      objective_insurance:      2,
      passenger_insurance:      3,
      other_insurance:          4,
      exp_date_insurance:       '2023-01-01'
    }
  )
end
