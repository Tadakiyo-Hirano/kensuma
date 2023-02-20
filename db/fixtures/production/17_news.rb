# 20.times do |n|
#   News.seed(
#     {
#       id: n+1,
#       title: "お知らせ-#{n+1}",
#       content: "改行テスト-#{n+1}\r\n改行\r再度改行\n最終行".gsub(/\R/, "\n"),
#       delivered_at: DateTime.now - (n+1),
#       status: 'published'
#     }
#   )
# end
