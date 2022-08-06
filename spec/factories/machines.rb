FactoryBot.define do
  factory :machine do
    uuid { SecureRandom.uuid }
    name { 0 }
    standards_performance { 'サンプル性能' }
    control_number { '123-456-789' }
    inspector { 'サンプル取扱者' }
    handler { 'サンプル管理者' }
    inspection_date { '2022-01-30' }
    business
  end
end
