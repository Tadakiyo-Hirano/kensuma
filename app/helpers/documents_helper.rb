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
    unless worker&.content&.[](column).nil?
      l worker&.content&.[](column)&.to_date, format: :long
    else
      '年　月　日'
    end
  end

  # 作業員の電話番号情報
  def worker_phone_number(worker, column)
    worker&.content&.[](column)
  end

  # 作業員の血圧情報
  def blood_pressure(worker)
    unless worker&.content&.[]("worker_medical")&.[]("max_blood_pressure").nil? || worker&.content&.[]("worker_medical")&.[]("min_blood_pressure").nil?
      worker&.content&.[]("worker_medical")&.[]("min_blood_pressure").to_s + " ~ " + worker&.content&.[]("worker_medical")&.[]("max_blood_pressure").to_s
    else
      '~'
    end
  end

  # 作業員健康診断の日付情報
  def worker_medical_date(worker, column)
    unless worker&.content&.[]("worker_medical")&.[](column).nil?
      l worker&.content&.[]("worker_medical")&.[](column).to_date, format: :long 
    else
      '年　月　日'
    end
  end

  # 作業員の血液型
  def worker_abo_blood_type(worker)
    case worker&.content&.[]("abo_blood_type")
    when "a" then "A"
    when "b" then "B"
    when "ab" then "AB"
    when "o" then "O"
    end
  end

  # 作業員の年齢情報
  def worker_birth_day_on(worker)
    unless worker&.content&.[]("birth_day_on").nil?
      ((worker&.created_at.to_date.strftime('%Y%m%d').to_i - worker&.content&.[]("birth_day_on").to_date.strftime('%Y%m%d').to_i) / 10000).to_s + '歳'
    else
      '歳'
    end
  end
end
