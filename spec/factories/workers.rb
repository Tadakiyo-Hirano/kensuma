FactoryBot.define do
  factory :worker do
    association :business
    name { 'TestWorker' }
    name_kana { 'テストワーカー' }
    country { '日本' }
    my_address { '東京都' }
    my_phone_number { '09012345678' }
    family_address { '東京都' }
    family_phone_number { '08087654321' }
    birth_day_on { '2022-01-28' }
    abo_blood_type { 0 }
    rh_blood_type { 0 }
    job_type { 0 }
    hiring_on { '2022-01-28' }
    experience_term_before_hiring { 1 }
    blank_term { 1 }
    carrier_up_id { '1' }
    images { '' }
  end
end
