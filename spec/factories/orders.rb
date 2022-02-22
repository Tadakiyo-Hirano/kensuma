FactoryBot.define do
  factory :order do
    status { 0 }
    site_uu_id { SecureRandom.uuid }
    sequence(:site_name) { |n| "site_name#{n}" }
    sequence(:order_name) { |n| "order_name#{n}" }
    order_post_code { '1000014' }
    sequence(:order_address) { |n| "order_address#{n}" }
    business
  end
end
