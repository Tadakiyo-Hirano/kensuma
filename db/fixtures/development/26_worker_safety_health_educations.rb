Worker.all.each do |worker|
  3.times do |n|
    WorkerSafetyHealthEducation.seed(:worker_id, :safety_health_education_id,
      {
        worker_id:         worker.id,
        safety_health_education_id:        rand(1..22)
      }
    )
  end
end