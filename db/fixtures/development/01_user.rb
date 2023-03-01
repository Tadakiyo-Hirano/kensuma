5.times do |n|
  User.seed(:id,
    {
      id: n+1,
      email: "test_user#{n+1}@gmail.com",
      name: "テストuser#{n+1}",
      password: 'password',
      password_confirmation: 'password',
      role: 'admin',
      confirmed_at: Time.now,
      is_prime_contractor: 0,
      invited_user_ids: (6..10).to_a.shuffle.take(4)
    }
  )
end

6.upto(10) do |n|
  User.seed(:id,
    {
      id: n,
      email: "test_user#{n}@gmail.com",
      name: "テストuser#{n}",
      password: 'password',
      password_confirmation: 'password',
      role: 'admin',
      confirmed_at: Time.now,
      is_prime_contractor: 1,
      invited_user_ids: (11..15).to_a.shuffle.take(4)
    }
  )
end

11.upto(15) do |n|
  User.seed(:id,
    {
      id: n,
      email: "test_user#{n}@gmail.com",
      name: "テストuser#{n}",
      password: 'password',
      password_confirmation: 'password',
      role: 'admin',
      confirmed_at: Time.now,
      is_prime_contractor: 1,
      invited_user_ids: (16..20).to_a.shuffle.take(4)
    }
  )
end

16.upto(20) do |n|
  User.seed(:id,
    {
      id: n,
      email: "test_user#{n}@gmail.com",
      name: "テストuser#{n}",
      password: 'password',
      password_confirmation: 'password',
      role: 'admin',
      confirmed_at: Time.now,
      is_prime_contractor: 1,
      invited_user_ids: (21..25).to_a.shuffle.take(4)
    }
  )
end

21.upto(25) do |n|
  User.seed(:id,
    {
      id: n,
      email: "test_user#{n}@gmail.com",
      name: "テストuser#{n}",
      password: 'password',
      password_confirmation: 'password',
      role: 'admin',
      confirmed_at: Time.now,
      is_prime_contractor: 1
    }
  )
end

# 3.times do |n|
#   User.seed(:id,
#     {
#       id: n+6,
#       email: "general_user#{n+1}@gmail.com",
#       name: "一般user#{n+1}",
#       password: 'password',
#       password_confirmation: 'password',
#       role: 'general',
#       confirmed_at: Time.now,
#       admin_user_id: 1
#     }
#   )
# end
