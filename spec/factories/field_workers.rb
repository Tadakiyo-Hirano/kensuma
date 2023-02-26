FactoryBot.define do
  factory :order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'Order' }
    association :field_workerable, factory: :order
    uuid { SecureRandom.uuid }
    education_date { '2023-01-28' }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end

  factory :request_order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'RequestOrder' }
    association :field_workerable, factory: :request_order
    uuid { SecureRandom.uuid }
    education_date { '2023-01-28' }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end
end
