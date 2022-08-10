FactoryBot.define do
  factory :car do
    uuid { SecureRandom.uuid }
    usage { 0 }
    sequence(:owner_name) { |n| "owner#{n}" }
    sequence(:safety_manager) { |n| "manager#{n}" }
    sequence(:vehicle_name) { |n| "name#{n}" }
    sequence(:vehicle_model) { |n| "model#{n}" }
    vehicle_number { '品川500あ1234' }
    vehicle_inspection_start_on { '2022-01-30' }
    vehicle_inspection_end_on { '2022-01-30' }
    sequence(:liability_securities_number) { |n| "12345#{n}" }
    liability_insurance_start_on { '2022-01-30' }
    liability_insurance_end_on { '2022-01-30' }
    business
    car_insurance_company
  end
end
