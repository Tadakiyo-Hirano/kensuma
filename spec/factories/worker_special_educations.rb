FactoryBot.define do
  factory :worker_special_education do
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :worker
    association :special_education
  end
end
