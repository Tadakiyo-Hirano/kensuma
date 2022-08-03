Worker.all.each do |worker|
    WorkerInsurance.seed(:id,
      {
        id:                            worker.id,
        worker_id:                     worker.id,
        health_insurance_type:         rand(0..4),
        health_insurance_name:         '国民健康保険',
        pension_insurance_type:        rand(0..2),
        employment_insurance_type:     rand(0..2),
        employment_insurance_number:   "#{sprintf('%04d', rand(9999))}-#{sprintf('%06d', rand(999999))}-#{sprintf('%01d', rand(9))}",
        severance_pay_mutual_aid_type: rand(0..3),
        severance_pay_mutual_aid_name: 'サンプル共済制度'
      }
    )
  end
