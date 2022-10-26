FactoryBot.define do
  factory :order_field_solvent, class: 'FieldSolvent' do
    field_solventable_type { 'Order' }
    association :field_solventable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:solvent_name) { |n| "solvent_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sequence(:carried_quantity) { |n| "carried_quantity#{n}" }
    sequence(:using_location) { |n| "using_location#{n}" }
    sequence(:storing_place) { |n| "storing_place#{n}" }
    sequence(:using_tool) { |n| "using_tool#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    working_process { 1 }
    sds { 1 }
    sequence(:ventilation_control) { |n| "ventilation_control#{n}" }
  end

  factory :request_order_field_solvent, class: 'FieldSolvent' do
    field_solventable_type { 'RequestOrder' }
    association :field_solventable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:solvent_name) { |n| "solvent_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sequence(:carried_quantity) { |n| "carried_quantity#{n}" }
    sequence(:using_location) { |n| "using_location#{n}" }
    sequence(:storing_place) { |n| "storing_place#{n}" }
    sequence(:using_tool) { |n| "using_tool#{n}" }
    usage_period_start { '2022-01-01' }
    usage_period_end { '2022-01-01' }
    working_process { 1 }
    sds { 1 }
    sequence(:ventilation_control) { |n| "ventilation_control#{n}" }
  end
end
