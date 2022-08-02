module DocumentsHelper
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
    if kentaikyo == 'kentaikyo'
      tag.span '健', class: :severance_pay_mutual_aid
    else
      '健'
    end
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
    unless worker&.content&.[]("worker_medical")&.[]("worker_exams").nil?
      exams = worker&.content&.[]("worker_medical")&.[]("worker_exams").map { |v| SpecialMedExam.find(v["special_med_exam_id"]).name }
      exams.to_s.gsub(/,|"|\[|\]/) {""}
    end
  end
end
