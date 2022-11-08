FactoryBot.define do
  factory :order_field_fire, class: 'FieldFire' do
    field_fireable_type { 'Order' }
    association :field_fireable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:use_place) { |n| "use_place#{n}" }
    sequence(:other_usages) { |n| "other_usages#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    usage_time_start { '15:00:00' }
    usage_time_end { '15:00:00' }
    sequence(:precautions) { |n| "precautions#{n}" }
    sequence(:fire_origin_responsible) { |n| "fire_origin_responsible#{n}" }
    sequence(:fire_use_responsible) { |n| "fire_use_responsible#{n}" }
  end

  factory :request_order_field_fire, class: 'FieldFire' do
    field_fireable_type { 'RequestOrder' }
    association :field_fireable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:use_place) { |n| "use_place#{n}" }
    sequence(:other_usages) { |n| "other_usages#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    usage_time_start { '15:00:00' }
    usage_time_end { '15:00:00' }
    sequence(:precautions) { |n| "precautions#{n}" }
    sequence(:fire_origin_responsible) { |n| "fire_origin_responsible#{n}" }
    sequence(:fire_use_responsible) { |n| "fire_use_responsible#{n}" }
  end
end