FactoryBot.define do
  factory :order_field_machine, class: 'FieldMachine' do
    field_machineable_type { 'Order' }
    association :field_machineable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:machine_name) { |n| "machine_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    carry_on_date { '2022-01-01' }
    carry_out_date { '2022-01-01' }
    sequence(:precautions) { |n| "precautions#{n}" }
  end

  factory :request_order_field_machine, class: 'FieldMachine' do
    field_machineable_type { 'RequestOrder' }
    association :field_machineable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:machine_name) { |n| "machine_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    carry_on_date { '2022-01-01' }
    carry_out_date { '2022-01-01' }
    sequence(:precautions) { |n| "precautions#{n}" }
  end
end
