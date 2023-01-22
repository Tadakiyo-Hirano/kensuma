class Document < ApplicationRecord
  OPERATABLE_DOC_TYPE = %w[
    cover_document table_of_contents_document doc_3rd doc_4th doc_5th doc_6th doc_7th doc_8th doc_9th doc_10th
    doc_11th doc_12th doc_13th doc_14th doc_15th doc_16th doc_17th doc_18th doc_19th doc_20th
    doc_21st doc_22nd doc_23rd doc_24th
  ].freeze
  belongs_to :business
  belongs_to :request_order

  before_create -> { self.uuid = SecureRandom.uuid }

  enum document_type: {
    cover_document:             1,  # 表紙
    table_of_contents_document: 2,  # 目次
    doc_3rd:                    3,  # 施工体制台帳作成建設工事の通知
    doc_4th:                    4,  # 全建統一様式第３号(施工体制台帳)
    doc_5th:                    5,  # 全建統一様式第３号(施工体制台帳)
    doc_6th:                    6,  # 安全衛生管理に関する契約書(一次会社用)
    doc_7th:                    7,  # 安全衛生管理に関する契約書(再下請会社用)
    doc_8th:                    8,  # 作業員名簿
    doc_9th:                    9,  # 全建統一様式第１号-甲-別紙(外国人建設就労者建設現場入場届出書)
    doc_10th:                   10, # 高年齢者作業申告書
    doc_11th:                   11, # 年少者就労報告書
    doc_12th:                   12, # 工事用・通勤用車両届
    doc_13th:                   13, # 全建統一様式第９号([移動式クレーン／車両系建設機械等]使用届)
    doc_14th:                   14, # 参考様式第６号(持込機械等(電動工具電気溶接機等)使用届
    doc_15th:                   15, # 全建統一様式第１１号(有機溶剤・特定化学物質等持込使用届)
    doc_16th:                   16, # 参考様式第９号(火気使用届)
    doc_17th:                   17, # 全建統一様式第１号－乙(下請負業者編成表)
    doc_18th:                   18, # 全建統一様式第４号(工事作業所災害防止協議会兼施工体系図)
    doc_19th:                   19, # 全建統一様式第６号(工事安全衛生計画書)
    doc_20th:                   20, # 参考様式第３号(年間安全衛生計画書)
    doc_21st:                   21, # 全建統一様式第７号(新規入場時等教育実施報告書)
    doc_22nd:                   22, # 参考様式第５号(作業間連絡調整書)
    doc_23rd:                   23, # 全建統一様式第８号(安全ミーティング報告書)
    doc_24th:                   24  # 参考資料第４号(新規入場者調査票)
  }

  def to_param
    uuid
  end

  # エラーメッセージ(年間安全衛生計画書)
  def error_msg_for_doc_20th(document_params, request_order_uuid, sub_request_order_uuid)
    error_msg_for_doc_20th = []
    # 作成日
    error_msg_for_doc_20th.push('作成日を入力してください') if document_params[:content][:date_created].blank?
    # 年度
    error_msg_for_doc_20th.push('年度を入力してください') if document_params[:content][:term].blank?
    # 始期
    error_msg_for_doc_20th.push('始期を入力してください') if document_params[:content][:planning_period_beginning].blank?
    # 終期
    $month_limit = 12
    if document_params[:content][:planning_period_final_stage].blank?
      error_msg_for_doc_20th.push('終期を入力してください')
    elsif (document_params[:content][:planning_period_beginning].present?) && (document_params[:content][:planning_period_final_stage].present?) && ((document_params[:content][:planning_period_final_stage].to_date) < ( document_params[:content][:planning_period_beginning].to_date ))
      error_msg_for_doc_20th.push('終期は始期より後日付を入力ください')
    elsif (document_params[:content][:planning_period_beginning].present?) && (document_params[:content][:planning_period_final_stage].present?) && ((document_params[:content][:planning_period_final_stage].to_date) > ( document_params[:content][:planning_period_beginning].to_date + $month_limit.month ))
      error_msg_for_doc_20th.push('終期は始期から12ヶ月以内で入力してください')
    else
      nil
    end
    # 安全衛生方針
    $character_limit = 300
    if document_params[:content][:health_and_safety_policy].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_policy].length > $character_limit
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生目標
    $character_limit = 300
    if document_params[:content][:health_and_safety_goals].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_goals].length > $character_limit
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生上の課題及び特定した危険性又は有害性
    $character_limit = 300
    error_msg_for_doc_20th.push('安全衛生上の課題及び特定した危険性又は有害性を300字以内にしてください') if document_params[:content][:health_and_safety_issues].length > $character_limit
    # 重点施策1
    $character_limit = 50
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_1st].length > $character_limit
    # 実施事項1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_1st].length > $character_limit
    # 管理目標1
    $character_limit = 50
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_1st].length > $character_limit
    # 実施担当1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_1st].length > $character_limit
    # 実施スケジュールと評価スケジュール（4月～6月）1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_1st].length > $character_limit
    # 実施スケジュールと評価スケジュール（7月～9月）1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_1st].length > $character_limit
    # 実施スケジュールと評価スケジュール（10月～12月）1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_1st].length > $character_limit
    # 実施スケジュールと評価スケジュール（1月～3月）1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_1st].length > $character_limit
    # 安全衛生計画・実施上の留意点1
    $character_limit = 50
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_1st].length > $character_limit
    # 実施スケジュールと評価スケジュール（備考欄）1
    $character_limit = 50
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_1st].length > $character_limit
    # 重点施策2
    $character_limit = 50
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_2nd].length > $character_limit
    # 実施事項2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_2nd].length > $character_limit
    # 管理目標2
    $character_limit = 50
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_2nd].length > $character_limit
    # 実施担当2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_2nd].length > $character_limit
    # 実施スケジュールと評価スケジュール（4月～6月）2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_2nd].length > $character_limit
    # 実施スケジュールと評価スケジュール（7月～9月）2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_2nd].length > $character_limit
    # 実施スケジュールと評価スケジュール（10月～12月）2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_2nd].length > $character_limit
    # 実施スケジュールと評価スケジュール（1月～3月）2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_2nd].length > $character_limit
    # 安全衛生計画・実施上の留意点2
    $character_limit = 50
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_2nd].length > $character_limit
    # 実施スケジュールと評価スケジュール（備考欄）2
    $character_limit = 50
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_2nd].length > $character_limit
    # 重点施策3
    $character_limit = 50
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_3rd].length > $character_limit
    # 実施事項3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_3rd].length > $character_limit
    # 管理目標3
    $character_limit = 50
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_3rd].length > $character_limit
    # 実施担当3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_3rd].length > $character_limit
    # 実施スケジュールと評価スケジュール（4月～6月）3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_3rd].length > $character_limit
    # 実施スケジュールと評価スケジュール（7月～9月）3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_3rd].length > $character_limit
    # 実施スケジュールと評価スケジュール（10月～12月）3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_3rd].length > $character_limit
    # 実施スケジュールと評価スケジュール（1月～3月）3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_3rd].length > $character_limit
    # 安全衛生計画・実施上の留意点3
    $character_limit = 50
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_3rd].length > $character_limit
    # 実施スケジュールと評価スケジュール（備考欄）3
    $character_limit = 50
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_3rd].length > $character_limit
    # 重点施策4
    $character_limit = 50
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_4th].length > $character_limit
    # 実施事項4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_4th].length > $character_limit
    # 管理目標4
    $character_limit = 50
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_4th].length > $character_limit
    # 実施担当4$character_limit = 50
    error_msg_for_doc_20th.push('実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_4th].length > $character_limit
    # 実施スケジュールと評価スケジュール（4月～6月）4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_4th].length > $character_limit
    # 実施スケジュールと評価スケジュール（7月～9月）4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_4th].length > $character_limit
    # 実施スケジュールと評価スケジュール（10月～12月）4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_4th].length > $character_limit
    # 実施スケジュールと評価スケジュール（1月～3月）4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_4th].length > $character_limit
    # 安全衛生計画・実施上の留意点4
    $character_limit = 50
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_4th].length > $character_limit
    # 実施スケジュールと評価スケジュール（備考欄）4
    $character_limit = 50
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_4th].length > $character_limit
    # 作業所共通の重点対策1
    $character_limit = 30
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_1st].length > $character_limit
    # 作業所共通の実施事項1_1
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_1st].length > $character_limit
    # 作業所共通の実施事項1_2
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_2nd].length > $character_limit
    # 作業所共通の実施事項1_3
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_3rd].length > $character_limit
    # 作業所共通の重点対策2
    $character_limit = 30
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_2nd].length > $character_limit
    # 作業所共通の実施事項2_1
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_1st].length > $character_limit
    # 作業所共通の実施事項2_2
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_2nd].length > $character_limit
    # 作業所共通の実施事項2_3
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_3rd].length > $character_limit
    # 作業所共通の重点対策3
    $character_limit = 30
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_3rd].length > $character_limit
    # 作業所共通の実施事項3_1
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_1st].length > $character_limit
    # 作業所共通の実施事項3_2
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_2nd].length > $character_limit
    # 作業所共通の実施事項3_3
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_3rd].length > $character_limit
    # 作業所共通の重点対策4
    $character_limit = 30
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_4th].length > $character_limit
    # 作業所共通の実施事項4_1
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_1st].length > $character_limit
    # 作業所共通の実施事項4_2
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_2nd].length > $character_limit
    # 作業所共通の実施事項4_3
    $character_limit = 30
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_3rd].length > $character_limit
    # 安全衛生行事・4月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(4月)を30字以内にしてください') if document_params[:content][:events_april].length > $character_limit
    # 安全衛生行事・5月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(5月)を30字以内にしてください') if document_params[:content][:events_may].length > $character_limit
    # 安全衛生行事・6月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(6月)を30字以内にしてください') if document_params[:content][:events_jun].length > $character_limit
    # 安全衛生行事・7月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(7月)を30字以内にしてください') if document_params[:content][:events_july].length > $character_limit
    # 安全衛生行事・8月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(8月)を30字以内にしてください') if document_params[:content][:events_august].length > $character_limit
    # 安全衛生行事・9月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(9月)を30字以内にしてください') if document_params[:content][:events_september].length > $character_limit
    # 安全衛生行事・10月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(10月)を30字以内にしてください') if document_params[:content][:events_october].length > $character_limit
    # 安全衛生行事・11月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(11月)を30字以内にしてください') if document_params[:content][:events_november].length > $character_limit
    # 安全衛生行事・12月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(12月)を30字以内にしてください') if document_params[:content][:events_december].length > $character_limit
    # 安全衛生行事・1月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(1月)を30字以内にしてください') if document_params[:content][:events_january].length > $character_limit
    # 安全衛生行事・2月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(2月)を30字以内にしてください') if document_params[:content][:events_february].length > $character_limit
    # 安全衛生行事・3月
    $character_limit = 30
    error_msg_for_doc_20th.push('安全衛生行事(3月)を30字以内にしてください') if document_params[:content][:events_march].length > $character_limit
    # 安全衛生担当役員名
    error_msg_for_doc_20th.push('安全衛生担当役員を選択してください') if document_params[:content][:safety_officer_name].blank?
    # 安全衛生担当役員名
    error_msg_for_doc_20th.push('安全衛生担当役員の役職を入力してください') if document_params[:content][:safety_officer_post].blank?
    # 総括安全衛生管理者名
    $worker_number_limit = 100
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $worker_number_limit) && (document_params[:content][:general_manager_name].blank?)
      error_msg_for_doc_20th.push('総括安全衛生管理者を選択してください')
    end
    # 安全管理者名
    $worker_number_limit = 50
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $worker_number_limit) && (document_params[:content][:safety_manager_namee].blank?)
      error_msg_for_doc_20th.push('安全管理者を選択してください')
    end
    # 衛生管理者名
    $worker_number_limit = 50
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $worker_number_limit) && (document_params[:content][:hygiene_manager_name].blank?)
      error_msg_for_doc_20th.push('衛生管理者を選択してください')
    end
    # 安全衛生推進者名
    $worker_number_limit1 = 10
    $worker_number_limit2 = 50
    if ((number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $worker_number_limit1) && ((number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid))) < $worker_number_limit2)) && (document_params[:content][:health_and_safety_promoter_name].blank?)
      error_msg_for_doc_20th.push('安全衛生推進者を選択してください')
    end
    # 特記事項
    $character_limit = 300
    error_msg_for_doc_20th.push('特記事項を300字以内にしてください') if document_params[:content][:remarks].length > $character_limit
    error_msg_for_doc_20th
  end

  #現場作業員の人数の取得
  def number_of_field_workers(order)
    request_order_id = RequestOrder.where(order_id: order.id)
    if FieldWorker.where(field_workerable_id: request_order_id).nil?
      number_of_prime_contractor = 0
    else
      number_of_prime_contractor = FieldWorker.where(field_workerable_id: request_order_id).count
    end
    if FieldWorker.where(field_workerable_type: RequestOrder).where(field_workerable_id: request_order_id).nil?
      number_of_primary_subcontractor = 0
    else
      number_of_primary_subcontractor = FieldWorker.where(field_workerable_type: RequestOrder).where(field_workerable_id: request_order_id).count
    end
    number_of_prime_contractor + number_of_primary_subcontractor
  end

  # 自身と、自身の階層下の現場情報(現場人数の取得がバリデーションで必要だったため)(doc_20th)
  def document_site_info(request_order_uuid, sub_request_order_uuid)
    request_order = RequestOrder.find_by(uuid: request_order_uuid)
    if sub_request_order_uuid
      RequestOrder.find_by(uuid: sub_request_order_uuid).order
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order.order
    end
  end

end
