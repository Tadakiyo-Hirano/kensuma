FactoryBot.define do
  factory :order_field_car, class: 'FieldCar' do
    field_carable_type { 'Order' }
    association :field_carable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:car_name) { |n| "car_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end

  factory :request_order_field_car, class: 'FieldCar' do
    field_carable_type { 'RequestOrder' }
    association :field_carable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:car_name) { |n| "car_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end
end
