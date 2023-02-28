FactoryBot.define do
  factory :order_field_solvent, class: 'FieldSolvent' do
    field_solventable_type { 'Order' }
    association :field_solventable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:solvent_name_one) { |n| "solvent_name_one#{n}" }
    sequence(:solvent_name_two) { |n| "solvent_name_two#{n}" }
    sequence(:solvent_name_three) { |n| "solvent_name_three#{n}" }
    sequence(:solvent_name_four) { |n| "solvent_name_four#{n}" }
    sequence(:solvent_name_five) { |n| "solvent_name_five#{n}" }
    sequence(:carried_quantity_one) { |n| "carried_quantity_one#{n}" }
    sequence(:carried_quantity_two) { |n| "carried_quantity_two#{n}" }
    sequence(:carried_quantity_three) { |n| "carried_quantity_three#{n}" }
    sequence(:carried_quantity_four) { |n| "carried_quantity_four#{n}" }
    sequence(:carried_quantity_five) { |n| "carried_quantity_five#{n}" }
    sequence(:solvent_classification_one) { |n| "solvent_classification_one#{n}" }
    sequence(:solvent_classification_two) { |n| "solvent_classification_two#{n}" }
    sequence(:solvent_classification_three) { |n| "solvent_classification_three#{n}" }
    sequence(:solvent_classification_four) { |n| "solvent_classification_four#{n}" }
    sequence(:solvent_classification_five) { |n| "solvent_classification_five#{n}" }
    sequence(:solvent_ingredients_one) { |n| "solvent_ingredients_one#{n}" }
    sequence(:solvent_ingredients_two) { |n| "solvent_ingredients_two#{n}" }
    sequence(:solvent_ingredients_three) { |n| "solvent_ingredients_three#{n}" }
    sequence(:solvent_ingredients_four) { |n| "solvent_ingredients_four#{n}" }
    sequence(:solvent_ingredients_five) { |n| "solvent_ingredients_five#{n}" }
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
    sequence(:solvent_name_one) { |n| "solvent_name_one#{n}" }
    sequence(:solvent_name_two) { |n| "solvent_name_two#{n}" }
    sequence(:solvent_name_three) { |n| "solvent_name_three#{n}" }
    sequence(:solvent_name_four) { |n| "solvent_name_four#{n}" }
    sequence(:solvent_name_five) { |n| "solvent_name_five#{n}" }
    sequence(:carried_quantity_one) { |n| "carried_quantity_one#{n}" }
    sequence(:carried_quantity_two) { |n| "carried_quantity_two#{n}" }
    sequence(:carried_quantity_three) { |n| "carried_quantity_three#{n}" }
    sequence(:carried_quantity_four) { |n| "carried_quantity_four#{n}" }
    sequence(:carried_quantity_five) { |n| "carried_quantity_five#{n}" }
    sequence(:solvent_classification_one) { |n| "solvent_classification_one#{n}" }
    sequence(:solvent_classification_two) { |n| "solvent_classification_two#{n}" }
    sequence(:solvent_classification_three) { |n| "solvent_classification_three#{n}" }
    sequence(:solvent_classification_four) { |n| "solvent_classification_four#{n}" }
    sequence(:solvent_classification_five) { |n| "solvent_classification_five#{n}" }
    sequence(:solvent_ingredients_one) { |n| "solvent_ingredients_one#{n}" }
    sequence(:solvent_ingredients_two) { |n| "solvent_ingredients_two#{n}" }
    sequence(:solvent_ingredients_three) { |n| "solvent_ingredients_three#{n}" }
    sequence(:solvent_ingredients_four) { |n| "solvent_ingredients_four#{n}" }
    sequence(:solvent_ingredients_five) { |n| "solvent_ingredients_five#{n}" }
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
