FactoryBot.define do
  factory :worker_insurance do
    association :worker
    health_insurance_type { :health_insurance_association }
    sequence(:health_insurance_name) { |n| "health_insurance_name#{n}" }
    pension_insurance_type { rand(2) }
    employment_insurance_type { :insured }
    employment_insurance_number { '%.11d' % rand(100000000000) }
    severance_pay_mutual_aid_type { :other }
    severance_pay_mutual_aid_name { 'テスト' }
  end
end
