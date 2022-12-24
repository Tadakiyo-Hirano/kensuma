module DocumentsHelper
  # 日付
  def document_date(column)
    l(column, format: :long) unless column.nil?
  end

  # 会社の保険加入状況
  INSURANCE_TYPE = {
    'join'       => '加入',
    'not_join'   => '未加入',
    'not_coverd' => '適用除外'
  }.freeze

  def insurance_join(insurance_type)
    status = INSURANCE_TYPE[insurance_type]
    status == '加入' ? tag.span(status, class: :circle) : '加入'
  end

  def insurance_not_join(insurance_type)
    status = INSURANCE_TYPE[insurance_type]
    status == '未加入' ? tag.span(status, class: :circle) : '未加入'
  end

  def insurance_not_coverd(insurance_type)
    status = INSURANCE_TYPE[insurance_type]
    status == '適用除外' ? tag.span(status, class: :circle) : '適用除外'
  end

  # 専任･非専任
  FULL_TIME_CHECK = {
    'full_time'     => '専任',
    'non_dedicated' => '非専任'
  }.freeze

  def full_time_check(check)
    status = FULL_TIME_CHECK[check]
    status == '専任' ? tag.span(status, class: :circle) : '専任'
  end

  def non_dedicated_check(check)
    status = FULL_TIME_CHECK[check]
    status == '非専任' ? tag.span(status, class: :circle) : '非専任'
  end

  # 一次下請の情報
  def subcon_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    request_order if request_order.parent_id == 1
  end

  def subcons_info
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    request_order.children if request_order.parent_id.nil?
  end

  def document_subcon_info
    if RequestOrder.find_by(uuid: params[:request_order_uuid]).parent_id == 1
      subcon_info
    else
      @subcon
    end
  end

  # 一次下請の情報 (工事安全衛生計画書用)
  def document_subcon_info_for_19th
    request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
    #元請が下請の書類確認するとき
    if params[:sub_request_order_uuid] && request_order.parent_id.nil?
      RequestOrder.find_by(uuid: params[:sub_request_order_uuid])
    #下請けが自身の書類確認するとき
    elsif request_order.parent_id && request_order.parent_id == request_order.parent&.id
      request_order
    #下請けが存在しない場合
    else
      nil
    end
  end

  #作業員情報
  def worker(worker_uuid)
    Worker.find_by(uuid: worker_uuid)&.name
  end

  # 作業員名簿の見出し番号
  def worker_index(number, index)
    number + index * 10
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
    birth_day = worker&.content&.[]('birth_day_on')
    if birth_day.nil?
      '歳'
    else
      age = (worker.created_at.to_date.strftime('%Y%m%d').to_i - birth_day.to_date.strftime('%Y%m%d').to_i) / 10000
      "#{age}歳"
    end
  end

  # 作業員の建設業退職金共済制度情報
  def worker_kentaikyo(worker)
    kentaikyo = worker&.content&.[]('worker_insurance')&.[]('severance_pay_mutual_aid_type')
    kentaikyo == 'kentaikyo' ? tag.span('健', class: :severance_pay_mutual_aid) : '健'
  end

  def worker_tyutaikyo(worker)
    tyutaikyo = worker&.content&.[]('worker_insurance')&.[]('severance_pay_mutual_aid_type')
    tyutaikyo == 'tyutaikyo' ? tag.span('中', class: :severance_pay_mutual_aid) : '中'
  end

  def worker_other(worker)
    other = worker&.content&.[]('worker_insurance')&.[]('severance_pay_mutual_aid_type')
    other == 'other' ? tag.span('他', class: :severance_pay_mutual_aid) : '他'
  end

  def worker_none(worker)
    none = worker&.content&.[]('worker_insurance')&.[]('severance_pay_mutual_aid_type')
    none == 'none' ? tag.span('無', class: :severance_pay_mutual_aid) : '無'
  end

  # 作業員の血圧情報
  def blood_pressure(worker)
    min = worker&.content&.[]('worker_medical')&.[]('min_blood_pressure')
    max = worker&.content&.[]('worker_medical')&.[]('max_blood_pressure')
    min.nil? || max.nil? ? '~' : "#{min} ~ #{max}"
  end

  # 作業員健康診断の日付情報
  def worker_medical_date(worker, column)
    date = worker&.content&.[]('worker_medical')&.[](column)
    date.nil? ? '年　月　日' : l(date.to_date, format: :long)
  end

  # 作業員の血液型情報
  BLOOD_TYPE = {
    'a'  => 'A',
    'b'  => 'B',
    'ab' => 'AB',
    'o'  => 'O'
  }.freeze

  def worker_abo_blood_type(worker)
    blood_type = worker&.content&.[]('abo_blood_type')
    BLOOD_TYPE[blood_type]
  end

  # 作業員の保険情報
  INSURANCE = {
    'health_insurance_association'           => '健康保険組合',
    'japan_health_insurance_association'     => '協会けんぽ',
    'construction_national_health_insurance' => '建設国保',
    'national_health_insurance'              => '国民健康保険',
    'exemption'                              => '適応除外',
    'welfare'                                => '厚生年金',
    'national'                               => '国民年金',
    'recipient'                              => '受給者',
    'insured'                                => '被保険者',
    'day'                                    => '日雇保険'
  }.freeze

  def worker_insurance(worker, column)
    insurance = worker&.content&.[]('worker_insurance')&.[](column)
    insurance unless insurance.nil?
    INSURANCE[insurance]
  end

  # 作業員の特別健康診断の種類
  def worker_special_med_exam(worker)
    exams = worker&.content&.[]('worker_medical')&.[]('worker_exams')
    unless exams.nil?
      exams = exams.map { |exam| SpecialMedExam.find(exam['special_med_exam_id']).name }
      exams.to_s.gsub(/,|"|\[|\]/) { '' }
    end
  end

  # 作業員の特別教育情報
  def worker_special_education(worker)
    educations = worker&.content&.[]('worker_special_educations')
    unless educations.nil?
      educations = educations.map { |education| SpecialEducation.find(education['special_education_id']).name }
      educations.to_s.gsub(/,|"|\[|\]/) { '' }
    end
  end

  # 作業員の技能講習情報
  def worker_skill_training(worker)
    trainings = worker&.content&.[]('worker_skill_trainings')
    unless trainings.nil?
      trainings = trainings.map { |training| SkillTraining.find(training['skill_training_id']).short_name }
      trainings.to_s.gsub(/,|"|\[|\]/) { '' }
    end
  end

  # 作業員の免許情報
  def worker_license(worker)
    licenses = worker&.content&.[]('worker_licenses')
    unless licenses.nil?
      licenses = licenses.map { |license| License.find(license['license_id']).name }
      licenses.to_s.gsub(/,|"|\[|\]/) { '' }
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

  def car_usage_commute(usage)
    usage == '通勤用' ? tag.span('通勤', class: :circle) : '通勤'
  end

  def car_usage_const(usage)
    usage == '工事用' ? tag.span('工事', class: :circle) : '工事'
  end

  #チェックボックスにチェックが入っているかを判別
  def box_checked?(checked_status)
    return true if checked_status == '1'
  end

  
  def checked_box(checked_status)
    if checked_status == '1'
      return '☑︎' 
    else
      return '▢'
    end
  end

  #リスクの見積り
  def risk_estimation_level(risk_possibility,risk_seriousness)
    possibility_point, possibility_comment = risk_possibility(risk_possibility)
    seriousness_point, seriousness_comment = risk_seriousness(risk_seriousness)

    if risk_possibility.nil? || risk_seriousness.nil?
      return ''
    else
      return (possibility_point + seriousness_point)
    end
  end

  #重大性
  def risk_seriousness_level(risk_possibility,risk_seriousness)
    possibility_point, possibility_comment = risk_possibility(risk_possibility)
    seriousness_point, seriousness_comment = risk_seriousness(risk_seriousness)

    if risk_possibility.nil? || risk_seriousness.nil?
      return ''
    else
      return (possibility_point + seriousness_point - 1)
    end
  end

  #リスクの見積りコメント
  def risk_estimation_comment(risk_possibility)
    possibility_point, possibility_comment = risk_possibility(risk_possibility)
    return possibility_comment
  end

  #リスクの重大性コメント
  def risk_seriousness_comment(risk_seriousness)
    seriousness_point, seriousness_comment = risk_seriousness(risk_seriousness)
    return seriousness_comment
  end

  #n次下請のn算出
  def subcontractor_num(worker_uuid, second_workers, third_workers, forth_workers)
    second_workers_uuid = []
    third_workers_uuid = []
    forth_workers_uuid = []

    second_workers&.each do |second_worker|
      second_workers_uuid.push(second_worker.uuid)
    end

    third_workers&.each do |third_worker|
      third_workers_uuid.push(third_worker.uuid)
    end

    if second_workers_uuid.include?(worker_uuid)
      '2'
    elsif third_workers_uuid.include?(worker_uuid)
      '3'
    elsif forth_workers_uuid.include?(worker_uuid)
      '4'
    else
      ''
    end
  end

  def safety_and_health_construction_policy_example
    <<-"EOS".strip_heredoc
    例)当社及び作業所の安全衛生ルールを遵守。
       特定した危険有害要因に対しての実施事項。
       (除去・低減策)の実施。作業開始前、 作業中の安全状態の指差し確認。
    EOS
  end

  def safety_and_health_construction_objective_example
    <<-"EOS".strip_heredoc
    例)墜落危険作業では安全帯を使用 (使用率 100%) する。
       移動式クレーン災害ゼロの実現のため、移動式クレーンの旋回範囲への立入禁止、アウトリガーの張出し、適正な玉掛けを徹底する。
       KY 活動における 「私たちはこうする」 を全員で遵守し、 不安全行動を排除する。
    EOS
  end

  def daily_safety_and_health_activity_example
    <<-"EOS".strip_heredoc
    例)・安全ミーティング
        ・KYK 
        ・作業中の指揮・監督 
        ・安全工程打合せ会 
        ・終業時片付け 
        ・作業終了報告 
    EOS
  end

  def risk_reduction_measures_example
    <<-"EOS".strip_heredoc
    例)1 設置地盤に凸凹、傾斜等がある場合は、地盤を整地するか角材等により水平にする。
         2 地耐力不足の場合は、地盤改良、敷き鉄板等で補強する。
    EOS
  end

  private

  #リスクの可能性
  def risk_possibility(risk_possibility)
    if risk_possibility == 'low'
      possibility_point = 1
      possibility_comment = 'ほとんどない'
    elsif risk_possibility == 'middle'
      possibility_point = 2
      possibility_comment = '可能性がある'
    elsif risk_possibility == 'high'
      possibility_point = 3
      possibility_comment = '極めて高い'
    else
      possibility_point = 0
      possibility_comment = ''
    end
    return possibility_point, possibility_comment
  end


  #リスクの重大性
  def risk_seriousness(risk_seriousness)
    if risk_seriousness == 'low'
      seriousness_point = 1
      seriousness_comment = '軽微'
    elsif risk_seriousness == 'middle'
      seriousness_point = 2
      seriousness_comment = '重大'
    elsif risk_seriousness == 'high'
      seriousness_point = 3
      seriousness_comment = '極めて重大'
    else
      seriousness_point = 0
      seriousness_comment = ''
    end
    return seriousness_point, seriousness_comment
  end

end
