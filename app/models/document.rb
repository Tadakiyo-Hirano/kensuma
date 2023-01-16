 # rubocop:disable all
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

  # エラーメッセージ(持込機械等(電動工具電気溶接機等)使用届)
  def error_msg_for_doc_14th(document_params)
    error_msg_for_doc_14th = []
    # 提出日
    if document_params[:content][:date_submitted].blank?
      error_msg_for_doc_14th.push('提出日を入力してください')
    end
    # 機械の特性、その他　その使用上注意すべき事項
    if document_params[:content][:precautions].blank?
      error_msg_for_doc_14th.push('機械の特性、その他　その使用上注意すべき事項を入力してください')
    elsif document_params[:content][:precautions].length > 300
      error_msg_for_doc_14th.push('機械の特性、その他　その使用上注意すべき事項を300字以内にしてください')
    else
      nil
    end
    # 元請会社の確認欄
    if document_params[:content][:prime_contractor_confirmation].blank?
      error_msg_for_doc_14th.push('元請会社の確認者名を入力してください')
    end
    # 元請会社の受付確認年月日
    if document_params[:content][:reception_confirmation_date].blank?
      error_msg_for_doc_14th.push('元請会社の受付確認年月日を入力してください')
    end
      error_msg_for_doc_14th
  end
 
  # # エラーメッセージ(工事安全衛生計画書用)
  # def error_msg_for_doc_19th(document_params)
  #   error_msg_for_doc_19th = []
  #   # 作成日
  #   if document_params[:content][:date_created].blank?
  #     error_msg_for_doc_19th.push('作成日を入力してください')
  #   end
  #   # 工事安全衛生方針
  #   if document_params[:content][:safety_and_health_construction_policy].blank?
  #     error_msg_for_doc_19th.push('工事安全衛生方針を記入してください')
  #   elsif document_params[:content][:safety_and_health_construction_policy].length > 300
  #     error_msg_for_doc_19th.push('工事安全衛生方針を300字以内にしてください')
  #   end
  #   # 工事安全衛生目標
  #   if document_params[:content][:safety_and_health_construction_objective].blank?
  #     error_msg_for_doc_19th.push('工事安全衛生目標を記入してください')
  #   elsif document_params[:content][:safety_and_health_construction_objective].length > 300
  #     error_msg_for_doc_19th.push('工事安全衛生目標を300字以内にしてください')
  #   end
  #   # 工種
  #   if document_params[:content][:construction_type_1st].length > 20
  #     error_msg_for_doc_19th.push('1つ目の工種を20文字以内にしてください')
  #   end
  #   # 日常の安全衛生活動
  #   if document_params[:content][:daily_safety_and_health_activity].length > 300
  #     error_msg_for_doc_19th.push('日常の安全衛生活動を300字以内にしてください')
  #   end
  #   # 主な使用機械設備
  #   if document_params[:content][:main_machine_equipment].length > 50
  #     error_msg_for_doc_19th.push('主な使用機械設備を50字以内にしてください')
  #   end
  #   # 主な使用機器・工具
  #   if document_params[:content][:main_tool].length > 50
  #     error_msg_for_doc_19th.push('主な使用機器・工具を50字以内にしてください')
  #   end
  #   # 主な使用資材枠
  #   if document_params[:content][:main_material].length > 50
  #     error_msg_for_doc_19th.push('主な使用資材枠を50字以内にしてください')
  #   end
  #   # 使用保護具
  #   if document_params[:content][:protective_equipment].length > 50
  #     error_msg_for_doc_19th.push('使用保護具を50字以内にしてください')
  #   end
  #   # 有資格者・配置予定者
  #   if document_params[:content][:qualified_staff].length > 50
  #     error_msg_for_doc_19th.push('有資格者・配置予定者を50字以内にしてください')
  #   end
  #   # 作業区分
  #   if document_params[:content][:work_classification_1st].length > 50
  #     error_msg_for_doc_19th.push('1つ目の作業区分を50字以内にしてください')
  #   end
  #   if document_params[:content][:work_classification_2nd].length > 50
  #     error_msg_for_doc_19th.push('2つ目の作業区分を50字以内にしてください')
  #   end
  #   if document_params[:content][:work_classification_3rd].length > 50
  #     error_msg_for_doc_19th.push('3つ目の作業区分を50字以内にしてください')
  #   end
  #   # 予測される災害（危険性又は有害性
  #   if document_params[:content][:predicted_disaster_1st].length > 50
  #     error_msg_for_doc_19th.push('1つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_2nd].length > 50
  #     error_msg_for_doc_19th.push('2つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_3rd].length > 50
  #     error_msg_for_doc_19th.push('3つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_4th].length > 50
  #     error_msg_for_doc_19th.push('4つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_5th].length > 50
  #     error_msg_for_doc_19th.push('5つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_6th].length > 50
  #     error_msg_for_doc_19th.push('6つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_7th].length > 50
  #     error_msg_for_doc_19th.push('7つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_8th].length > 50
  #     error_msg_for_doc_19th.push('8つ目の予測される災害を50字以内にしてください')
  #   end
  #   if document_params[:content][:predicted_disaster_8th].length > 50
  #     error_msg_for_doc_19th.push('8つ目の予測される災害を50字以内にしてください')
  #   end
  #   # リスク低減措置
  #   if document_params[:content][:risk_reduction_measures_1st].length > 200
  #     error_msg_for_doc_19th.push('1つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_2nd].length > 200
  #     error_msg_for_doc_19th.push('2つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_3rd].length > 200
  #     error_msg_for_doc_19th.push('3つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_4th].length > 200
  #     error_msg_for_doc_19th.push('4つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_5th].length > 200
  #     error_msg_for_doc_19th.push('5つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_6th].length > 200
  #     error_msg_for_doc_19th.push('6つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_7th].length > 200
  #     error_msg_for_doc_19th.push('7つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   if document_params[:content][:risk_reduction_measures_8th].length > 200
  #     error_msg_for_doc_19th.push('8つ目のリスク低減措置を200字以内にしてください')
  #   end
  #   # 職名
  #   if document_params[:content][:subcontractor_construction_workers_position_1st].length > 20
  #     error_msg_for_doc_19th.push('1つ目の職名を20字以内にしてください')
  #   end
  #   if document_params[:content][:subcontractor_construction_workers_position_2nd].length > 20
  #     error_msg_for_doc_19th.push('2つ目の職名を20字以内にしてください')
  #   end
  #   if document_params[:content][:subcontractor_construction_workers_position_3rd].length > 20
  #     error_msg_for_doc_19th.push('3つ目の職名を20字以内にしてください')
  #   end
  #   if document_params[:content][:subcontractor_construction_workers_position_4th].length > 20
  #     error_msg_for_doc_19th.push('4つ目の職名を20字以内にしてください')
  #   end
  #   if document_params[:content][:subcontractor_construction_workers_position_5th].length > 20
  #     error_msg_for_doc_19th.push('5つ目の職名を20字以内にしてください')
  #   end
  #   if document_params[:content][:subcontractor_construction_workers_position_6th].length > 20
  #     error_msg_for_doc_19th.push('6つ目の職名を20字以内にしてください')
  #   end
  #   # 工種の月が入力されているが週が入力されていない
  #   if document_params[:content][:construction_type_period_month_1st].present? &&
  #      document_params[:content][:construction_type_period_week_one_1st] == '0' &&
  #      document_params[:content][:construction_type_period_week_two_1st] == '0' &&
  #      document_params[:content][:construction_type_period_week_three_1st] == '0' &&
  #      document_params[:content][:construction_type_period_week_four_1st] == '0' &&
  #      document_params[:content][:construction_type_period_week_five_1st] == '0'
  #     error_msg_for_doc_19th.push('1列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
  #   end
  #   if document_params[:content][:construction_type_period_month_2nd].present? &&
  #      document_params[:content][:construction_type_period_week_one_2nd] == '0' &&
  #      document_params[:content][:construction_type_period_week_two_2nd] == '0' &&
  #      document_params[:content][:construction_type_period_week_three_2nd] == '0' &&
  #      document_params[:content][:construction_type_period_week_four_2nd] == '0' &&
  #      document_params[:content][:construction_type_period_week_five_2nd] == '0'
  #     error_msg_for_doc_19th.push('2列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
  #   end
  #   if document_params[:content][:construction_type_period_month_3rd].present? &&
  #      document_params[:content][:construction_type_period_week_one_3rd] == '0' &&
  #      document_params[:content][:construction_type_period_week_two_3rd] == '0' &&
  #      document_params[:content][:construction_type_period_week_three_3rd] == '0' &&
  #      document_params[:content][:construction_type_period_week_four_3rd] == '0' &&
  #      document_params[:content][:construction_type_period_week_five_3rd] == '0'
  #     error_msg_for_doc_19th.push('３列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
  #   end

  #   # 工種の週が入力されているが月が入力されていない
  #   if document_params[:content][:construction_type_period_month_1st].blank? &&
  #      (document_params[:content][:construction_type_period_week_one_1st] == '1' ||
  #      document_params[:content][:construction_type_period_week_two_1st] == '1'  ||
  #      document_params[:content][:construction_type_period_week_three_1st] == '1' ||
  #      document_params[:content][:construction_type_period_week_four_1st] == '1' ||
  #      document_params[:content][:construction_type_period_week_five_1st] == '1')
  #     error_msg_for_doc_19th.push('1列目の工種別工事期間の週が入力されているので月を入力してください')
  #   end
  #   if document_params[:content][:construction_type_period_month_2nd].blank? &&
  #      (document_params[:content][:construction_type_period_week_one_2nd] == '1' ||
  #      document_params[:content][:construction_type_period_week_two_2nd] == '1'  ||
  #      document_params[:content][:construction_type_period_week_three_2nd] == '1' ||
  #      document_params[:content][:construction_type_period_week_four_2nd] == '1' ||
  #      document_params[:content][:construction_type_period_week_five_2nd] == '1')
  #     error_msg_for_doc_19th.push('2列目の工種別工事期間の週が入力されているので月を入力してください')
  #   end
  #   if document_params[:content][:construction_type_period_month_3rd].blank? &&
  #      (document_params[:content][:construction_type_period_week_one_3rd] == '1' ||
  #      document_params[:content][:construction_type_period_week_two_3rd] == '1'  ||
  #      document_params[:content][:construction_type_period_week_three_3rd] == '1' ||
  #      document_params[:content][:construction_type_period_week_four_3rd] == '1' ||
  #      document_params[:content][:construction_type_period_week_five_3rd] == '1')
  #     error_msg_for_doc_19th.push('3列目の工種別工事期間の週が入力されているので月を入力してください')
  #   end
  #   # 1つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 週(月)が入力されていない場合
  #   if document_params[:content][:construction_type_1st].present? &&
  #      ((document_params[:content][:construction_type_period_month_1st].blank? &&
  #        document_params[:content][:construction_type_period_month_2nd].blank? &&
  #        document_params[:content][:construction_type_period_month_3rd].blank?) ||
  #       # 1つ目の工種の行が入力されていない場合
  #       (document_params[:content][:construction_type_1st_period_1st].blank? &&
  #         document_params[:content][:construction_type_1st_period_2nd].blank? &&
  #         document_params[:content][:construction_type_1st_period_3rd].blank?
  #       ))
  #     error_msg_for_doc_19th.push('1行目の工種が入力されているので工種期間を入力してください')
  #   end
  #   # 1つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 1つ目の工種の行が入力されていない場合
  #   if document_params[:content][:construction_type_1st].blank? &&
  #      (document_params[:content][:construction_type_1st_period_1st].present? ||
  #            document_params[:content][:construction_type_1st_period_2nd].present? ||
  #            document_params[:content][:construction_type_1st_period_3rd].present?)
  #     error_msg_for_doc_19th.push('1行目の工種期間が入力されているので工種を入力してください')
  #   end
  #   # 2つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 週(月)が入力されていない場合
  #   if document_params[:content][:construction_type_2nd].present? &&
  #      ((document_params[:content][:construction_type_period_month_1st].blank? &&
  #             document_params[:content][:construction_type_period_month_2nd].blank? &&
  #             document_params[:content][:construction_type_period_month_3rd].blank?) ||
  #            # 2つ目の工種の行が入力されていない場合
  #            (document_params[:content][:construction_type_2nd_period_1st].blank? &&
  #              document_params[:content][:construction_type_2nd_period_2nd].blank? &&
  #              document_params[:content][:construction_type_2nd_period_3rd].blank?
  #            ))
  #     error_msg_for_doc_19th.push('2行目の工種が入力されているので工種期間を入力してください')
  #   end
  #   # 2つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 2つ目の工種の行が入力されていない場合
  #   if document_params[:content][:construction_type_2nd].blank? &&
  #      (document_params[:content][:construction_type_2nd_period_1st].present? ||
  #            document_params[:content][:construction_type_2nd_period_2nd].present? ||
  #            document_params[:content][:construction_type_2nd_period_3rd].present?)
  #     error_msg_for_doc_19th.push('2行目の工種期間が入力されているので工種を入力してください')
  #   end
  #   # 3つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 週(月)が入力されていない場合
  #   if document_params[:content][:construction_type_3rd].present? &&
  #      ((document_params[:content][:construction_type_period_month_1st].blank? &&
  #             document_params[:content][:construction_type_period_month_2nd].blank? &&
  #             document_params[:content][:construction_type_period_month_3rd].blank?) ||
  #            # 2つ目の工種の行が入力されていない場合
  #            (document_params[:content][:construction_type_3rd_period_1st].blank? &&
  #              document_params[:content][:construction_type_3rd_period_2nd].blank? &&
  #              document_params[:content][:construction_type_3rd_period_3rd].blank?
  #            ))
  #     error_msg_for_doc_19th.push('3行目の工種が入力されているので工種期間を入力してください')
  #   end
  #   # 3つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 3つ目の工種の行が入力されていない場合
  #   if document_params[:content][:construction_type_3rd].blank? &&
  #      (document_params[:content][:construction_type_3rd_period_1st].present? ||
  #            document_params[:content][:construction_type_3rd_period_2nd].present? ||
  #            document_params[:content][:construction_type_3rd_period_3rd].present?)
  #     error_msg_for_doc_19th.push('3行目の工種期間が入力されているので工種を入力してください')
  #   end
  #   # 4つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 週(月)が入力されていない場合
  #   if document_params[:content][:construction_type_4th].present? &&
  #      ((document_params[:content][:construction_type_period_month_1st].blank? &&
  #             document_params[:content][:construction_type_period_month_2nd].blank? &&
  #             document_params[:content][:construction_type_period_month_3rd].blank?) ||
  #            # 4つ目の工種の行が入力されていない場合
  #            (document_params[:content][:construction_type_4th_period_1st].blank? &&
  #              document_params[:content][:construction_type_4th_period_2nd].blank? &&
  #              document_params[:content][:construction_type_4th_period_3rd].blank?
  #            ))
  #     error_msg_for_doc_19th.push('4行目の工種が入力されているので工種期間を入力してください')
  #   end
  #   # 4つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 3つ目の工種の行が入力されていない場合
  #   if document_params[:content][:construction_type_4th].blank? &&
  #      (document_params[:content][:construction_type_4th_period_1st].present? ||
  #            document_params[:content][:construction_type_4th_period_2nd].present? ||
  #            document_params[:content][:construction_type_4th_period_3rd].present?)
  #     error_msg_for_doc_19th.push('4行目の工種期間が入力されているので工種を入力してください')
  #   end
  #   # 5つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 週(月)が入力されていない場合
  #   if document_params[:content][:construction_type_5th].present? &&
  #      ((document_params[:content][:construction_type_period_month_1st].blank? &&
  #             document_params[:content][:construction_type_period_month_2nd].blank? &&
  #             document_params[:content][:construction_type_period_month_3rd].blank?) ||
  #            # 5つ目の工種の行が入力されていない場合
  #            (document_params[:content][:construction_type_5th_period_1st].blank? &&
  #              document_params[:content][:construction_type_5th_period_2nd].blank? &&
  #              document_params[:content][:construction_type_5th_period_3rd].blank?
  #            ))
  #     error_msg_for_doc_19th.push('5行目の工種が入力されているので工種期間を入力してください')
  #   end
  #   # 5つ目の工種の入力があるが工種別工事期間の入力がない場合
  #   # 3つ目の工種の行が入力されていない場合
  #   if document_params[:content][:construction_type_5th].blank? &&
  #      (document_params[:content][:construction_type_5th_period_1st].present? ||
  #            document_params[:content][:construction_type_5th_period_2nd].present? ||
  #            document_params[:content][:construction_type_5th_period_3rd].present?)
  #     error_msg_for_doc_19th.push('5行目の工種期間が入力されているので工種を入力してください')
  #   end
  #   # 1列目の月(週)が入力されているが２行目以降の期間が入力されていない
  #   if document_params[:content][:construction_type_period_month_1st].present? &&
  #      (document_params[:content][:construction_type_1st_period_1st].blank? &&
  #        document_params[:content][:construction_type_2nd_period_1st].blank? &&
  #        document_params[:content][:construction_type_3rd_period_1st].blank? &&
  #        document_params[:content][:construction_type_4th_period_1st].blank? &&
  #        document_params[:content][:construction_type_5th_period_1st].blank?)
  #     error_msg_for_doc_19th.push('1列目の月(週)が入力されているので2行目以降の期間を入力してください')
  #   end
  #   # 1列目の月(週)が入力されていないが２行目以降の期間が入力されている
  #   if document_params[:content][:construction_type_period_month_1st].blank? &&
  #      (document_params[:content][:construction_type_1st_period_1st].present? &&
  #        document_params[:content][:construction_type_2nd_period_1st].present? ||
  #        document_params[:content][:construction_type_3rd_period_1st].present? ||
  #        document_params[:content][:construction_type_4th_period_1st].present? ||
  #        document_params[:content][:construction_type_5th_period_1st].present?)
  #     error_msg_for_doc_19th.push('2行目以降の期間が入力されているので1列目の月(週)を入力してください')
  #   end
  #   # 2列目の月(週)が入力されているが２行目以降の期間が入力されていない
  #   if document_params[:content][:construction_type_period_month_2nd].present? &&
  #      (document_params[:content][:construction_type_1st_period_2nd].blank? &&
  #        document_params[:content][:construction_type_2nd_period_2nd].blank? &&
  #        document_params[:content][:construction_type_3rd_period_2nd].blank? &&
  #        document_params[:content][:construction_type_4th_period_2nd].blank? &&
  #        document_params[:content][:construction_type_5th_period_2nd].blank?)
  #     error_msg_for_doc_19th.push('2列目の月(週)が入力されているので2行目以降の期間を入力してください')
  #   end
  #   # 2列目の月(週)が入力されていないが２行目以降の期間が入力されている
  #   if document_params[:content][:construction_type_period_month_2nd].blank? &&
  #      (document_params[:content][:construction_type_1st_period_2nd].present? &&
  #        document_params[:content][:construction_type_2nd_period_2nd].present? ||
  #        document_params[:content][:construction_type_3rd_period_2nd].present? ||
  #        document_params[:content][:construction_type_4th_period_2nd].present? ||
  #        document_params[:content][:construction_type_5th_period_2nd].present?)
  #     error_msg_for_doc_19th.push('2行目以降の期間が入力されているので2列目の月(週)を入力してください')
  #   end
  #   # 3列目の月(週)が入力されているが２行目以降の期間が入力されていない
  #   if document_params[:content][:construction_type_period_month_3rd].present? &&
  #      (document_params[:content][:construction_type_1st_period_3rd].blank? &&
  #        document_params[:content][:construction_type_2nd_period_3rd].blank? &&
  #        document_params[:content][:construction_type_3rd_period_3rd].blank? &&
  #        document_params[:content][:construction_type_4th_period_3rd].blank? &&
  #        document_params[:content][:construction_type_5th_period_3rd].blank?)
  #     error_msg_for_doc_19th.push('３列目の月(週)が入力されているので2行目以降の期間を入力してください')
  #   end
  #   # ３列目の月(週)が入力されていないが２行目以降の期間が入力されている
  #   if document_params[:content][:construction_type_period_month_3rd].blank? &&
  #      (document_params[:content][:construction_type_1st_period_3rd].present? &&
  #        document_params[:content][:construction_type_2nd_period_3rd].present? ||
  #        document_params[:content][:construction_type_3rd_period_3rd].present? ||
  #        document_params[:content][:construction_type_4th_period_3rd].present? ||
  #        document_params[:content][:construction_type_5th_period_3rd].present?)
  #     error_msg_for_doc_19th.push('2行目以降の期間が入力されているので3列目の月(週)を入力してください')
  #   end
  #   # 1行目の作業が入力されているが1行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_1st].present? &&
  #      (document_params[:content][:predicted_disaster_1st].blank? ||
  #        document_params[:content][:risk_possibility_1st].blank? ||
  #        document_params[:content][:risk_reduction_measures_1st].blank?)
  #     error_msg_for_doc_19th.push('1行目の作業が入力されていますが、1行目の他項目で入力漏れがあります。')
  #   end
  #   # 1行目の作業以外の項目が入力されているが1行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_1st].blank? &&
  #      (document_params[:content][:predicted_disaster_1st].present? ||
  #        document_params[:content][:risk_possibility_1st].present? ||
  #        document_params[:content][:risk_reduction_measures_1st].present?)
  #     error_msg_for_doc_19th.push('1行目の作業を入力していください。')
  #   end
  #   # 2行目の作業が入力されているが2行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_2nd].present? &&
  #      (document_params[:content][:predicted_disaster_3rd].blank? ||
  #        document_params[:content][:risk_possibility_3rd].blank? ||
  #        document_params[:content][:risk_reduction_measures_3rd].blank?)
  #     error_msg_for_doc_19th.push('2行目の作業が入力されていますが、2行目の他項目で入力漏れがあります。')
  #   end
  #   # 2行目の作業以外の項目が入力されているが2行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_2nd].blank? &&
  #      (document_params[:content][:predicted_disaster_3rd].present? ||
  #        document_params[:content][:risk_possibility_3rd].present? ||
  #        document_params[:content][:risk_reduction_measures_3rd].present?)
  #     error_msg_for_doc_19th.push('2行目の作業が入力してください')
  #   end
  #   # 3行目の作業が入力されているが3行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_3rd].present? &&
  #      (document_params[:content][:predicted_disaster_6th].blank? ||
  #        document_params[:content][:risk_possibility_6th].blank? ||
  #        document_params[:content][:risk_reduction_measures_6th].blank?)
  #     error_msg_for_doc_19th.push('3行目の作業が入力されていますが、3行目の他項目で入力漏れがあります。')
  #   end
  #   # 3行目の作業以外の項目が入力されているが3行目の他項目に空欄がある場合
  #   if document_params[:content][:work_classification_3rd].blank? &&
  #      (document_params[:content][:predicted_disaster_6th].present? ||
  #        document_params[:content][:risk_possibility_6th].present? ||
  #        document_params[:content][:risk_reduction_measures_6th].present?)
  #     error_msg_for_doc_19th.push('3行目作業を入力してください。')
  #   end
  #   # 1行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_1st].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_1st].blank?
  #     error_msg_for_doc_19th.push('1行目の氏名を入力してください。')
  #   end
  #   # 1行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_1st].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_1st].present?
  #     error_msg_for_doc_19th.push('1行目の職名を入力してください。')
  #   end
  #   # 2行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_2nd].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_2nd].blank?
  #     error_msg_for_doc_19th.push('2行目の氏名を入力してください。')
  #   end
  #   # 2行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_2nd].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_2nd].present?
  #     error_msg_for_doc_19th.push('2行目の職名を入力してください。')
  #   end
  #   # 3行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_3rd].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_3rd].blank?
  #     error_msg_for_doc_19th.push('3行目の氏名を入力してください。')
  #   end
  #   # 3行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_3rd].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_3rd].present?
  #     error_msg_for_doc_19th.push('3行目の職名を入力してください。')
  #   end
  #   # 4行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_4th].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_4th].blank?
  #     error_msg_for_doc_19th.push('4行目の氏名を入力してください。')
  #   end
  #   # 4行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_4th].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_4th].present?
  #     error_msg_for_doc_19th.push('4行目の職名を入力してください。')
  #   end
  #   # 5行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_5th].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_5th].blank?
  #     error_msg_for_doc_19th.push('5行目の氏名を入力してください。')
  #   end
  #   # 5行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_5th].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_5th].present?
  #     error_msg_for_doc_19th.push('5行目の職名を入力してください。')
  #   end
  #   # 6行目の職名が入力されているが氏名が入力されていない場合
  #   if document_params[:content][:subcontractor_construction_workers_position_6th].present? &&
  #      document_params[:content][:subcontractor_construction_workers_name_6th].blank?
  #     error_msg_for_doc_19th.push('6行目の氏名を入力してください。')
  #   end
  #   # 6行目の職名が入力されていないが氏名が入力されている場合
  #   if document_params[:content][:subcontractor_construction_workers_position_6th].blank? &&
  #      document_params[:content][:subcontractor_construction_workers_name_6th].present?
  #     error_msg_for_doc_19th.push('6行目の職名を入力してください。')
  #   end
  #   # 1行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:carry_on_machine] == '1' &&
  #      document_params[:content][:use_notification].blank?
  #     error_msg_for_doc_19th.push('1行4列目の使用届の名前を入力してください')
  #   end
  #   # 1行4列目の使用届にチェックが入力されていないが名前が入っている場合
  #   if document_params[:content][:carry_on_machine] == '0' &&
  #      document_params[:content][:use_notification].present?
  #     error_msg_for_doc_19th.push('1行4列目の使用届のチェックをしてください')
  #   end
  #   # ３行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_1st] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_1st].blank?
  #     error_msg_for_doc_19th.push('3行4列目の使用届の名前を入力してください')
  #   end
  #   # ３行4列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_1st] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_1st].present?
  #     error_msg_for_doc_19th.push('3行4列目の使用届のチェックをしてください')
  #   end
  #   # 4行3列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_2nd] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_2nd].blank?
  #     error_msg_for_doc_19th.push('4行3列目の使用届の名前を入力してください')
  #   end
  #   # 4行3列目の使用届にチェックが入力されてないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_2nd] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_2nd].present?
  #     error_msg_for_doc_19th.push('4行3列目の使用届のチェックをしてください')
  #   end
  #   # 4行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_3rd] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_3rd].blank?
  #     error_msg_for_doc_19th.push('4行4列目の使用届の名前を入力してください')
  #   end
  #   # 4行4列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_3rd] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_3rd].present?
  #     error_msg_for_doc_19th.push('4行4列目の使用届のチェックをしてください')
  #   end
  #   # 5行1列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:work_plan_1st] == '1' &&
  #      document_params[:content][:work_plan_name_1st].blank?
  #     error_msg_for_doc_19th.push('5行1列目の使用届の名前を入力してください')
  #   end
  #   # 5行1列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:work_plan_1st] == '0' &&
  #      document_params[:content][:work_plan_name_1st].present?
  #     error_msg_for_doc_19th.push('5行1列目の使用届のチェックをしてください')
  #   end
  #   # 5行2列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:work_plan_2nd] == '1' &&
  #      document_params[:content][:work_plan_name_2nd].blank?
  #     error_msg_for_doc_19th.push('5行2列目の使用届の名前を入力してください')
  #   end
  #   # 5行2列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:work_plan_2nd] == '0' &&
  #      document_params[:content][:work_plan_name_2nd].present?
  #     error_msg_for_doc_19th.push('5行2列目の使用届のチェックをしてください')
  #   end
  #   # 5行3列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:work_plan_3rd] == '1' &&
  #      document_params[:content][:work_plan_name_3rd].blank?
  #     error_msg_for_doc_19th.push('5行3列目の使用届の名前を入力してください')
  #   end
  #   # 5行3列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:work_plan_3rd] == '0' &&
  #      document_params[:content][:work_plan_name_3rd].present?
  #     error_msg_for_doc_19th.push('5行3列目の使用届のチェックをしてください')
  #   end
  #   # 5行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:work_plan_4th] == '1' &&
  #      document_params[:content][:work_plan_name_4th].blank?
  #     error_msg_for_doc_19th.push('5行4列目の使用届の名前を入力してください')
  #   end
  #   # 5行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:work_plan_4th] == '0' &&
  #      document_params[:content][:work_plan_name_4th].present?
  #     error_msg_for_doc_19th.push('5行4列目の使用届のチェックをしてください')
  #   end
  #   # 6行2列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_4th] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_4th].blank?
  #     error_msg_for_doc_19th.push('6行2列目の作業計画の名前を入力してください')
  #   end
  #   # 6行2列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_4th] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_4th].present?
  #     error_msg_for_doc_19th.push('6行2列目の作業計画をチェックをしてください')
  #   end
  #   # 6行3列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_5th] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_5th].blank?
  #     error_msg_for_doc_19th.push('6行3列目の作業計画の名前を入力してください')
  #   end
  #   # 6行3列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_5th] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_5th].present?
  #     error_msg_for_doc_19th.push('6行3列目の作業計画をチェックをしてください')
  #   end
  #   # 6行4列目の使用届にチェックが入力されているが名前が入力されていない場合
  #   if document_params[:content][:use_notification_for_others_6th] == '1' &&
  #      document_params[:content][:use_notification_name_for_others_6th].blank?
  #     error_msg_for_doc_19th.push('6行4列目の作業計画の名前を入力してください')
  #   end
  #   # 6行4列目の使用届にチェックが入力されていないが名前が入力されている場合
  #   if document_params[:content][:use_notification_for_others_6th] == '0' &&
  #      document_params[:content][:use_notification_name_for_others_6th].present?
  #     error_msg_for_doc_19th.push('6行4列目の作業計画をチェックをしてください')
  #   end
  #   error_msg_for_doc_19th
  # end
  # # rubocop:enable all
end
