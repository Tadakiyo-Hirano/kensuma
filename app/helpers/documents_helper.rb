module DocumentsHelper
  # 日付
  def document_date(column)
    l(column, format: :long) unless column.nil?
  end

  # document.contentの日付
  def doc_content_date(date)
    if action_name == 'edit'
      date.nil? ? '' : date # nilの場合のstrftime表示エラー回避
    else
      date.nil? || date == [''] || date == '' ? '年　月　日' : date.first.to_date&.strftime('%Y年%-m月%-d日')
    end
  end

  # (4)施工体制台帳

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

  # (8)作業員名簿

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

  # 新規入場者調査票用（資格-技能講習-作業主任者-その他枠）
  def worker_skill_training_work_other(worker)
    trainings = worker&.content&.[]('worker_skill_trainings')

    unless trainings.nil?
      trainings = trainings.map { |training| SkillTraining.find(training['skill_training_id']).short_name }
      trainings.to_s.gsub(/,|"|\[|\]/) { '' }
      no_work =
        %w[整地 基礎 解体 不整 高所 フォ ショ 小ク 床ク
           ガス 玉掛 コ破 地山 石綿 有機 型枠 足場 ボ取 コ解 酸欠]
      trainings.delete_if do |t_work|
        no_work.include?(t_work)
      end
    end

    trainings2 = trainings
    if trainings2.present?
      "■その他( #{trainings2.join(' / ')} )"
    else
      '▢その他（　　　　　　　　　　）'
    end
  end

  # 新規入場者調査票用（資格-特別教育-酸素欠乏危険作業枠）
  def worker_special_education_oxygen(worker)
    text = ['酸素欠乏（1種）', '酸素欠乏（2種）']
    (text & worker_special_education(worker).split).present? ? '■酸素欠乏危険作業' : '▢酸素欠乏危険作業'
  end

  # 新規入場者調査票用（資格-特別教育-電気取扱枠）
  def worker_special_education_electrical(worker)
    text = ['低圧電気取扱', '低圧電気取扱（開閉器の操作）', '高圧電気取扱', '特別高圧電気取扱']
    (text & worker_special_education(worker).split).present? ? '■電気取扱' : '▢電気取扱'
  end

  # 新規入場者調査票用（資格-特別教育-その他枠）
  def worker_special_education_other(worker)
    educations = worker&.content&.[]('worker_special_educations')

    unless educations.nil?
      educations = educations.map { |education| SpecialEducation.find(education['special_education_id']).name }
      educations.to_s.gsub(/,|"|\[|\]/) { '' }
      no_education =
        %w[酸素欠乏（1種） 酸素欠乏（2種） 小型車両系建設機械（整地・運搬・積込み用及び掘削用）（3t未満）
           小型車両系建設機械（基礎工事用）（3t未満） ローラー 車両系建設機械（コンクリート打設用）
           小型車両系建設機械（解体用）（3t未満） 不整地運搬車（1t未満） 高所作業車(10m未満）
           ボーリングマシン フォークリフト（1t未満） ショベルローダー（1t未満） 巻上げ機 建設用リフト
           玉掛け（1t未満） ゴンドラ アーク溶接 研削砥石 低圧電気取扱 低圧電気取扱（開閉器の操作） 高圧電気取扱
           特別高圧電気取扱 足場の組立て ロープ高所作業 フルハーネス型の墜落制止用器具]
      educations.delete_if do |e_work|
        no_education.include?(e_work)
      end
    end

    educations2 = educations
    if educations2.present?
      "■その他( #{educations2.join(' / ')} )"
    else
      '▢その他（　　　　　　　　　　）'
    end
  end

  # 新規入場者調査票用（アンケート設問：法人規模に関する内容-「はい」）
  def questionnaire_business_type_yes(worker)
    w_name = worker&.content&.[]('name')
    r_name = Business.find(document_info.business_id).representative_name
    if w_name == r_name
      status = Business.find(document_info.business_id).business_type_i18n
      status != '法人' ? tag.span('1. はい', class: :circle) : '1. はい'
    else
      '1. はい'
    end
  end

  # 新規入場者調査票用（アンケート設問：法人規模に関する内容-「いいえ」）
  def questionnaire_business_type_no(worker)
    w_name = worker&.content&.[]('name')
    r_name = Business.find(document_info.business_id).representative_name
    if w_name != r_name
      tag.span('2. いいえ', class: :circle)
    else
      status = Business.find(document_info.business_id).business_type_i18n
      status == '法人' ? tag.span('2. いいえ', class: :circle) : '2. いいえ'
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

  # (12)工事・通勤用車両届

  # 車両情報(工事･通勤)
  def car_usage_commute(usage)
    usage == '通勤用' ? tag.span('通勤', class: :circle) : '通勤'
  end

  def car_usage_const(usage)
    usage == '工事用' ? tag.span('工事', class: :circle) : '工事'
  end

  # (13)移動式クレーン/車両系建設機械等使用届

  # 特殊車両情報(自社･リース)
  def lease_type_own(type)
    type == 'own' ? tag.span('自社', class: :circle) : '自社'
  end

  def lease_type_lease(type)
    type == 'lease' ? tag.span('リース', class: :circle) : 'リース'
  end

  # 特殊車両情報(区分)
  def vehicle_type_crane(type)
    type == 'crane' ? tag.span('移動式クレーン', class: :circle) : tag.span('移動式クレーン', class: :line_through)
  end

  def vehicle_type_construction(type)
    type == 'construction' ? tag.span('車両系建設機械', class: :circle) : tag.span('車両系建設機械', class: :line_through)
  end

  # (15)有機溶剤・特定化学物質等持込使用届

  # 有機溶剤情報(使用期間)
  # date は必ず jisx0301 で変換できる値
  def wareki(date)
    wareki, mon, day = date.jisx0301.split('.')
    gengou, year = wareki.partition(/\d+/).take(2)
    gengou.sub!(
      /[MTSHR]/,
      'M' => '明治',
      'T' => '大正',
      'S' => '昭和',
      'H' => '平成',
      'R' => '令和'
    )
    "#{gengou}#{year.to_i}年#{mon.to_i}月#{day.to_i}日"
  end

  def field_solvent_working_process_y(working_process)
    working_process == 'y' ? tag.span('有', class: :circle) : '有'
  end

  def field_solvent_working_process_n(working_process)
    working_process == 'n' ? tag.span('無', class: :circle) : '無'
  end

  def field_solvent_sds_y(sds)
    sds == 'y' ? tag.span('有', class: :circle) : '有'
  end

  def field_solvent_sds_n(sds)
    sds == 'n' ? tag.span('無', class: :circle) : '無'
  end

  # (16)火気使用届

  # 現場火気情報(使用目的)
  def fire_use_target(name, num)
    fires = document_info.field_fires
    if fires.present?
      fires.first.fire_use_targets.map(&:id).include?(num) ? tag.span(name, class: :fire_check) : name
    else
      name
    end
  end

  # 現場火気情報(火気の種類)
  def fire_type(name, num)
    fires = document_info.field_fires
    if fires.present?
      fires.first.fire_types.map(&:id).include?(num) ? tag.span(name, class: :fire_check) : name
    else
      name
    end
  end

  # 現場火気情報(火気の管理方法)
  def fire_management(name, num)
    fires = document_info.field_fires
    if fires.present?
      fires.first.fire_managements.map(&:id).include?(num) ? tag.span(name, class: :fire_check) : name
    else
      name
    end
  end

  # (17)下請負業者編成表

  # 特定専門工事の有無(有･無)
  def professional_construction_yes(type)
    type == 'y' ? tag.span('有', class: :circle) : '有'
  end

  def professional_construction_no(type)
    type == 'n' ? tag.span('無', class: :circle) : '無'
  end

  # 二次下請会社情報
  def secondary_subcon_info(document_info, child_id)
    if document_info.instance_of?(Order)
      nil
    elsif document_info.child_ids[child_id].nil?
      nil
    else
      RequestOrder.find(document_info.child_ids[child_id])
    end
  end

  # 三次下請以下の会社情報
  def hierarchy_subcon_info(document_info, hierarchy, child_id) # hierarchyは階層の深さを指定する
    if document_info.instance_of?(Order)
      nil
    elsif document_info.find_all_by_generation(hierarchy).nil?
      nil
    elsif document_info.find_all_by_generation(hierarchy).ids[child_id]
      RequestOrder.find(document_info.find_all_by_generation(hierarchy).ids[child_id])
    end
  end

  # (13)移動式クレーン/車両系建設機械等使用届,(16)火気使用届,(17)下請負業者編成表

  # 一次下請会社名の情報
  def primary_subcon_info(document_info)
    if document_info.instance_of?(Order)
      nil
    elsif document_info.ancestors.count > 1
      RequestOrder.find(document_info.ancestor_ids[-2])
    elsif document_info.ancestors.count == 1
      document_info.content.nil? ? nil : document_info
    end
  end

  # 持込機械の機械名情報（持込時の点検表）
  def machine_tag_1st(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('アース線') ? '✔' : ''
    end
  end

  def machine_tag_2nd(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('接地クランプ') ? '✔' : ''
    end
  end

  def machine_tag_3rd(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('キャップタイヤ') ? '✔' : ''
    end
  end

  def machine_tag_4th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('コネクタ') ? '✔' : ''
    end
  end

  def machine_tag_5th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('接地端子の締結') ? '✔' : ''
    end
  end

  def machine_tag_6th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('充電部の絶縁') ? '✔' : ''
    end
  end

  def machine_tag_7th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('自動電撃防止装置') ? '✔' : ''
    end
  end

  def machine_tag_8th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('絶縁ホルダー') ? '✔' : ''
    end
  end

  def machine_tag_9th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('溶接保護面') ? '✔' : ''
    end
  end

  def machine_tag_10th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('操作スイッチ') ? '✔' : ''
    end
  end

  def machine_tag_11th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('絶縁抵抗測定値') ? '✔' : ''
    end
  end

  def machine_tag_12th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('各種ブレーキの作動') ? '✔' : ''
    end
  end

  def machine_tag_13th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('手すり・囲い') ? '✔' : ''
    end
  end

  def machine_tag_14th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('フックのはずれ止め') ? '✔' : ''
    end
  end

  def machine_tag_15th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('ワイヤロープ･チェーン') ? '✔' : ''
    end
  end

  def machine_tag_16th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('滑車') ? '✔' : ''
    end
  end

  def machine_tag_17th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('回転部の囲い等') ? '✔' : ''
    end
  end

  def machine_tag_18th(machine)
    tags = machine&.content&.[]('machine_tags')
    unless tags.nil?
      tags = tags.map { |tag| Tag.find(tag['tag_id']).name }
      tags.include?('危険表示') ? '✔' : ''
    end
  end

  # 持込時の点検表　「追加項目①〜⑥」点検事項
  def inspection_table_item1
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item1') }.compact_blank.first
  end

  def inspection_table_item2
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item2') }.compact_blank.first
  end

  def inspection_table_item3
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item3') }.compact_blank.first
  end

  def inspection_table_item4
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item4') }.compact_blank.first
  end

  def inspection_table_item5
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item5') }.compact_blank.first
  end

  def inspection_table_item6
    field_machines = FieldMachine.find(document_info.field_machine_ids)
    inspection_table_item1 = field_machines.map { |field_machine| FieldMachine.find(field_machine.id).content.[]('extra_inspection_item6') }.compact_blank.first
  end

  # 持込時の点検表　「追加項目①〜⑥」番号（機械名）
  def machine_extra_inspection_item1(machine, column)
    extra_item1 = machine&.content&.[](column)
    unless inspection_table_item2.nil?
      extra_item1 == inspection_table_item1 ? '✔' : ''
    end
  end

  def machine_extra_inspection_item2(machine, column)
    extra_item2 = machine&.content&.[](column)
    unless inspection_table_item2.nil?
      extra_item2 == inspection_table_item2 ? '✔' : ''
    end
  end

  def machine_extra_inspection_item3(machine, column)
    extra_item3 = machine&.content&.[](column)
    unless inspection_table_item3.nil?
      extra_item3 == inspection_table_item3 ? '✔' : ''
    end
  end

  def machine_extra_inspection_item4(machine, column)
    extra_item4 = machine&.content&.[](column)
    unless inspection_table_item4.nil?
      extra_item4 == inspection_table_item4 ? '✔' : ''
    end
  end

  def machine_extra_inspection_item5(machine, column)
    extra_item5 = machine&.content&.[](column)
    unless inspection_table_item5.nil?
      extra_item5 == inspection_table_item5 ? '✔' : ''
    end
  end

  def machine_extra_inspection_item6(machine, column)
    extra_item6 = machine&.content&.[](column)
    unless inspection_table_item6.nil?
      extra_item6 == inspection_table_item6 ? '✔' : ''
    end
  end

  # 持込機械の文字情報
  def machine_str(machine, column)
    machine&.content&.[](column)
  end

  # 持込機械の文字情報　（編集ページで入力、documentsに保存）
  def machine_doc_str(doc_str)
    doc_str.blank? ? '' : doc_str.first
  end

  # 持込機械の日付情報
  def machine_date(machine, column)
    date = machine&.content&.[](column)
    date.blank? ? '年　月　日' : l(date.to_date, format: :ja_kan)
  end

  # 持込機械の日付情報　（編集ページで入力、documentsに保存）
  def machine_doc_date(doc_date)
    unless doc_date.blank? # documentのcontentがない場合のエラー回避（編集ページ初回表示）
      doc_date.first.blank? ? '年　月　日' : l(doc_date.first.to_date, format: :ja_kan)
    else
      '年　月　日'
    end
  end

  # 現場機械情報の持込年月日
  def field_machine_carry_on_date(machine)
    date = machine&.carry_on_date
    date.blank? ? '年　月　日' : l(date.to_date, format: :ja_kan)
  end

  # 現場機械情報の搬出予定日
  def field_machine_carry_out_date(machine)
    date = machine&.carry_out_date
    date.blank? ? '年　月　日' : l(date.to_date, format: :ja_kan)
  end
end
