FactoryBot.define do
  factory :order_field_car, class: 'FieldCar' do
    field_carable_type { 'Order' }
    association :field_carable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:car_name) { |n| "car_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sequence(:driver_name) { |n| "driver_name#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    sequence(:starting_point) { |n| "starting_point#{n}" }
    sequence(:waypoint_first) { |n| "waypoint_first#{n}" }
    sequence(:waypoint_second) { |n| "waypoint_second#{n}" }
    sequence(:arrival_point) { |n| "arrival_point#{n}" }
  end

  factory :request_order_field_car, class: 'FieldCar' do
    field_carable_type { 'RequestOrder' }
    association :field_carable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:car_name) { |n| "car_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sequence(:driver_name) { |n| "driver_name#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    sequence(:starting_point) { |n| "starting_point#{n}" }
    sequence(:waypoint_first) { |n| "waypoint_first#{n}" }
    sequence(:waypoint_second) { |n| "waypoint_second#{n}" }
    sequence(:arrival_point) { |n| "arrival_point#{n}" }
  end
end
