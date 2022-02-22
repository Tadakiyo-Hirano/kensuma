FactoryBot.define do
  factory :worker_insurance do
    association :worker
    health_insurance_type { rand(4) }
    sequence(:health_insurance_name) { |n| "health_insurance_name#{n}" }
    pension_insurance_type { rand(2) }
    employment_insurance_type { rand(2) }
    employment_insurance_number { '%.4d' % rand(10000) }
    severance_pay_mutual_aid_type { rand(3) }
    sequence(:severance_pay_mutual_aid_name) { |n| "severance_pay_mutual_aid_name#{n}" }
  end
end
