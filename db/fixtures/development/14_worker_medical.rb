Worker.all.each do |worker|
  WorkerMedical.seed(:id,
    {
      id: worker.id,
      worker_id:           worker.id,
      med_exam_on:         rand(Date.current.years_ago(1) .. Date.current.prev_month),
      max_blood_pressure:  rand(110..140),
      min_blood_pressure:  rand(50..80),
      special_med_exam_on: rand(Date.current.years_ago(1) .. Date.current.prev_month)
    }
  )
end
