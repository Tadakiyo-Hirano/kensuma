# Worker.all.each do |worker|
#   3.times do |n|
#     WorkerLicense.seed(:worker_id, :license_id,
#       {
#         worker_id:         worker.id,
#         license_id:        n+1,
#         got_on:             '2022-02-12'
#       }
#     )
#   end
# end
