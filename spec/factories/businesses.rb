FactoryBot.define do
  factory :business do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "TEST企業#{n}" }
    name_kana { 'テストキギョウ' }
    branch_name { 'TEST支店' }
    representative_name { 'TEST代表' }
    sequence(:email) { |n| "test#{n}@example.com" }
    address { 'TEST' }
    post_code { '0120123' }
    phone_number { '09001230123' }
    career_up_id { '1' }
    business_type { 0 }
    business_health_insurance_status { 0 } # 健康保険(加入状況)
    business_health_insurance_association { 'TEST健康保険組合' } # 健康保険(組合名)
    business_health_insurance_office_number { '01234567' } # 健康保険(事業所整理記号及び事業所番号)
    business_welfare_pension_insurance_join_status { 0 } # 厚生年金保険(加入状況)
    business_welfare_pension_insurance_office_number { '01234567890123' } # 厚生年金保険(事業所整理記号)
    business_pension_insurance_join_status { 0 } # 年金保険(加入状況)
    business_employment_insurance_join_status { 0 } # 雇用保険(加入状況)
    business_employment_insurance_number { '01234567890' } # 雇用保険(番号)
    business_retirement_benefit_mutual_aid_status { 0 } # 退職金共済制度(加入状況)
    user
    construction_license_status { 0 } # 建設許可証(取得状況) enum
    construction_license_permission_type_minister_governor { 0 } # 建設許可証(種別) enum
    construction_license_governor_permission_prefecture { 0 } # 建設許可証(都道府県) enum
    construction_license_permission_type_identification_general { 0 } # 建設許可証(種別) enum
    construction_license_number_double_digit { '29' } # 建設許可証(番号)
    construction_license_number_six_digits { '5000' } # 建設許可証(番号)
    construction_license_number { '国土交通大臣(特－29)第5000号' } # 建設許可証(建設許可番号)
    construction_license_updated_at { Date.today } # 建設許可証(更新日)
  end
end
