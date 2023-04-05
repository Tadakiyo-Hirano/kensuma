# 3.times do |n|
#   Worker.seed(:id,
#     {
#       id: n+1,
#       business_id:         1,
#       uuid:                 SecureRandom.uuid,
#       name:                "テスト作業員#{n+1}",
#       name_kana:           "テストサギョウイン#{n+1}",
#       country:             "JP",
#       my_address:          "東京都サギョウ区1-2-#{n+1}",
#       my_phone_number:     "0123456#{sprintf('%04d', rand(9999))}",
#       family_name:         "日本太郎",
#       relationship:        "父",
#       family_address:      "千葉県サギョウ区1-2-#{n+1}",
#       family_phone_number: "0123456#{sprintf('%04d', rand(9999))}",
#       birth_day_on:        rand(Date.parse('1950-01-01') .. Date.parse('2006-01-01')),
#       abo_blood_type:      rand(0..3),
#       rh_blood_type:       rand(0..1),
#       job_title:            "主任#{n+1}",
#       hiring_on:           rand(Date.current.years_ago(10) .. Date.current.prev_month),
#       experience_term_before_hiring: rand(1..10),
#       blank_term:          rand(1..10),
#       career_up_id:        sprintf('%14d', rand(99999999999999)),
#       sex:                 rand(0..1)
#     }
#   )
# end

# 3.times do |n|
#   Worker.seed(:id,
#     {
#       id: n+4,
#       business_id:         2,
#       uuid:                 SecureRandom.uuid,
#       name:                "テスト作業員#{n+4}",
#       name_kana:           "テストサギョウイン#{n+4}",
#       country:             "JP",
#       my_address:          "東京都サギョウ区1-2-#{n+4}",
#       my_phone_number:     "0123456#{sprintf('%04d', rand(9999))}",
#       family_name:         "日本太郎",
#       relationship:        "父",
#       family_address:      "千葉県サギョウ区1-2-#{n+4}",
#       family_phone_number: "0123456#{sprintf('%04d', rand(9999))}",
#       birth_day_on:        rand(Date.parse('1950-01-01') .. Date.parse('2006-01-01')),
#       abo_blood_type:      rand(0..3),
#       rh_blood_type:       rand(0..1),
#       job_title:            "係員#{n+4}",
#       hiring_on:           rand(Date.current.years_ago(10) .. Date.current.prev_month),
#       experience_term_before_hiring: rand(1..10),
#       blank_term:          rand(1..10),
#       career_up_id:        sprintf('%14d', rand(99999999999999)),
#       sex:                 rand(0..1)
#     }
#   )
# end

# 3.times do |n|
#   Worker.seed(:id,
#     {
#       id: n+7,
#       business_id:         3,
#       uuid:                 SecureRandom.uuid,
#       name:                "テスト作業員#{n+7}",
#       name_kana:           "テストサギョウイン#{n+7}",
#       country:             "JP",
#       my_address:          "東京都サギョウ区1-2-#{n+7}",
#       my_phone_number:     "0123456#{sprintf('%04d', rand(9999))}",
#       family_name:         "日本太郎",
#       relationship:        "父",
#       family_address:      "千葉県サギョウ区1-2-#{n+7}",
#       family_phone_number: "0123456#{sprintf('%04d', rand(9999))}",
#       birth_day_on:        rand(Date.parse('1950-01-01') .. Date.parse('2006-01-01')),
#       abo_blood_type:      rand(0..3),
#       rh_blood_type:       rand(0..1),
#       job_title:           "係員#{n+7}",
#       hiring_on:           rand(Date.current.years_ago(10) .. Date.current.prev_month),
#       experience_term_before_hiring: rand(1..10),
#       blank_term:          rand(1..10),
#       career_up_id:        sprintf('%14d', rand(99999999999999)),
#       sex:                 rand(0..1)
#     }
#   )
# end

# 3.times do |n|
#   Worker.seed(:id,
#     {
#       id: n+10,
#       business_id:         4,
#       uuid:                 SecureRandom.uuid,
#       name:                "テスト作業員#{n+10}",
#       name_kana:           "テストサギョウイン#{n+10}",
#       country:             "JP",
#       my_address:          "東京都サギョウ区1-2-#{n+10}",
#       my_phone_number:     "0123456#{sprintf('%04d', rand(9999))}",
#       family_name:         "日本太郎",
#       relationship:        "父",
#       family_address:      "千葉県サギョウ区1-2-#{n+10}",
#       family_phone_number: "0123456#{sprintf('%04d', rand(9999))}",
#       birth_day_on:        rand(Date.parse('1950-01-01') .. Date.parse('2006-01-01')),
#       abo_blood_type:      rand(0..3),
#       rh_blood_type:       rand(0..1),
#       job_title:           "係員#{n+10}",
#       hiring_on:           rand(Date.current.years_ago(10) .. Date.current.prev_month),
#       experience_term_before_hiring: rand(1..10),
#       blank_term:          rand(1..10),
#       career_up_id:        sprintf('%14d', rand(99999999999999)),
#       sex:                 rand(0..1)
#     }
#   )
# end

# 3.times do |n|
#   Worker.seed(:id,
#     {
#       id: n+13,
#       business_id:         5,
#       uuid:                 SecureRandom.uuid,
#       name:                "テスト作業員#{n+13}",
#       name_kana:           "テストサギョウイン#{n+13}",
#       country:             "JP",
#       my_address:          "東京都サギョウ区1-2-#{n+13}",
#       my_phone_number:     "0123456#{sprintf('%04d', rand(9999))}",
#       family_name:         "日本太郎",
#       relationship:        "父",
#       family_address:      "千葉県サギョウ区1-2-#{n+13}",
#       family_phone_number: "0123456#{sprintf('%04d', rand(9999))}",
#       birth_day_on:        rand(Date.parse('1950-01-01') .. Date.parse('2006-01-01')),
#       abo_blood_type:      rand(0..3),
#       rh_blood_type:       rand(0..1),
#       job_title:            "係員#{n+13}",
#       hiring_on:           rand(Date.current.years_ago(10) .. Date.current.prev_month),
#       experience_term_before_hiring: rand(1..10),
#       blank_term:          rand(1..10),
#       career_up_id:        sprintf('%14d', rand(99999999999999)),
#       sex:                 rand(0..1)
#     }
#   )
# end
