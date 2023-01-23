FactoryBot.define do
  factory :machine do
    uuid { SecureRandom.uuid }
    name { '電動ドリル' }
    standards_performance { 'サンプル性能' }
    control_number { '123-456-789' }
    inspector { 'サンプル取扱者' }
    handler { 'サンプル管理者' }
    extra_inspection_item1 { 'test' }
    extra_inspection_item2 { 'test' }
    extra_inspection_item3 { 'test' }
    business
  end
end
