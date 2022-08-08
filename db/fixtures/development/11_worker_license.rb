Worker.all.each do |worker|
  3.times do |n|
    WorkerLicense.seed(:worker_id, :license_id,
      {
        worker_id:         worker.id,
        license_id:        rand(1..180),
        got_on:            rand(Date.current.years_ago(1) .. Date.current.prev_month)
      }
    )
  end
end
