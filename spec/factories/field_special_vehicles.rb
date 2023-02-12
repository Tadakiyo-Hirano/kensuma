FactoryBot.define do
  factory :order_field_special_vehicle, class: 'FieldSpecialVehicle' do
    field_special_vehicleable_type { 'Order' }
    association :field_special_vehicleable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:vehicle_name) { |n| "vehicle_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    vehicle_type { 1 }
    sequence(:carry_on_company_name) { |n| "carry_on_company_name#{n}" }
    sequence(:owning_company_name) { |n| "owning_company_name#{n}" }
    sequence(:owning_company_representative_name) { |n| "owning_company_representative_name#{n}" }
    sequence(:use_company_name) { |n| "use_company_name#{n}" }
    sequence(:use_company_representative_name) { |n| "use_company_representative_name#{n}" }
    carry_on_date { '2022-01-01' }
    carry_out_date { '2022-01-01' }
    sequence(:use_place) { |n| "use_place#{n}" }
    lease_type { 1 }
  end

  factory :request_order_field_special_vehicle, class: 'FieldSpecialVehicle' do
    field_special_vehicleable_type { 'RequestOrder' }
    association :field_special_vehicleable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:vehicle_name) { |n| "vehicle_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    vehicle_type { 1 }
    sequence(:carry_on_company_name) { |n| "carry_on_company_name#{n}" }
    sequence(:owning_company_name) { |n| "owning_company_name#{n}" }
    sequence(:owning_company_representative_name) { |n| "owning_company_representative_name#{n}" }
    sequence(:use_company_name) { |n| "use_company_name#{n}" }
    sequence(:use_company_representative_name) { |n| "use_company_representative_name#{n}" }
    carry_on_date { '2022-01-01' }
    carry_out_date { '2022-01-01' }
    sequence(:use_place) { |n| "use_place#{n}" }
    lease_type { 1 }
  end
end
