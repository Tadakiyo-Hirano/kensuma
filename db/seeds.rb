# frozen_string_literal: true

# 本番環境での確認の為、一時的に本番環境でもデータ作成されるように変更。本番運用時は元に戻す事。
# Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# User
50.times do |i|
  user = User.new(
    email: "test_user#{i}@gmail.com", # sample: test_user1@gmail.com
    name: "テストuser#{i}",
    password: 'password'
  )

  user.skip_confirmation! # deviseの確認メールをスキップ
  user.save!
end

# Business
user = User.first
# User.firstに紐づく事業所を1件作成
user.create_business!(
  uuid:                false,
  name:                'テスト建設',
  name_kana:           'テストケンセツ',
  branch_name:         'テスト支店',
  representative_name: user.name,
  email:               'test_kensetu@email.com',
  address:             '東京都テスト区1-2-3',
  post_code:           '0123456',
  phone_number:        '01234567898',
  carrier_up_id:       'abc123',
  stamp_images:        [open("#{Rails.root}/public/sample_stamp.png")],
  business_type:       0
)
