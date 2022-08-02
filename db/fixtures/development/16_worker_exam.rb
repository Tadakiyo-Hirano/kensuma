WorkerMedical.all.each do |worker_medical|
  3.times do |n|
    WorkerExam.seed(:worker_medical_id, :special_med_exam_id,
      {
        worker_medical_id:   worker_medical.id,
        special_med_exam_id: rand(1..8),
        got_on:              '2022-02-12'
      }
    )
  end
end
