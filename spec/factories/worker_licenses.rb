FactoryBot.define do
  factory :worker_license do
    association :worker
    association :license
    images { [Rails::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'), 'image/jpeg')] }
  end
end
