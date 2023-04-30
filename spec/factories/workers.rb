FactoryBot.define do
  factory :worker do
    association :business
    uuid { SecureRandom.uuid }
    name { 'TestWorker' }
    name_kana { 'テスト ワーカー' }
    country { 'JP' }
    email { 'example@email.com' }
    post_code { '1234567' }
    my_address { '東京都' }
    my_phone_number { '09012345678' }
    family_name { '日本 太郎' }
    relationship { '父' }
    family_address { '東京都' }
    family_phone_number { '08087654321' }
    birth_day_on { '2000-01-28' }
    abo_blood_type { 0 }
    rh_blood_type { 0 }
    hiring_on { '2022-01-28' }
    experience_term_before_hiring { 1 }
    employment_contract { 1 }
    blank_term { 1 }
    career_up_id { nil }
    career_up_images { nil }
    sex { 0 }
    driver_licences { %w[大型免許 普通免許] }
    driver_licence_number { '123456789012' }
    status_of_residence { '' }
    maturity_date { '' }
    confirmed_check { '' }
    confirmed_check_date { '' }
    after(:create) do |worker|
      # create_list(:worker_license, 1, worker: worker, license: License.create!(name: 'テストライセンス', license_type: 0))
      # create_list(:worker_skill_training, 1, worker: worker, skill_training: SkillTraining.create!(name: 'テスト技能講習', short_name: 'テス技'))
      # create_list(:worker_special_education, 1, worker: worker, special_education: SpecialEducation.create!(name: 'テスト特別教育'))
      # create_list(:worker_insurance, 1, worker: worker)
      # create_list(:worker_safety_health_education, 1, worker: worker, safety_health_education: SafetyHealthEducation.create!(name: 'テスト健康診断'))
    end
  end
end
