FactoryBot.define do
  factory :car_insurance_company do
    sequence(:name) { |n| "NAME#{n}" }
  end
end
