FactoryBot.define do
  factory :worker_safety_health_education do
    worker_id { nil }
    safety_health_education_id { nil }
    images { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))] }
  end
end
