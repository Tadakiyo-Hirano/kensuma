Worker.all.each do |worker|
  3.times do |n|
    WorkerSkillTraining.seed(:worker_id, :skill_training_id,
      {
        worker_id:         worker.id,
        skill_training_id: n+1,
        got_on:            rand(Date.current.years_ago(1) .. Date.current.prev_month)
      }
    )
  end
end
