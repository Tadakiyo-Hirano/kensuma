FactoryBot.define do
  factory :worker_skill_training do
    images { '' }
    association :worker
    association :skill_training
  end
end
