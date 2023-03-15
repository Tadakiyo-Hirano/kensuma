# Worker.all.each do |worker|
#     WorkerInsurance.seed(:id,
#       {
#         id:                            worker.id,
#         worker_id:                     worker.id,
#         health_insurance_type:         :national_health_insurance,
#         health_insurance_name:         '国民健康保険',
#         pension_insurance_type:        :national,
#         employment_insurance_type:     :day,
#         employment_insurance_number:   '1111',
#         severance_pay_mutual_aid_type: :tyutaikyo,
#         severance_pay_mutual_aid_name: 'サンプル共済制度'
#       }
#     )
#   end
