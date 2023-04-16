Worker.all.each do |worker|
  3.times do |n|
    WorkerSpecialEducation.seed(:worker_id, :special_education_id,
      {
        worker_id:            worker.id,
        special_education_id: rand(1..53)
      }
    )
  end
end
