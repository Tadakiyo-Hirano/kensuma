Worker.all.each do |worker|
  3.times do |n|
    WorkerLicense.seed(:worker_id, :license_id,
      {
        worker_id:         worker.id,
        license_id:        rand(1..180)
      }
    )
  end
end
