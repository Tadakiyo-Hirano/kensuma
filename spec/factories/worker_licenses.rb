FactoryBot.define do
  factory :worker_license do
    images { '' }
    association :worker
    association :license
  end
end
