3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id: n+1,
      business_id:         1,
      uuid:                SecureRandom.uuid,
      check_exp_date_year: '2020-01-01',
      check_exp_date_month: '2020-02-01',
      check_exp_date_specific: '2020-03-01',
      check_exp_date_machine: '2020-04-01',
      check_exp_date_car: '2020-05-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id: n+4,
      business_id:         2,
      uuid:                SecureRandom.uuid,
      check_exp_date_year: '2020-01-01',
      check_exp_date_month: '2020-02-01',
      check_exp_date_specific: '2020-03-01',
      check_exp_date_machine: '2020-04-01',
      check_exp_date_car: '2020-05-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id: n+7,
      business_id:         3,
      uuid:                SecureRandom.uuid,
      check_exp_date_year: '2020-01-01',
      check_exp_date_month: '2020-02-01',
      check_exp_date_specific: '2020-03-01',
      check_exp_date_machine: '2020-04-01',
      check_exp_date_car: '2020-05-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id: n+10,
      business_id:         4,
      uuid:                SecureRandom.uuid,
      check_exp_date_year: '2020-01-01',
      check_exp_date_month: '2020-02-01',
      check_exp_date_specific: '2020-03-01',
      check_exp_date_machine: '2020-04-01',
      check_exp_date_car: '2020-05-01'
    }
  )
end

3.times do |n|
  SpecialVehicle.seed(:id,
    {
      id: n+13,
      business_id:         5,
      uuid:                SecureRandom.uuid,
      check_exp_date_year: '2020-01-01',
      check_exp_date_month: '2020-02-01',
      check_exp_date_specific: '2020-03-01',
      check_exp_date_machine: '2020-04-01',
      check_exp_date_car: '2020-05-01'
    }
  )
end
