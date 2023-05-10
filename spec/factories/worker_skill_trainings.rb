FactoryBot.define do
  factory :worker_skill_training do
    images { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))] }
    association :worker
    association :skill_training
  end
end
