FactoryBot.define do
  factory :worker_special_education do
    images { '' }
    association :worker
    association :special_education
  end
end
