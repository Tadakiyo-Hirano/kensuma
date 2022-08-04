FactoryBot.define do
  factory :special_vehicle do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "name#{n}" }
    sequence(:maker) { |n| "maker#{n}" }
    check_exp_date_year { '2022-01-30' }
    check_exp_date_month { '2022-01-30' }
    check_exp_date_specific { '2022-01-30' }
    check_exp_date_machine { '2022-01-30' }
    check_exp_date_car { '2022-01-30' }
    business
  end
end
