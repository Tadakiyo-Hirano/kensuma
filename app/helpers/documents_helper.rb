module DocumentsHelper
  # 作業員の文字情報
  def worker_str(worker, column)
    worker&.content&.[](column)
  end
  
  # 作業員の日付情報
  def worker_date(worker, column)
    date = worker&.content&.[](column)
    date.nil? ? '年　月　日' : l(date&.to_date, format: :long)
  end

  # 作業員の電話番号情報
  def worker_phone_number(worker, column)
    worker&.content&.[](column)
  end

  # 作業員の年齢情報
  def worker_age(worker)
    birth_day = worker&.content&.[]("birth_day_on")
    birth_day.nil? ? '歳' : ((worker&.created_at.to_date.strftime('%Y%m%d').to_i - birth_day.to_date.strftime('%Y%m%d').to_i) / 10000).to_s + '歳'
  end

  # 作業員の建設業退職金共済制度情報
  def worker_kentaikyo(worker)
    kentaikyo = worker&.content&.[]("worker_insurance")&.[]("severance_pay_mutual_aid_type")
    kentaikyo == 'kentaikyo' ? tag.span('健', class: :severance_pay_mutual_aid) : '健'
  end

  def worker_tyutaikyo(worker)
    tyutaikyo = worker&.content&.[]("worker_insurance")&.[]("severance_pay_mutual_aid_type")
    tyutaikyo == 'tyutaikyo' ? tag.span('中', class: :severance_pay_mutual_aid) : '中'
  end

  def worker_other(worker)
    other = worker&.content&.[]("worker_insurance")&.[]("severance_pay_mutual_aid_type")
    other == 'other' ? tag.span('他', class: :severance_pay_mutual_aid) : '他'
  end

  def worker_none(worker)
    none = worker&.content&.[]("worker_insurance")&.[]("severance_pay_mutual_aid_type")
    none == 'none' ? tag.span('無', class: :severance_pay_mutual_aid) : '無'
  end

  # 作業員の血圧情報
  def blood_pressure(worker)
    min = worker&.content&.[]("worker_medical")&.[]("min_blood_pressure")
    max = worker&.content&.[]("worker_medical")&.[]("max_blood_pressure")
    min.nil? || max.nil? ? '~' : min.to_s + " ~ " + max.to_s
  end

  # 作業員健康診断の日付情報
  def worker_medical_date(worker, column)
    date = worker&.content&.[]("worker_medical")&.[](column)
    date.nil? ? '年　月　日' : l(date.to_date, format: :long)
  end

  # 作業員の血液型情報
  def worker_abo_blood_type(worker)
    case worker&.content&.[]("abo_blood_type")
    when "a" then "A"
    when "b" then "B"
    when "ab" then "AB"
    when "o" then "O"
    end
  end

  # 作業員の保険情報
  def worker_insurance(worker, column)
    insurance = worker&.content&.[]("worker_insurance")&.[](column)
    insurance unless insurance.nil?
    case insurance
    when 'health_insurance_association' then '健康保険組合'
    when 'japan_health_insurance_association' then '協会けんぽ'
    when 'construction_national_health_insurance' then '建設国保'
    when 'national_health_insurance' then '国民健康保険'
    when 'exemption' then '適応除外'
    when 'welfare' then '厚生年金'
    when 'national' then '国民年金'
    when 'recipient' then '受給者'
    when 'insured' then '被保険者'
    when 'day' then '日雇保険'
    end
  end

  # 作業員の特別健康診断の種類
  def worker_special_med_exam(worker)
    exams = worker&.content&.[]("worker_medical")&.[]("worker_exams")
    unless exams.nil?
      exams = exams.map { |exam| SpecialMedExam.find(exam["special_med_exam_id"]).name }
      exams.to_s.gsub(/,|"|\[|\]/) {""}
    end
  end

  # 作業員の特別教育情報
  def worker_special_education(worker)
    educations = worker&.content&.[]("worker_special_educations")
    unless educations.nil?
      educations = educations.map { |education| SpecialEducation.find(education["special_education_id"]).name }
      educations.to_s.gsub(/,|"|\[|\]/) {""}
    end
  end

  # 作業員の技能講習情報
  def worker_skill_training(worker)
    trainings = worker&.content&.[]("worker_skill_trainings")
    unless trainings.nil?
      trainings = trainings.map { |training| SkillTraining.find(training["skill_training_id"]).short_name }
      trainings.to_s.gsub(/,|"|\[|\]/) {""}
    end
  end

  # 作業員の免許情報
  def worker_license(worker)
    licenses = worker&.content&.[]("worker_licenses")
    unless licenses.nil?
      licenses = licenses.map { |license| License.find(license["license_id"]).id }
      licenses.to_s.gsub(/,|"|\[|\]/) {""}
    end
  end

  # 作業員の入場年月日
  def field_worker_admission_date(worker)
    date = worker&.admission_date_start
    date.blank? ? '年　月　日' : l(date, format: :long)
  end

  # 作業員の受入教育実施年月日
  def field_worker_education_date(worker)
    date = worker&.education_date
    date.blank? ? '年　月　日' : l(date, format: :long)
  end

  # ===== ↓不要 document controler整理後削除↓ =====

  # 書類の見出し番号
  def worker_number(worker)
    worker[1] + 1 unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルの表示
  def worker_column(column, worker)
    JSON.parse(worker[0])[column] unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルに紐づくモデルの表示
  def worker_attribute_column(model, column, worker)
    JSON.parse(worker[0])[model][column] unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルに紐づくモデル(has_many)の表示
  def worker_attributes_column(model, column, worker)
    JSON.parse(worker[0])[model].map { |value| value[column] } unless worker.nil?
  end

  # ===== ↑不要 document controler整理後削除↑ =====
end
