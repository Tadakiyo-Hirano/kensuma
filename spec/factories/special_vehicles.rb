FactoryBot.define do
  factory :special_vehicle do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "name#{n}" }
    sequence(:maker) { |n| "maker#{n}" }
    sequence(:standards_performance) { |n| "standards_performance#{n}" }
    year_manufactured { '2021-01-30' }
    sequence(:control_number) { |n| "12345#{n}" }
    check_exp_date_year { '2022-01-30' }
    check_exp_date_month { '2022-02-28' }
    check_exp_date_specific { '2022-03-30' }
    check_exp_date_machine { '2022-04-30' }
    check_exp_date_car { '2022-05-30' }
    business
  end
end
