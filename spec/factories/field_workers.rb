FactoryBot.define do
  factory :order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'Order' }
    association :field_workerable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sendoff_education { 0 }
  end

  factory :request_order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'RequestOrder' }
    association :field_workerable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
    sendoff_education { 0 }
  end
end
