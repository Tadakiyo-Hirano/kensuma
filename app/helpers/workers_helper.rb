module WorkersHelper
  # ユーザーが元請設定の場合は必須マークの表示をさせない
  def required_label
    if @current_business.user.is_prime_contractor
      # もし prime_contractor なら空の文字列を返す
      ''
    else
      content_tag(:span, '必須', class: 'p-1 mb-2 rounded bg-danger text-white')
    end
  end

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
      health_insurance_type:         :not_health_insurance,
      pension_insurance_type:        :welfare,
      employment_insurance_type:     :exemption,
      severance_pay_mutual_aid_type: :none,
      # has_labor_insurance:           :not_join
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
    @worker.build_worker_medical(
      # 本番環境用デフォルト値 ==========================
      is_med_exam:         :n,
      is_special_med_exam: :n,
      health_condition:    :good
      # ============================================
    )
    @worker.worker_safety_health_educations.build
    @worker.build_worker_insurance(
      # 本番環境用デフォルト値 ==========================
      health_insurance_type:         :not_health_insurance,
      pension_insurance_type:        :welfare,
      employment_insurance_type:     :exemption,
      severance_pay_mutual_aid_type: :none,
      # has_labor_insurance:           :not_join
      # ============================================
    )
  end
end
