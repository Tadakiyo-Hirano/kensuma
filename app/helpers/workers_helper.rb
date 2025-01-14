module WorkersHelper
  def test_data_new
    @worker = current_business.workers.new(
      # テスト用デフォルト値 ==========================
      name:                          'サンプル作業員',
      name_kana:                     'サンプル サギョウイン',
      country:                       'JP',
      email:                         'test_user@email.com',
      my_address:                    '東京都港区1-1',
      my_phone_number:               '12345678901',
      family_name:                   'フェルナンデス',
      relationship:                  '父親',
      family_address:                '埼玉県三郷市1-1',
      family_phone_number:           '1234567890',
      birth_day_on:                  '2000-01-28',
      abo_blood_type:                :a,
      rh_blood_type:                 :plus,
      job_title:                     '主任',
      hiring_on:                     '2022-01-28',
      experience_term_before_hiring: 10,
      blank_term:                    3,
      career_up_id:                  '12345678901234',
      sex:                           :man,
      post_code:                     '1234567',
      status_of_residence:           :permanent_resident,
      maturity_date:                 '2000-01-28',
      confirmed_check:               :checked,
      confirmed_check_date:          '2000-01-28'
      # ============================================
    )
    @worker.worker_licenses.build(
      # テスト用デフォルト値 ==========================
      license_id: 1
      # ============================================
    )
    @worker.worker_skill_trainings.build(
      # テスト用デフォルト値 ==========================
      skill_training_id: 2
      # ============================================
    )
    @worker.worker_special_educations.build(
      # テスト用デフォルト値 ==========================
      special_education_id: 3
      # ============================================
    )
    @worker.worker_safety_health_educations.build(
      # テスト用デフォルト値 ==========================
      safety_health_education_id: 1
      # ============================================
    )
    @worker.build_worker_medical(
      # テスト用デフォルト値 ==========================
      is_med_exam:        :y,
      health_condition:   :good,
      med_exam_on:        '2022-03-01',
      max_blood_pressure: 120,
      min_blood_pressure: 70
      # ============================================
    )
    @worker.build_worker_insurance(
      # テスト用デフォルト値 ==========================
      health_insurance_type:         :health_insurance_association,
      health_insurance_name:         'サンプル健康保険',
      pension_insurance_type:        :welfare,
      employment_insurance_type:     :insured,
      employment_insurance_number:   '12345678901',
      severance_pay_mutual_aid_type: :kentaikyo,
      severance_pay_mutual_aid_name: 'テスト共済制度',
      has_labor_insurance:           :join
      # ============================================
    )
  end

  def production_data_new
    @worker = current_business.workers.new(
      # 本番環境用デフォルト値 ==========================
      country:             'JP',
      abo_blood_type:      :a,
      rh_blood_type:       :plus,
      sex:                 :man,
      status_of_residence: :permanent_resident,
      confirmed_check:     :checked
      # ============================================
    )
    @worker.worker_licenses.build
    @worker.worker_skill_trainings.build
    @worker.worker_special_educations.build
    worker_medical = @worker.build_worker_medical(
      # 本番環境用デフォルト値 ==========================
      is_med_exam:         :y,
      is_special_med_exam: :y,
      health_condition:    :good
      # ============================================
    )
    @worker.worker_safety_health_educations.build
    worker_medical.worker_exams.build
    @worker.build_worker_insurance(
      # 本番環境用デフォルト値 ==========================
      health_insurance_type:         :health_insurance_association,
      pension_insurance_type:        :welfare,
      employment_insurance_type:     :insured,
      severance_pay_mutual_aid_type: :kentaikyo,
      has_labor_insurance:           :join
      # ============================================
    )
  end
end
