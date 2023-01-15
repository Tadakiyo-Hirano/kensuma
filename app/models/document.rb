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
  def error_msg_for_doc_20th(document_params)
    error_msg_for_doc_20th = []
    # 作成日
    error_msg_for_doc_20th.push('作成日を入力してください') if document_params[:content][:date_created].blank?
    # 年度
    # error_msg_for_doc_20th.push('年度を入力してください') if document_params[:content][:year].blank?
    # 始期
    # error_msg_for_doc_20th.push('始期を入力してください') if document_params[:content][:planning_period_beginning].blank?
    # 終期
    # if document_params[:content][:planning_period_final_stage].blank?
    # error_msg_for_doc_20th.push('終期を入力してください')
    # elsif (document_params[:content][:planning_period_final_stage] > ( document_params[:content][:planning_period_beginning] + 12 ))
    # error_msg_for_doc_20th.push('終期は始期から12ヶ月以内で入力してください')
    # else
    # nil
    # end
    # 安全衛生方針
    if document_params[:content][:health_and_safety_policy].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_policy].length > 300
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生目標
    if document_params[:content][:health_and_safety_goals].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_goals].length > 300
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生上の課題及び特定した危険性又は有害性
    error_msg_for_doc_20th.push('安全衛生上の課題及び特定した危険性又は有害性を入力してください') if document_params[:content][:health_and_safety_issues].length > 300
    # 重点施策1
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_1st].length > 50
    # 重点事項1
    error_msg_for_doc_20th.push('重点事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_1st].length > 50
    # 管理目標1
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_1st].length > 50
    # 実施担当1
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_1st].length > 50
    # 実施スケジュールと評価スケジュール（4月～6月）1
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_1st].length > 50
    # 実施スケジュールと評価スケジュール（7月～9月）1
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_1st].length > 50
    # 実施スケジュールと評価スケジュール（10月～12月）1
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_1st].length > 50
    # 実施スケジュールと評価スケジュール（1月～3月）1
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_1st].length > 50
    # 安全衛生計画・実施上の留意点1
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_1st].length > 50
    # 実施スケジュールと評価スケジュール（備考欄）1
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_1st].length > 50
    # 重点施策2
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_2nd].length > 50
    # 重点事項2
    error_msg_for_doc_20th.push('重点事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_2nd].length > 50
    # 管理目標2
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_2nd].length > 50
    # 実施担当2
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_2nd].length > 50
    # 実施スケジュールと評価スケジュール（4月～6月）2
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_2nd].length > 50
    # 実施スケジュールと評価スケジュール（7月～9月）2
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_2nd].length > 50
    # 実施スケジュールと評価スケジュール（10月～12月）2
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_2nd].length > 50
    # 実施スケジュールと評価スケジュール（1月～3月）2
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_2nd].length > 50
    # 安全衛生計画・実施上の留意点2
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_2nd].length > 50
    # 実施スケジュールと評価スケジュール（備考欄）2
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_2nd].length > 50
    # 重点施策3
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_3rd].length > 50
    # 重点事項3
    error_msg_for_doc_20th.push('重点事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_3rd].length > 50
    # 管理目標3
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_3rd].length > 50
    # 実施担当3
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_3rd].length > 50
    # 実施スケジュールと評価スケジュール（4月～6月）3
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_3rd].length > 50
    # 実施スケジュールと評価スケジュール（7月～9月）3
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_3rd].length > 50
    # 実施スケジュールと評価スケジュール（10月～12月）3
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_3rd].length > 50
    # 実施スケジュールと評価スケジュール（1月～3月）3
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_3rd].length > 50
    # 安全衛生計画・実施上の留意点3
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_3rd].length > 50
    # 実施スケジュールと評価スケジュール（備考欄）3
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_3rd].length > 50
    # 重点施策4
    error_msg_for_doc_20th.push('重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_4th].length > 50
    # 重点事項4
    error_msg_for_doc_20th.push('重点事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_4th].length > 50
    # 管理目標4
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_4th].length > 50
    # 実施担当4
    error_msg_for_doc_20th.push('管理目標を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_4th].length > 50
    # 実施スケジュールと評価スケジュール（4月～6月）4
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_april_june_4th].length > 50
    # 実施スケジュールと評価スケジュール（7月～9月）4
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_july_september_4th].length > 50
    # 実施スケジュールと評価スケジュール（10月～12月）4
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_october_december_4th].length > 50
    # 実施スケジュールと評価スケジュール（1月～3月）4
    error_msg_for_doc_20th.push('実施スケジュールを50字以内にしてください') if document_params[:content][:schedules_january_march_4th].length > 50
    # 安全衛生計画・実施上の留意点4
    error_msg_for_doc_20th.push('実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_4th].length > 50
    # 実施スケジュールと評価スケジュール（備考欄）4
    error_msg_for_doc_20th.push('評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_4th].length > 50
    # 作業所共通の重点対策1
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_1st].length > 30
    # 作業所共通の実施事項1_1
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_1st].length > 30
    # 作業所共通の実施事項1_2
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_2nd].length > 30
    # 作業所共通の実施事項1_3
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_3rd].length > 30
    # 作業所共通の重点対策2
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_2nd].length > 30
    # 作業所共通の実施事項2_1
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_1st].length > 30
    # 作業所共通の実施事項2_2
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_2nd].length > 30
    # 作業所共通の実施事項2_3
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_3rd].length > 30
    # 作業所共通の重点対策3
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_3rd].length > 30
    # 作業所共通の実施事項3_1
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_1st].length > 30
    # 作業所共通の実施事項3_2
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_2nd].length > 30
    # 作業所共通の実施事項3_3
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_3rd].length > 30
    # 作業所共通の重点対策4
    error_msg_for_doc_20th.push('重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_4th].length > 30
    # 作業所共通の実施事項4_1
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_1st].length > 30
    # 作業所共通の実施事項4_2
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_2nd].length > 30
    # 作業所共通の実施事項4_3
    error_msg_for_doc_20th.push('実施事項を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_3rd].length > 30
    # 安全衛生行事・4月
    error_msg_for_doc_20th.push('安全衛生行事(4月)を30字以内にしてください') if document_params[:content][:events_april].length > 30
    # 安全衛生行事・5月
    error_msg_for_doc_20th.push('安全衛生行事(5月)を30字以内にしてください') if document_params[:content][:events_may].length > 30
    # 安全衛生行事・6月
    error_msg_for_doc_20th.push('安全衛生行事(6月)を30字以内にしてください') if document_params[:content][:events_jun].length > 30
    # 安全衛生行事・7月
    error_msg_for_doc_20th.push('安全衛生行事(7月)を30字以内にしてください') if document_params[:content][:events_july].length > 30
    # 安全衛生行事・8月
    error_msg_for_doc_20th.push('安全衛生行事(8月)を30字以内にしてください') if document_params[:content][:events_august].length > 30
    # 安全衛生行事・9月
    error_msg_for_doc_20th.push('安全衛生行事(9月)を30字以内にしてください') if document_params[:content][:events_september].length > 30
    # 安全衛生行事・10月
    error_msg_for_doc_20th.push('安全衛生行事(10月)を30字以内にしてください') if document_params[:content][:events_october].length > 30
    # 安全衛生行事・11月
    error_msg_for_doc_20th.push('安全衛生行事(11月)を30字以内にしてください') if document_params[:content][:events_november].length > 30
    # 安全衛生行事・12月
    error_msg_for_doc_20th.push('安全衛生行事(12月)を30字以内にしてください') if document_params[:content][:events_december].length > 30
    # 安全衛生行事・1月
    error_msg_for_doc_20th.push('安全衛生行事(1月)を30字以内にしてください') if document_params[:content][:events_january].length > 30
    # 安全衛生行事・2月
    error_msg_for_doc_20th.push('安全衛生行事(2月)を30字以内にしてください') if document_params[:content][:events_february].length > 30
    # 安全衛生行事・3月
    error_msg_for_doc_20th.push('安全衛生行事(3月)を30字以内にしてください') if document_params[:content][:events_march].length > 30
    # 安全衛生担当役員名
    error_msg_for_doc_20th.push('安全衛生担当役員を選択してください') if document_params[:content][:safety_officer_name].blank?
    # 総括安全衛生管理者名
    error_msg_for_doc_20th.push('総括安全衛生管理者を選択してください') if document_params[:content][:general_manager_name].blank?
    # 安全管理者名
    error_msg_for_doc_20th.push('安全管理者を選択してください') if document_params[:content][:safety_manager_name].blank?
    # 衛生管理者名
    error_msg_for_doc_20th.push('衛生管理者を選択してください') if document_params[:content][:hygiene_manager_name].blank?
    # 安全衛生推進者名
    error_msg_for_doc_20th.push('安全衛生推進者を選択してください') if document_params[:content][:health_and_safety_promoter_name].blank?
    # 各会社の工事担当責任者名
    error_msg_for_doc_20th.push('工事担当責任者を選択してください') if document_params[:content][:construction_manager_name].blank?
    error_msg_for_doc_20th
  end

  # エラーメッセージ(工事安全衛生計画書用)
  def error_msg_for_doc_22nd(document_params)
    error_msg_for_doc_22nd = []
    # 職種
    if document_params[:content][:occupation_1st].blank?
      error_msg_for_doc_22nd.push('職種を入力してください')
    end
    error_msg_for_doc_22nd
  end
end
