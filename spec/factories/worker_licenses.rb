FactoryBot.define do
  factory :worker_license do
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :worker
    association :license
  end
end
