# rubocop:disable all
class Document < ApplicationRecord
  OPERATABLE_DOC_TYPE = %w[
    cover_document table_of_contents_document doc_3rd doc_4th doc_5th doc_6th doc_7th doc_8th doc_9th doc_10th
    doc_11th doc_12th doc_13rd doc_14th doc_15th doc_16th doc_17th doc_18th doc_19th doc_20th
    doc_21st doc_22nd doc_23rd doc_24th
  ].freeze
  belongs_to :business
  belongs_to :request_order

  before_create -> { self.uuid = SecureRandom.uuid }

  # 自身の書類一覧取得(自身が元請の場合、一次の場合、二次の場合、三次以降の場合)
  scope :genecon_documents_type, -> { where(document_type: [1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18, 19, 20, 21, 22, 23, 24]) }
  scope :first_subcon_documents_type, -> { where(document_type: [3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]) }
  scope :second_subcon_documents_type, -> { where(document_type: [3, 5, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 21, 22, 24]) }
  scope :third_or_later_subcon_documents_type, -> { where(document_type: [3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 21, 22, 24]) }
  # 元請け配下の一次下請け書類一覧取得
  scope :current_lower_first_documents_type, -> { where(document_type: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,  21, 22, 23, 24]) }
  # 一次下請け配下の二次下請け書類一覧取得
  scope :first_lower_second_documents_type, -> { where(document_type: [3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 21, 22, 24]) }
  # 二次下請け以降の配下の書類一覧取得(二次→三次、三次→四次)
  scope :lower_other_documents_type, -> { where(document_type: [3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 21, 22, 24]) }

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
    doc_10th:                   10, # 高齢者就労報告書
    doc_11th:                   11, # 年少者就労報告書
    doc_12th:                   12, # 工事用・通勤用車両届
    doc_13rd:                   13, # 全建統一様式第９号([移動式クレーン／車両系建設機械等]使用届)
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

  # 制限に関するグローバル変数(doc_20th)
  $MONTH_LIMIT = 11
  $CHARACTER_LIMIT300 = 300
  $CHARACTER_LIMIT50 = 50
  $CHARACTER_LIMIT30 = 30
  $CHARACTER_LIMIT20 = 20
  $WORKER_NUMBER_LIMIT100 = 100
  $WORKER_NUMBER_LIMIT50 = 50
  $WORKER_NUMBER_LIMIT10 = 10

  def to_param
    uuid
  end

  # エラーメッセージ(持込機械等(電動工具電気溶接機等)使用届用)
  def error_msg_for_doc_14th(document_params)
    if document_type == 'doc_14th'
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
      # 点検年月日
      if document_params[:content][:inspection_date].blank?
        error_msg_for_doc_14th.push('点検年月日を入力してください')
      end
        error_msg_for_doc_14th
    end
  end

  # エラーメッセージ(工事安全衛生計画書用)
  def error_msg_for_doc_19th(document_params)
    error_msg_for_doc_19th = []
    # 作成日
    if document_params[:content][:date_created].blank?
      error_msg_for_doc_19th.push('作成日を入力してください')
    end
    # 工事安全衛生方針
    if document_params[:content][:safety_and_health_construction_policy].blank?
      error_msg_for_doc_19th.push('工事安全衛生方針を記入してください')
    elsif document_params[:content][:safety_and_health_construction_policy].length > 300
      error_msg_for_doc_19th.push('工事安全衛生方針を300字以内にしてください')
    end
    # 工事安全衛生目標
    if document_params[:content][:safety_and_health_construction_objective].blank?
      error_msg_for_doc_19th.push('工事安全衛生目標を記入してください')
    elsif document_params[:content][:safety_and_health_construction_objective].length > 300
      error_msg_for_doc_19th.push('工事安全衛生目標を300字以内にしてください')
    end
    # 工種
    if document_params[:content][:construction_type_1st].length > 20
      error_msg_for_doc_19th.push('1つ目の工種を20文字以内にしてください')
    end
    # 日常の安全衛生活動
    if document_params[:content][:daily_safety_and_health_activity].length > 300
      error_msg_for_doc_19th.push('日常の安全衛生活動を300字以内にしてください')
    end
    # 主な使用機械設備
    if document_params[:content][:main_machine_equipment].length > 50
      error_msg_for_doc_19th.push('主な使用機械設備を50字以内にしてください')
    end
    # 主な使用機器・工具
    if document_params[:content][:main_tool].length > 50
      error_msg_for_doc_19th.push('主な使用機器・工具を50字以内にしてください')
    end
    # 主な使用資材枠
    if document_params[:content][:main_material].length > 50
      error_msg_for_doc_19th.push('主な使用資材枠を50字以内にしてください')
    end
    # 使用保護具
    if document_params[:content][:protective_equipment].length > 50
      error_msg_for_doc_19th.push('使用保護具を50字以内にしてください')
    end
    # 有資格者・配置予定者
    if document_params[:content][:qualified_staff].length > 50
      error_msg_for_doc_19th.push('有資格者・配置予定者を50字以内にしてください')
    end
    # 作業区分
    if document_params[:content][:work_classification_1st].length > 50
      error_msg_for_doc_19th.push('1つ目の作業区分を50字以内にしてください')
    end
    if document_params[:content][:work_classification_2nd].length > 50
      error_msg_for_doc_19th.push('2つ目の作業区分を50字以内にしてください')
    end
    if document_params[:content][:work_classification_3rd].length > 50
      error_msg_for_doc_19th.push('3つ目の作業区分を50字以内にしてください')
    end
    # 予測される災害（危険性又は有害性
    if document_params[:content][:predicted_disaster_1st].length > 50
      error_msg_for_doc_19th.push('1つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_2nd].length > 50
      error_msg_for_doc_19th.push('2つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_3rd].length > 50
      error_msg_for_doc_19th.push('3つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_4th].length > 50
      error_msg_for_doc_19th.push('4つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_5th].length > 50
      error_msg_for_doc_19th.push('5つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_6th].length > 50
      error_msg_for_doc_19th.push('6つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_7th].length > 50
      error_msg_for_doc_19th.push('7つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_8th].length > 50
      error_msg_for_doc_19th.push('8つ目の予測される災害を50字以内にしてください')
    end
    if document_params[:content][:predicted_disaster_8th].length > 50
      error_msg_for_doc_19th.push('8つ目の予測される災害を50字以内にしてください')
    end
    # リスク低減措置
    if document_params[:content][:risk_reduction_measures_1st].length > 200
      error_msg_for_doc_19th.push('1つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_2nd].length > 200
      error_msg_for_doc_19th.push('2つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_3rd].length > 200
      error_msg_for_doc_19th.push('3つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_4th].length > 200
      error_msg_for_doc_19th.push('4つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_5th].length > 200
      error_msg_for_doc_19th.push('5つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_6th].length > 200
      error_msg_for_doc_19th.push('6つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_7th].length > 200
      error_msg_for_doc_19th.push('7つ目のリスク低減措置を200字以内にしてください')
    end
    if document_params[:content][:risk_reduction_measures_8th].length > 200
      error_msg_for_doc_19th.push('8つ目のリスク低減措置を200字以内にしてください')
    end
    # 職名
    if document_params[:content][:subcontractor_construction_workers_position_1st].length > 20
      error_msg_for_doc_19th.push('1つ目の職名を20字以内にしてください')
    end
    if document_params[:content][:subcontractor_construction_workers_position_2nd].length > 20
      error_msg_for_doc_19th.push('2つ目の職名を20字以内にしてください')
    end
    if document_params[:content][:subcontractor_construction_workers_position_3rd].length > 20
      error_msg_for_doc_19th.push('3つ目の職名を20字以内にしてください')
    end
    if document_params[:content][:subcontractor_construction_workers_position_4th].length > 20
      error_msg_for_doc_19th.push('4つ目の職名を20字以内にしてください')
    end
    if document_params[:content][:subcontractor_construction_workers_position_5th].length > 20
      error_msg_for_doc_19th.push('5つ目の職名を20字以内にしてください')
    end
    if document_params[:content][:subcontractor_construction_workers_position_6th].length > 20
      error_msg_for_doc_19th.push('6つ目の職名を20字以内にしてください')
    end
    # 工種の月が入力されているが週が入力されていない
    if document_params[:content][:construction_type_period_month_1st].present? &&
       document_params[:content][:construction_type_period_week_one_1st] == '0' &&
       document_params[:content][:construction_type_period_week_two_1st] == '0' &&
       document_params[:content][:construction_type_period_week_three_1st] == '0' &&
       document_params[:content][:construction_type_period_week_four_1st] == '0' &&
       document_params[:content][:construction_type_period_week_five_1st] == '0'
      error_msg_for_doc_19th.push('1列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
    end
    if document_params[:content][:construction_type_period_month_2nd].present? &&
       document_params[:content][:construction_type_period_week_one_2nd] == '0' &&
       document_params[:content][:construction_type_period_week_two_2nd] == '0' &&
       document_params[:content][:construction_type_period_week_three_2nd] == '0' &&
       document_params[:content][:construction_type_period_week_four_2nd] == '0' &&
       document_params[:content][:construction_type_period_week_five_2nd] == '0'
      error_msg_for_doc_19th.push('2列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
    end
    if document_params[:content][:construction_type_period_month_3rd].present? &&
       document_params[:content][:construction_type_period_week_one_3rd] == '0' &&
       document_params[:content][:construction_type_period_week_two_3rd] == '0' &&
       document_params[:content][:construction_type_period_week_three_3rd] == '0' &&
       document_params[:content][:construction_type_period_week_four_3rd] == '0' &&
       document_params[:content][:construction_type_period_week_five_3rd] == '0'
      error_msg_for_doc_19th.push('３列目の工種別工事期間の月が入力されているので週のどれかを選択してください')
    end

    # 工種の週が入力されているが月が入力されていない
    if document_params[:content][:construction_type_period_month_1st].blank? &&
       (document_params[:content][:construction_type_period_week_one_1st] == '1' ||
       document_params[:content][:construction_type_period_week_two_1st] == '1'  ||
       document_params[:content][:construction_type_period_week_three_1st] == '1' ||
       document_params[:content][:construction_type_period_week_four_1st] == '1' ||
       document_params[:content][:construction_type_period_week_five_1st] == '1')
      error_msg_for_doc_19th.push('1列目の工種別工事期間の週が入力されているので月を入力してください')
    end
    if document_params[:content][:construction_type_period_month_2nd].blank? &&
       (document_params[:content][:construction_type_period_week_one_2nd] == '1' ||
       document_params[:content][:construction_type_period_week_two_2nd] == '1'  ||
       document_params[:content][:construction_type_period_week_three_2nd] == '1' ||
       document_params[:content][:construction_type_period_week_four_2nd] == '1' ||
       document_params[:content][:construction_type_period_week_five_2nd] == '1')
      error_msg_for_doc_19th.push('2列目の工種別工事期間の週が入力されているので月を入力してください')
    end
    if document_params[:content][:construction_type_period_month_3rd].blank? &&
       (document_params[:content][:construction_type_period_week_one_3rd] == '1' ||
       document_params[:content][:construction_type_period_week_two_3rd] == '1'  ||
       document_params[:content][:construction_type_period_week_three_3rd] == '1' ||
       document_params[:content][:construction_type_period_week_four_3rd] == '1' ||
       document_params[:content][:construction_type_period_week_five_3rd] == '1')
      error_msg_for_doc_19th.push('3列目の工種別工事期間の週が入力されているので月を入力してください')
    end
    # 1つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 週(月)が入力されていない場合
    if document_params[:content][:construction_type_1st].present? &&
       ((document_params[:content][:construction_type_period_month_1st].blank? &&
         document_params[:content][:construction_type_period_month_2nd].blank? &&
         document_params[:content][:construction_type_period_month_3rd].blank?) ||
        # 1つ目の工種の行が入力されていない場合
        (document_params[:content][:construction_type_1st_period_1st].blank? &&
          document_params[:content][:construction_type_1st_period_2nd].blank? &&
          document_params[:content][:construction_type_1st_period_3rd].blank?
        ))
      error_msg_for_doc_19th.push('1行目の工種が入力されているので工種期間を入力してください')
    end
    # 1つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 1つ目の工種の行が入力されていない場合
    if document_params[:content][:construction_type_1st].blank? &&
       (document_params[:content][:construction_type_1st_period_1st].present? ||
             document_params[:content][:construction_type_1st_period_2nd].present? ||
             document_params[:content][:construction_type_1st_period_3rd].present?)
      error_msg_for_doc_19th.push('1行目の工種期間が入力されているので工種を入力してください')
    end
    # 2つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 週(月)が入力されていない場合
    if document_params[:content][:construction_type_2nd].present? &&
       ((document_params[:content][:construction_type_period_month_1st].blank? &&
              document_params[:content][:construction_type_period_month_2nd].blank? &&
              document_params[:content][:construction_type_period_month_3rd].blank?) ||
             # 2つ目の工種の行が入力されていない場合
             (document_params[:content][:construction_type_2nd_period_1st].blank? &&
               document_params[:content][:construction_type_2nd_period_2nd].blank? &&
               document_params[:content][:construction_type_2nd_period_3rd].blank?
             ))
      error_msg_for_doc_19th.push('2行目の工種が入力されているので工種期間を入力してください')
    end
    # 2つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 2つ目の工種の行が入力されていない場合
    if document_params[:content][:construction_type_2nd].blank? &&
       (document_params[:content][:construction_type_2nd_period_1st].present? ||
             document_params[:content][:construction_type_2nd_period_2nd].present? ||
             document_params[:content][:construction_type_2nd_period_3rd].present?)
      error_msg_for_doc_19th.push('2行目の工種期間が入力されているので工種を入力してください')
    end
    # 3つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 週(月)が入力されていない場合
    if document_params[:content][:construction_type_3rd].present? &&
       ((document_params[:content][:construction_type_period_month_1st].blank? &&
              document_params[:content][:construction_type_period_month_2nd].blank? &&
              document_params[:content][:construction_type_period_month_3rd].blank?) ||
             # 2つ目の工種の行が入力されていない場合
             (document_params[:content][:construction_type_3rd_period_1st].blank? &&
               document_params[:content][:construction_type_3rd_period_2nd].blank? &&
               document_params[:content][:construction_type_3rd_period_3rd].blank?
             ))
      error_msg_for_doc_19th.push('3行目の工種が入力されているので工種期間を入力してください')
    end
    # 3つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 3つ目の工種の行が入力されていない場合
    if document_params[:content][:construction_type_3rd].blank? &&
       (document_params[:content][:construction_type_3rd_period_1st].present? ||
             document_params[:content][:construction_type_3rd_period_2nd].present? ||
             document_params[:content][:construction_type_3rd_period_3rd].present?)
      error_msg_for_doc_19th.push('3行目の工種期間が入力されているので工種を入力してください')
    end
    # 4つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 週(月)が入力されていない場合
    if document_params[:content][:construction_type_4th].present? &&
       ((document_params[:content][:construction_type_period_month_1st].blank? &&
              document_params[:content][:construction_type_period_month_2nd].blank? &&
              document_params[:content][:construction_type_period_month_3rd].blank?) ||
             # 4つ目の工種の行が入力されていない場合
             (document_params[:content][:construction_type_4th_period_1st].blank? &&
               document_params[:content][:construction_type_4th_period_2nd].blank? &&
               document_params[:content][:construction_type_4th_period_3rd].blank?
             ))
      error_msg_for_doc_19th.push('4行目の工種が入力されているので工種期間を入力してください')
    end
    # 4つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 3つ目の工種の行が入力されていない場合
    if document_params[:content][:construction_type_4th].blank? &&
       (document_params[:content][:construction_type_4th_period_1st].present? ||
             document_params[:content][:construction_type_4th_period_2nd].present? ||
             document_params[:content][:construction_type_4th_period_3rd].present?)
      error_msg_for_doc_19th.push('4行目の工種期間が入力されているので工種を入力してください')
    end
    # 5つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 週(月)が入力されていない場合
    if document_params[:content][:construction_type_5th].present? &&
       ((document_params[:content][:construction_type_period_month_1st].blank? &&
              document_params[:content][:construction_type_period_month_2nd].blank? &&
              document_params[:content][:construction_type_period_month_3rd].blank?) ||
             # 5つ目の工種の行が入力されていない場合
             (document_params[:content][:construction_type_5th_period_1st].blank? &&
               document_params[:content][:construction_type_5th_period_2nd].blank? &&
               document_params[:content][:construction_type_5th_period_3rd].blank?
             ))
      error_msg_for_doc_19th.push('5行目の工種が入力されているので工種期間を入力してください')
    end
    # 5つ目の工種の入力があるが工種別工事期間の入力がない場合
    # 3つ目の工種の行が入力されていない場合
    if document_params[:content][:construction_type_5th].blank? &&
       (document_params[:content][:construction_type_5th_period_1st].present? ||
             document_params[:content][:construction_type_5th_period_2nd].present? ||
             document_params[:content][:construction_type_5th_period_3rd].present?)
      error_msg_for_doc_19th.push('5行目の工種期間が入力されているので工種を入力してください')
    end
    # 1列目の月(週)が入力されているが２行目以降の期間が入力されていない
    if document_params[:content][:construction_type_period_month_1st].present? &&
       (document_params[:content][:construction_type_1st_period_1st].blank? &&
         document_params[:content][:construction_type_2nd_period_1st].blank? &&
         document_params[:content][:construction_type_3rd_period_1st].blank? &&
         document_params[:content][:construction_type_4th_period_1st].blank? &&
         document_params[:content][:construction_type_5th_period_1st].blank?)
      error_msg_for_doc_19th.push('1列目の月(週)が入力されているので2行目以降の期間を入力してください')
    end
    # 1列目の月(週)が入力されていないが２行目以降の期間が入力されている
    if document_params[:content][:construction_type_period_month_1st].blank? &&
       (document_params[:content][:construction_type_1st_period_1st].present? &&
         document_params[:content][:construction_type_2nd_period_1st].present? ||
         document_params[:content][:construction_type_3rd_period_1st].present? ||
         document_params[:content][:construction_type_4th_period_1st].present? ||
         document_params[:content][:construction_type_5th_period_1st].present?)
      error_msg_for_doc_19th.push('2行目以降の期間が入力されているので1列目の月(週)を入力してください')
    end
    # 2列目の月(週)が入力されているが２行目以降の期間が入力されていない
    if document_params[:content][:construction_type_period_month_2nd].present? &&
       (document_params[:content][:construction_type_1st_period_2nd].blank? &&
         document_params[:content][:construction_type_2nd_period_2nd].blank? &&
         document_params[:content][:construction_type_3rd_period_2nd].blank? &&
         document_params[:content][:construction_type_4th_period_2nd].blank? &&
         document_params[:content][:construction_type_5th_period_2nd].blank?)
      error_msg_for_doc_19th.push('2列目の月(週)が入力されているので2行目以降の期間を入力してください')
    end
    # 2列目の月(週)が入力されていないが２行目以降の期間が入力されている
    if document_params[:content][:construction_type_period_month_2nd].blank? &&
       (document_params[:content][:construction_type_1st_period_2nd].present? &&
         document_params[:content][:construction_type_2nd_period_2nd].present? ||
         document_params[:content][:construction_type_3rd_period_2nd].present? ||
         document_params[:content][:construction_type_4th_period_2nd].present? ||
         document_params[:content][:construction_type_5th_period_2nd].present?)
      error_msg_for_doc_19th.push('2行目以降の期間が入力されているので2列目の月(週)を入力してください')
    end
    # 3列目の月(週)が入力されているが２行目以降の期間が入力されていない
    if document_params[:content][:construction_type_period_month_3rd].present? &&
       (document_params[:content][:construction_type_1st_period_3rd].blank? &&
         document_params[:content][:construction_type_2nd_period_3rd].blank? &&
         document_params[:content][:construction_type_3rd_period_3rd].blank? &&
         document_params[:content][:construction_type_4th_period_3rd].blank? &&
         document_params[:content][:construction_type_5th_period_3rd].blank?)
      error_msg_for_doc_19th.push('３列目の月(週)が入力されているので2行目以降の期間を入力してください')
    end
    # ３列目の月(週)が入力されていないが２行目以降の期間が入力されている
    if document_params[:content][:construction_type_period_month_3rd].blank? &&
       (document_params[:content][:construction_type_1st_period_3rd].present? &&
         document_params[:content][:construction_type_2nd_period_3rd].present? ||
         document_params[:content][:construction_type_3rd_period_3rd].present? ||
         document_params[:content][:construction_type_4th_period_3rd].present? ||
         document_params[:content][:construction_type_5th_period_3rd].present?)
      error_msg_for_doc_19th.push('2行目以降の期間が入力されているので3列目の月(週)を入力してください')
    end
    # 1行目の作業が入力されているが1行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_1st].present? &&
       (document_params[:content][:predicted_disaster_1st].blank? ||
         document_params[:content][:risk_possibility_1st].blank? ||
         document_params[:content][:risk_reduction_measures_1st].blank?)
      error_msg_for_doc_19th.push('1行目の作業が入力されていますが、1行目の他項目で入力漏れがあります。')
    end
    # 1行目の作業以外の項目が入力されているが1行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_1st].blank? &&
       (document_params[:content][:predicted_disaster_1st].present? ||
         document_params[:content][:risk_possibility_1st].present? ||
         document_params[:content][:risk_reduction_measures_1st].present?)
      error_msg_for_doc_19th.push('1行目の作業を入力していください。')
    end
    # 2行目の作業が入力されているが2行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_2nd].present? &&
       (document_params[:content][:predicted_disaster_3rd].blank? ||
         document_params[:content][:risk_possibility_3rd].blank? ||
         document_params[:content][:risk_reduction_measures_3rd].blank?)
      error_msg_for_doc_19th.push('2行目の作業が入力されていますが、2行目の他項目で入力漏れがあります。')
    end
    # 2行目の作業以外の項目が入力されているが2行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_2nd].blank? &&
       (document_params[:content][:predicted_disaster_3rd].present? ||
         document_params[:content][:risk_possibility_3rd].present? ||
         document_params[:content][:risk_reduction_measures_3rd].present?)
      error_msg_for_doc_19th.push('2行目の作業が入力してください')
    end
    # 3行目の作業が入力されているが3行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_3rd].present? &&
       (document_params[:content][:predicted_disaster_6th].blank? ||
         document_params[:content][:risk_possibility_6th].blank? ||
         document_params[:content][:risk_reduction_measures_6th].blank?)
      error_msg_for_doc_19th.push('3行目の作業が入力されていますが、3行目の他項目で入力漏れがあります。')
    end
    # 3行目の作業以外の項目が入力されているが3行目の他項目に空欄がある場合
    if document_params[:content][:work_classification_3rd].blank? &&
       (document_params[:content][:predicted_disaster_6th].present? ||
         document_params[:content][:risk_possibility_6th].present? ||
         document_params[:content][:risk_reduction_measures_6th].present?)
      error_msg_for_doc_19th.push('3行目作業を入力してください。')
    end
    # 1行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_1st].present? &&
       document_params[:content][:subcontractor_construction_workers_name_1st].blank?
      error_msg_for_doc_19th.push('1行目の氏名を入力してください。')
    end
    # 1行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_1st].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_1st].present?
      error_msg_for_doc_19th.push('1行目の職名を入力してください。')
    end
    # 2行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_2nd].present? &&
       document_params[:content][:subcontractor_construction_workers_name_2nd].blank?
      error_msg_for_doc_19th.push('2行目の氏名を入力してください。')
    end
    # 2行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_2nd].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_2nd].present?
      error_msg_for_doc_19th.push('2行目の職名を入力してください。')
    end
    # 3行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_3rd].present? &&
       document_params[:content][:subcontractor_construction_workers_name_3rd].blank?
      error_msg_for_doc_19th.push('3行目の氏名を入力してください。')
    end
    # 3行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_3rd].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_3rd].present?
      error_msg_for_doc_19th.push('3行目の職名を入力してください。')
    end
    # 4行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_4th].present? &&
       document_params[:content][:subcontractor_construction_workers_name_4th].blank?
      error_msg_for_doc_19th.push('4行目の氏名を入力してください。')
    end
    # 4行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_4th].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_4th].present?
      error_msg_for_doc_19th.push('4行目の職名を入力してください。')
    end
    # 5行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_5th].present? &&
       document_params[:content][:subcontractor_construction_workers_name_5th].blank?
      error_msg_for_doc_19th.push('5行目の氏名を入力してください。')
    end
    # 5行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_5th].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_5th].present?
      error_msg_for_doc_19th.push('5行目の職名を入力してください。')
    end
    # 6行目の職名が入力されているが氏名が入力されていない場合
    if document_params[:content][:subcontractor_construction_workers_position_6th].present? &&
       document_params[:content][:subcontractor_construction_workers_name_6th].blank?
      error_msg_for_doc_19th.push('6行目の氏名を入力してください。')
    end
    # 6行目の職名が入力されていないが氏名が入力されている場合
    if document_params[:content][:subcontractor_construction_workers_position_6th].blank? &&
       document_params[:content][:subcontractor_construction_workers_name_6th].present?
      error_msg_for_doc_19th.push('6行目の職名を入力してください。')
    end
    # 1行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:carry_on_machine] == '1' &&
       document_params[:content][:use_notification].blank?
      error_msg_for_doc_19th.push('1行4列目の使用届の名前を入力してください')
    end
    # 1行4列目の使用届にチェックが入力されていないが名前が入っている場合
    if document_params[:content][:carry_on_machine] == '0' &&
       document_params[:content][:use_notification].present?
      error_msg_for_doc_19th.push('1行4列目の使用届のチェックをしてください')
    end
    # ３行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_1st] == '1' &&
       document_params[:content][:use_notification_name_for_others_1st].blank?
      error_msg_for_doc_19th.push('3行4列目の使用届の名前を入力してください')
    end
    # ３行4列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_1st] == '0' &&
       document_params[:content][:use_notification_name_for_others_1st].present?
      error_msg_for_doc_19th.push('3行4列目の使用届のチェックをしてください')
    end
    # 4行3列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_2nd] == '1' &&
       document_params[:content][:use_notification_name_for_others_2nd].blank?
      error_msg_for_doc_19th.push('4行3列目の使用届の名前を入力してください')
    end
    # 4行3列目の使用届にチェックが入力されてないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_2nd] == '0' &&
       document_params[:content][:use_notification_name_for_others_2nd].present?
      error_msg_for_doc_19th.push('4行3列目の使用届のチェックをしてください')
    end
    # 4行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_3rd] == '1' &&
       document_params[:content][:use_notification_name_for_others_3rd].blank?
      error_msg_for_doc_19th.push('4行4列目の使用届の名前を入力してください')
    end
    # 4行4列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_3rd] == '0' &&
       document_params[:content][:use_notification_name_for_others_3rd].present?
      error_msg_for_doc_19th.push('4行4列目の使用届のチェックをしてください')
    end
    # 5行1列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:work_plan_1st] == '1' &&
       document_params[:content][:work_plan_name_1st].blank?
      error_msg_for_doc_19th.push('5行1列目の使用届の名前を入力してください')
    end
    # 5行1列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:work_plan_1st] == '0' &&
       document_params[:content][:work_plan_name_1st].present?
      error_msg_for_doc_19th.push('5行1列目の使用届のチェックをしてください')
    end
    # 5行2列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:work_plan_2nd] == '1' &&
       document_params[:content][:work_plan_name_2nd].blank?
      error_msg_for_doc_19th.push('5行2列目の使用届の名前を入力してください')
    end
    # 5行2列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:work_plan_2nd] == '0' &&
       document_params[:content][:work_plan_name_2nd].present?
      error_msg_for_doc_19th.push('5行2列目の使用届のチェックをしてください')
    end
    # 5行3列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:work_plan_3rd] == '1' &&
       document_params[:content][:work_plan_name_3rd].blank?
      error_msg_for_doc_19th.push('5行3列目の使用届の名前を入力してください')
    end
    # 5行3列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:work_plan_3rd] == '0' &&
       document_params[:content][:work_plan_name_3rd].present?
      error_msg_for_doc_19th.push('5行3列目の使用届のチェックをしてください')
    end
    # 5行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:work_plan_4th] == '1' &&
       document_params[:content][:work_plan_name_4th].blank?
      error_msg_for_doc_19th.push('5行4列目の使用届の名前を入力してください')
    end
    # 5行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:work_plan_4th] == '0' &&
       document_params[:content][:work_plan_name_4th].present?
      error_msg_for_doc_19th.push('5行4列目の使用届のチェックをしてください')
    end
    # 6行2列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_4th] == '1' &&
       document_params[:content][:use_notification_name_for_others_4th].blank?
      error_msg_for_doc_19th.push('6行2列目の作業計画の名前を入力してください')
    end
    # 6行2列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_4th] == '0' &&
       document_params[:content][:use_notification_name_for_others_4th].present?
      error_msg_for_doc_19th.push('6行2列目の作業計画をチェックをしてください')
    end
    # 6行3列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_5th] == '1' &&
       document_params[:content][:use_notification_name_for_others_5th].blank?
      error_msg_for_doc_19th.push('6行3列目の作業計画の名前を入力してください')
    end
    # 6行3列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_5th] == '0' &&
       document_params[:content][:use_notification_name_for_others_5th].present?
      error_msg_for_doc_19th.push('6行3列目の作業計画をチェックをしてください')
    end
    # 6行4列目の使用届にチェックが入力されているが名前が入力されていない場合
    if document_params[:content][:use_notification_for_others_6th] == '1' &&
       document_params[:content][:use_notification_name_for_others_6th].blank?
      error_msg_for_doc_19th.push('6行4列目の作業計画の名前を入力してください')
    end
    # 6行4列目の使用届にチェックが入力されていないが名前が入力されている場合
    if document_params[:content][:use_notification_for_others_6th] == '0' &&
       document_params[:content][:use_notification_name_for_others_6th].present?
      error_msg_for_doc_19th.push('6行4列目の作業計画をチェックをしてください')
    end
    error_msg_for_doc_19th
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
    if document_params[:content][:planning_period_final_stage].blank?
      error_msg_for_doc_20th.push('終期を入力してください')
    elsif (document_params[:content][:planning_period_beginning].present?) && (document_params[:content][:planning_period_final_stage].present?) && ((document_params[:content][:planning_period_final_stage].to_date) < ( document_params[:content][:planning_period_beginning].to_date ))
      error_msg_for_doc_20th.push('終期は始期より後日付を入力ください')
    elsif (document_params[:content][:planning_period_beginning].present?) && (document_params[:content][:planning_period_final_stage].present?) && ((document_params[:content][:planning_period_final_stage].to_date) > ( document_params[:content][:planning_period_beginning].to_date + $MONTH_LIMIT.month ))
      error_msg_for_doc_20th.push('終期は始期から12ヶ月以内で入力してください')
    else
      nil
    end
    # 安全衛生方針
    if document_params[:content][:health_and_safety_policy].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_policy].length > $CHARACTER_LIMIT300
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生目標
    if document_params[:content][:health_and_safety_goals].blank?
      error_msg_for_doc_20th.push('安全衛生方針を入力してください')
    elsif document_params[:content][:health_and_safety_goals].length > $CHARACTER_LIMIT300
      error_msg_for_doc_20th.push('安全衛生方針を300字以内にしてください')
    end
    # 安全衛生上の課題及び特定した危険性又は有害性
    error_msg_for_doc_20th.push('安全衛生上の課題及び特定した危険性又は有害性を300字以内にしてください') if document_params[:content][:health_and_safety_issues].length > $CHARACTER_LIMIT300
    # 重点施策1
    error_msg_for_doc_20th.push('1行目の重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_1st].length > $CHARACTER_LIMIT50
    # 実施事項1
    error_msg_for_doc_20th.push('1行目の実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_1st].length > $CHARACTER_LIMIT50
    # 管理目標1
    error_msg_for_doc_20th.push('1行目の管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_1st].length > $CHARACTER_LIMIT50
    # 実施担当1
    error_msg_for_doc_20th.push('1行目の実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_1st].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（4月～6月）1
    error_msg_for_doc_20th.push('1行目の実施スケジュール（4月～6月）を50字以内にしてください') if document_params[:content][:schedules_april_june_1st].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（7月～9月）1
    error_msg_for_doc_20th.push('1行目の実施スケジュール（7月～9月）を50字以内にしてください') if document_params[:content][:schedules_july_september_1st].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（10月～12月）1
    error_msg_for_doc_20th.push('1行目の実施スケジュール（10月～12月）を50字以内にしてください') if document_params[:content][:schedules_october_december_1st].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（1月～3月）1
    error_msg_for_doc_20th.push('1行目の実施スケジュール（1月～3月）を50字以内にしてください') if document_params[:content][:schedules_january_march_1st].length > $CHARACTER_LIMIT50
    # 安全衛生計画・実施上の留意点1
    error_msg_for_doc_20th.push('1行目の実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_1st].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（備考欄）1
    error_msg_for_doc_20th.push('1行目の評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_1st].length > $CHARACTER_LIMIT50
    # 重点施策2
    error_msg_for_doc_20th.push('2行目の重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_2nd].length > $CHARACTER_LIMIT50
    # 実施事項2
    error_msg_for_doc_20th.push('2行目の実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_2nd].length > $CHARACTER_LIMIT50
    # 管理目標2
    error_msg_for_doc_20th.push('2行目の管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_2nd].length > $CHARACTER_LIMIT50
    # 実施担当2
    error_msg_for_doc_20th.push('2行目の実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_2nd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（4月～6月）2
    error_msg_for_doc_20th.push('2行目の実施スケジュール（4月～6月）を50字以内にしてください') if document_params[:content][:schedules_april_june_2nd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（7月～9月）2
    error_msg_for_doc_20th.push('2行目の実施スケジュール（7月～9月）を50字以内にしてください') if document_params[:content][:schedules_july_september_2nd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（10月～12月）2
    error_msg_for_doc_20th.push('2行目の実施スケジュール（10月～12月）を50字以内にしてください') if document_params[:content][:schedules_october_december_2nd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（1月～3月）2
    error_msg_for_doc_20th.push('2行目の実施スケジュール（1月～3月）を50字以内にしてください') if document_params[:content][:schedules_january_march_2nd].length > $CHARACTER_LIMIT50
    # 安全衛生計画・実施上の留意点2
    error_msg_for_doc_20th.push('2行目の実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_2nd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（備考欄）2
    error_msg_for_doc_20th.push('2行目の評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_2nd].length > $CHARACTER_LIMIT50
    # 重点施策3
    error_msg_for_doc_20th.push('3行目の重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_3rd].length > $CHARACTER_LIMIT50
    # 実施事項3
    error_msg_for_doc_20th.push('3行目の実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_3rd].length > $CHARACTER_LIMIT50
    # 管理目標3
    error_msg_for_doc_20th.push('3行目の管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_3rd].length > $CHARACTER_LIMIT50
    # 実施担当3
    error_msg_for_doc_20th.push('3行目の実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_3rd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（4月～6月）3
    error_msg_for_doc_20th.push('3行目の実施スケジュール（4月～6月）を50字以内にしてください') if document_params[:content][:schedules_april_june_3rd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（7月～9月）3
    error_msg_for_doc_20th.push('3行目の実施スケジュール（7月～9月）を50字以内にしてください') if document_params[:content][:schedules_july_september_3rd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（10月～12月）3
    error_msg_for_doc_20th.push('3行目の実施スケジュール（10月～12月）を50字以内にしてください') if document_params[:content][:schedules_october_december_3rd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（1月～3月）3
    error_msg_for_doc_20th.push('3行目の実施スケジュール（1月～3月）を50字以内にしてください') if document_params[:content][:schedules_january_march_3rd].length > $CHARACTER_LIMIT50
    # 安全衛生計画・実施上の留意点3
    error_msg_for_doc_20th.push('3行目の実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_3rd].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（備考欄）3
    error_msg_for_doc_20th.push('3行目の評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_3rd].length > $CHARACTER_LIMIT50
    # 重点施策4
    error_msg_for_doc_20th.push('4行目の重点施策を50字以内にしてください') if document_params[:content][:plan_priority_measures_4th].length > $CHARACTER_LIMIT50
    # 実施事項4
    error_msg_for_doc_20th.push('4行目の実施事項を50字以内にしてください') if document_params[:content][:plan_items_to_be_implemented_4th].length > $CHARACTER_LIMIT50
    # 管理目標4
    error_msg_for_doc_20th.push('4行目の管理目標を50字以内にしてください') if document_params[:content][:plan_management_goals_4th].length > $CHARACTER_LIMIT50
    # 実施担当4
    error_msg_for_doc_20th.push('4行目の実施担当を50字以内にしてください') if document_params[:content][:plan_responsible_for_implementation_4th].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（4月～6月）4
    error_msg_for_doc_20th.push('4行目の実施スケジュール（4月～6月）を50字以内にしてください') if document_params[:content][:schedules_april_june_4th].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（7月～9月）4
    error_msg_for_doc_20th.push('4行目の実施スケジュール（7月～9月）を50字以内にしてください') if document_params[:content][:schedules_july_september_4th].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（10月～12月）4
    error_msg_for_doc_20th.push('4行目の実施スケジュール（10月～12月）を50字以内にしてください') if document_params[:content][:schedules_october_december_4th].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（1月～3月）4
    error_msg_for_doc_20th.push('4行目の実施スケジュール（1月～3月）を50字以内にしてください') if document_params[:content][:schedules_january_march_4th].length > $CHARACTER_LIMIT50
    # 安全衛生計画・実施上の留意点4
    error_msg_for_doc_20th.push('4行目の実施上の留意点を50字以内にしてください') if document_params[:content][:schedules_points_to_note_4th].length > $CHARACTER_LIMIT50
    # 実施スケジュールと評価スケジュール（備考欄）4
    error_msg_for_doc_20th.push('4行目の評価スケジュールを50字以内にしてください') if document_params[:content][:schedules_remarks_4th].length > $CHARACTER_LIMIT50
    # 作業所共通の重点対策1
    error_msg_for_doc_20th.push('1つ目の重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_1st].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項1_1
    error_msg_for_doc_20th.push('1つ目の実施事項（1つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_1st].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項1_2
    error_msg_for_doc_20th.push('2つ目の実施事項（1つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_2nd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項1_3
    error_msg_for_doc_20th.push('3つ目の実施事項（1つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_1st_3rd].length > $CHARACTER_LIMIT30
    # 作業所共通の重点対策2
    error_msg_for_doc_20th.push('2つ目の重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_2nd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項2_1
    error_msg_for_doc_20th.push('1つ目の実施事項（2つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_1st].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項2_2
    error_msg_for_doc_20th.push('2つ目の実施事項（2つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_2nd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項2_3
    error_msg_for_doc_20th.push('3つ目の実施事項（2つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_2nd_3rd].length > $CHARACTER_LIMIT30
    # 作業所共通の重点対策3
    error_msg_for_doc_20th.push('3つ目の重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_3rd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項3_1
    error_msg_for_doc_20th.push('1つ目の実施事項（3つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_1st].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項3_2
    error_msg_for_doc_20th.push('2つ目の実施事項（3つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_2nd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項3_3
    error_msg_for_doc_20th.push('3つ目の実施事項（3つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_3rd_3rd].length > $CHARACTER_LIMIT30
    # 作業所共通の重点対策4
    error_msg_for_doc_20th.push('4つ目の重点対策を30字以内にしてください') if document_params[:content][:common_to_work_sitespriority_measures_4th].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項4_1
    error_msg_for_doc_20th.push('1つ目の実施事項（4つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_1st].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項4_2
    error_msg_for_doc_20th.push('2つ目の実施事項（4つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_2nd].length > $CHARACTER_LIMIT30
    # 作業所共通の実施事項4_3
    error_msg_for_doc_20th.push('3つ目の実施事項（4つ目の重点対策）を30字以内にしてください') if document_params[:content][:common_items_to_be_implemented_4th_3rd].length > $CHARACTER_LIMIT30
    # 安全衛生行事・4月
    error_msg_for_doc_20th.push('安全衛生行事(4月)を30字以内にしてください') if document_params[:content][:events_april].length > $CHARACTER_LIMIT30
    # 安全衛生行事・5月
    error_msg_for_doc_20th.push('安全衛生行事(5月)を30字以内にしてください') if document_params[:content][:events_may].length > $CHARACTER_LIMIT30
    # 安全衛生行事・6月
    error_msg_for_doc_20th.push('安全衛生行事(6月)を30字以内にしてください') if document_params[:content][:events_jun].length > $CHARACTER_LIMIT30
    # 安全衛生行事・7月
    error_msg_for_doc_20th.push('安全衛生行事(7月)を30字以内にしてください') if document_params[:content][:events_july].length > $CHARACTER_LIMIT30
    # 安全衛生行事・8月
    error_msg_for_doc_20th.push('安全衛生行事(8月)を30字以内にしてください') if document_params[:content][:events_august].length > $CHARACTER_LIMIT30
    # 安全衛生行事・9月
    error_msg_for_doc_20th.push('安全衛生行事(9月)を30字以内にしてください') if document_params[:content][:events_september].length > $CHARACTER_LIMIT30
    # 安全衛生行事・10月
    error_msg_for_doc_20th.push('安全衛生行事(10月)を30字以内にしてください') if document_params[:content][:events_october].length > $CHARACTER_LIMIT30
    # 安全衛生行事・11月
    error_msg_for_doc_20th.push('安全衛生行事(11月)を30字以内にしてください') if document_params[:content][:events_november].length > $CHARACTER_LIMIT30
    # 安全衛生行事・12月
    error_msg_for_doc_20th.push('安全衛生行事(12月)を30字以内にしてください') if document_params[:content][:events_december].length > $CHARACTER_LIMIT30
    # 安全衛生行事・1月
    error_msg_for_doc_20th.push('安全衛生行事(1月)を30字以内にしてください') if document_params[:content][:events_january].length > $CHARACTER_LIMIT30
    # 安全衛生行事・2月
    error_msg_for_doc_20th.push('安全衛生行事(2月)を30字以内にしてください') if document_params[:content][:events_february].length > $CHARACTER_LIMIT30
    # 安全衛生行事・3月
    error_msg_for_doc_20th.push('安全衛生行事(3月)を30字以内にしてください') if document_params[:content][:events_march].length > $CHARACTER_LIMIT30
    # 安全衛生担当役員名
    error_msg_for_doc_20th.push('安全衛生担当役員を選択してください') if document_params[:content][:safety_officer_name].blank?
    # 安全衛生担当役員名
    error_msg_for_doc_20th.push('安全衛生担当役員の役職を入力してください') if document_params[:content][:safety_officer_post].blank?
    # 総括安全衛生管理者名
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $WORKER_NUMBER_LIMIT100) && (document_params[:content][:general_manager_name].blank?)
      error_msg_for_doc_20th.push('総括安全衛生管理者を選択してください')
    end
    # 安全管理者名
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $WORKER_NUMBER_LIMIT50) && (document_params[:content][:safety_manager_name].blank?)
      error_msg_for_doc_20th.push('安全管理者を選択してください')
    end
    # 衛生管理者名
    if (number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $WORKER_NUMBER_LIMIT50) && (document_params[:content][:hygiene_manager_name].blank?)
      error_msg_for_doc_20th.push('衛生管理者を選択してください')
    end
    # 安全衛生推進者名
    if ((number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid)) >= $WORKER_NUMBER_LIMIT10) && ((number_of_field_workers(document_site_info(request_order_uuid, sub_request_order_uuid))) < $WORKER_NUMBER_LIMIT50)) && (document_params[:content][:health_and_safety_promoter_name].blank?)
      error_msg_for_doc_20th.push('安全衛生推進者を選択してください')
    end
    # 特記事項
    error_msg_for_doc_20th.push('特記事項を300字以内にしてください') if document_params[:content][:remarks].length > $CHARACTER_LIMIT300
    error_msg_for_doc_20th
  end

  #現場作業員の人数の取得(doc_20th)
  def number_of_field_workers(order)
    #元請の作業員の人数
    prime_contractor = FieldWorker.where(field_workerable_type: Order).where(field_workerable_id: order.id)
    prime_contractor.nil? ? number_of_prime_contractor = 0 : number_of_prime_contractor = prime_contractor.size
    #一次下請け以下の作業員の人数
    request_order = RequestOrder.where(order_id: order.id)
      array = []
      request_order.each do |record|
        array << record.id
      end
    number_of_primary_subcontractor = FieldWorker.where(field_workerable_type: RequestOrder).where("field_workerable_id IN (?)", array).size
    return (number_of_prime_contractor + number_of_primary_subcontractor)
  end

  # 自身と、自身の階層下の現場情報(現場人数の取得がバリデーションで必要だったため)(doc_20th)
  def document_site_info(request_order_uuid, sub_request_order_uuid)
    request_order = RequestOrder.find_by(uuid: request_order_uuid)
    if sub_request_order_uuid
      RequestOrder.find_by(uuid: sub_request_order_uuid).order
    else
      request_order.parent_id.nil? ? Order.find(request_order.order_id) : request_order
    end
  end

  # エラーメッセージ(持込機械等(電動工具電気溶接機等)使用届用)
  def error_msg_for_doc_21st(document_params)
    if document_type == 'doc_21st'
      error_msg_for_doc_21st = []
      # 確認者
      if document_params[:content][:prime_contractor_confirmation].blank?
        error_msg_for_doc_21st.push('確認者を入力してください')
      end
      # 提出日
      if document_params[:content][:date_submitted].blank?
        error_msg_for_doc_21st.push('提出日を入力してください')
      end
      # 教育の種類
      if (document_params[:content][:newly_entrance] == "0" ) &&
         ( document_params[:content][:employer_in] == "0" ) &&
         ( document_params[:content][:work_change] == "0" )
        error_msg_for_doc_21st.push('どれか一つをチェックしてください')
      end
      # 実施日付
      if document_params[:content][:date_implemented].blank?
        error_msg_for_doc_21st.push('実施日付を入力してください')
      end
      # 始時間
      if document_params[:content][:start_time].blank?
        error_msg_for_doc_21st.push('始時間を入力してください')
      end
      # 終時間
      if document_params[:content][:end_time].blank?
        error_msg_for_doc_21st.push('終時間を入力してください')
      end
      # 時間
      if document_params[:content][:implementation_time].blank?
        error_msg_for_doc_21st.push('時間を入力してください')
      end
      # 実施場所
      if document_params[:content][:location].blank?
        error_msg_for_doc_21st.push('実施場所を入力してください')
      elsif document_params[:content][:location].length > 50
        error_msg_for_doc_21st.push('実施場所を50字以内にしてください')
      else
        nil
      end
      # 教育方法
      if document_params[:content][:location].blank?
        error_msg_for_doc_21st.push('教育方法を入力してください')
      elsif document_params[:content][:location].length > 50
        error_msg_for_doc_21st.push('教育方法を50字以内にしてください')
      else
        nil
      end
      # 教育内容
      if document_params[:content][:education_content].blank?
        error_msg_for_doc_21st.push('教育内容を入力してください')
      elsif document_params[:content][:education_content].length > 500
        error_msg_for_doc_21st.push('教育内容を500字以内にしてください')
      else
        nil
      end
      # 講師の会社名
      if document_params[:content][:teachers_company].blank?
        error_msg_for_doc_21st.push('講師の会社名を入力してください')
      end
      # 講師名
      if document_params[:content][:teacher_name].blank?
        error_msg_for_doc_21st.push('講師名を入力してください')
      end
      # 受講者氏名
      if document_params[:content][:student_name].blank?
        error_msg_for_doc_21st.push('受講者氏名を入力してください')
      end
      # 資料
      if document_params[:content][:material].blank?
        error_msg_for_doc_21st.push('資料を入力してください')
      elsif document_params[:content][:material].length > 100
        error_msg_for_doc_21st.push('資料を100字以内にしてください')
      else
        nil
      end
        error_msg_for_doc_21st
    end
  end

  # エラーメッセージ(年間安全衛生計画書)
  def error_msg_for_doc_22nd(document_params, request_order_uuid)
    error_msg_for_doc_22nd = []
    #記録者
    error_msg_for_doc_22nd.push('記録者を選択してください') if document_params[:content][:recorder].blank?
    #安全当番者
    error_msg_for_doc_22nd.push('安全当番者を選択してください') if document_params[:content][:safety_duty_person].blank?
    #打合日
    error_msg_for_doc_22nd.push('打合日を入力してください') if document_params[:content][:meeting_date].blank?
    #実作業日
    error_msg_for_doc_22nd.push('実作業日を入力してください') if document_params[:content][:actual_work_date].blank?
    #職種1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:occupation_1st].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:occupation_1st].present?)
      error_msg_for_doc_22nd.push("1行目の職種は入力しないでください")
    end
    #必要資格1
    error_msg_for_doc_22nd.push("1行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:required_qualification_1st].present?)
    #作業内容1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:work_content_1st].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:work_content_1st].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:work_content_1st].present?)
      error_msg_for_doc_22nd.push("1行目の作業内容は入力しないでください")
    end
    #危険予測1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:risk_prediction_1st].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:risk_prediction_1st].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:risk_prediction_1st].present?)
      error_msg_for_doc_22nd.push("1行目の危険予測は入力しないでください")
    end
    #職長確認1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:foreman_confirmation_1st].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の職長確認を選択してください")
    end
    #実施の確認(良否)1
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:implementation_confirmation_1st].blank?)
    #実施の確認(良否)の確認者名1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:implementation_confirmation_person_1st].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:implementation_confirmation_person_1st].present?)
      error_msg_for_doc_22nd.push("1行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置1
    if ((subcontractor_array(request_order_uuid).slice(0)).present?) && (document_params[:content][:corrective_action_1st].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(0))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:corrective_action_1st].present?)
      error_msg_for_doc_22nd.push("1行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日1
    error_msg_for_doc_22nd.push("1行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:corrective_action_confirmation_date_1st].present?)
    #是正確認者1
    error_msg_for_doc_22nd.push("1行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(0)).blank?) && (document_params[:content][:corrective_action_reviewer_1st].present?)
    #職種2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:occupation_2nd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:occupation_2nd].present?)
      error_msg_for_doc_22nd.push("2行目の職種を入力しないでください")
    end
    #必要資格2
    error_msg_for_doc_22nd.push("2行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:required_qualification_2nd].present?)
    #作業内容2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:work_content_2nd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:work_content_2nd].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:work_content_2nd].present?)
      error_msg_for_doc_22nd.push("2行目の作業内容は入力しないでください")
    end
    #危険予測2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:risk_prediction_2nd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:risk_prediction_2nd].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:risk_prediction_2nd].present?)
      error_msg_for_doc_22nd.push("2行目の危険予測は入力しないでください")
    end
    #職長確認2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:foreman_confirmation_2nd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の職長確認を選択してください")
    end
    #実施の確認(良否)2
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:implementation_confirmation_2nd].blank?)
    #実施の確認(良否)の確認者名2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:implementation_confirmation_person_2nd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:implementation_confirmation_person_2nd].present?)
      error_msg_for_doc_22nd.push("2行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置2
    if ((subcontractor_array(request_order_uuid).slice(1)).present?) && (document_params[:content][:corrective_action_2nd].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(1))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:corrective_action_2nd].present?)
      error_msg_for_doc_22nd.push("2行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日2
    error_msg_for_doc_22nd.push("2行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:corrective_action_confirmation_date_2nd].present?)
    #是正確認者2
    error_msg_for_doc_22nd.push("2行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(1)).blank?) && (document_params[:content][:corrective_action_reviewer_2nd].present?)
    #職種3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:occupation_3rd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:occupation_3rd].present?)
      error_msg_for_doc_22nd.push("3行目の職種を入力しないでください")
    end
    #必要資格3
    error_msg_for_doc_22nd.push("3行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:required_qualification_3rd].present?)
    #作業内容3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:work_content_3rd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:work_content_3rd].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:work_content_3rd].present?)
      error_msg_for_doc_22nd.push("3行目の作業内容は入力しないでください")
    end
    #危険予測3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:risk_prediction_3rd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:risk_prediction_3rd].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:risk_prediction_3rd].present?)
      error_msg_for_doc_22nd.push("3行目の危険予測は入力しないでください")
    end
    #職長確認3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:foreman_confirmation_3rd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の職長確認を選択してください")
    end
    #実施の確認(良否)3
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:implementation_confirmation_3rd].blank?)
    #実施の確認(良否)の確認者名3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:implementation_confirmation_person_3rd].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:implementation_confirmation_person_3rd].present?)
      error_msg_for_doc_22nd.push("3行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置3
    if ((subcontractor_array(request_order_uuid).slice(2)).present?) && (document_params[:content][:corrective_action_3rd].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(2))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:corrective_action_3rd].present?)
      error_msg_for_doc_22nd.push("3行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日3
    error_msg_for_doc_22nd.push("3行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:corrective_action_confirmation_date_3rd].present?)
    #是正確認者3
    error_msg_for_doc_22nd.push("3行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(2)).blank?) && (document_params[:content][:corrective_action_reviewer_3rd].present?)
    #職種4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:occupation_4th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:occupation_4th].present?)
      error_msg_for_doc_22nd.push("4行目の職種を入力しないでください")
    end
    #必要資格4
    error_msg_for_doc_22nd.push("4行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:required_qualification_4th].present?)
    #作業内容4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:work_content_4th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:work_content_4th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:work_content_4th].present?)
      error_msg_for_doc_22nd.push("4行目の作業内容は入力しないでください")
    end
    #危険予測4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:risk_prediction_4th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:risk_prediction_4th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:risk_prediction_4th].present?)
      error_msg_for_doc_22nd.push("4行目の危険予測は入力しないでください")
    end
    #職長確認4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:foreman_confirmation_4th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の職長確認を選択してください")
    end
    #実施の確認(良否)4
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:implementation_confirmation_4th].blank?)
    #実施の確認(良否)の確認者名4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:implementation_confirmation_person_4th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:implementation_confirmation_person_4th].present?)
      error_msg_for_doc_22nd.push("4行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置4
    if ((subcontractor_array(request_order_uuid).slice(3)).present?) && (document_params[:content][:corrective_action_4th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(3))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:corrective_action_4th].present?)
      error_msg_for_doc_22nd.push("4行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日4
    error_msg_for_doc_22nd.push("4行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:corrective_action_confirmation_date_4th].present?)
    #是正確認者4
    error_msg_for_doc_22nd.push("4行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(3)).blank?) && (document_params[:content][:corrective_action_reviewer_4th].present?)
    #職種5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:occupation_5th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:occupation_5th].present?)
      error_msg_for_doc_22nd.push("5行目の職種を入力しないでください")
    end
    #必要資格5
    error_msg_for_doc_22nd.push("5行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:required_qualification_5th].present?)
    #作業内容5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:work_content_5th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:work_content_5th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:work_content_5th].present?)
      error_msg_for_doc_22nd.push("5行目の作業内容は入力しないでください")
    end
    #危険予測5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:risk_prediction_5th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:risk_prediction_5th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:risk_prediction_5th].present?)
      error_msg_for_doc_22nd.push("5行目の危険予測は入力しないでください")
    end
    #職長確認5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:foreman_confirmation_5th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の職長確認を選択してください")
    end
    #実施の確認(良否)5
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:implementation_confirmation_5th].blank?)
    #実施の確認(良否)の確認者名5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:implementation_confirmation_person_5th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:implementation_confirmation_person_5th].present?)
      error_msg_for_doc_22nd.push("5行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置5
    if ((subcontractor_array(request_order_uuid).slice(4)).present?) && (document_params[:content][:corrective_action_5th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(4))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:corrective_action_5th].present?)
      error_msg_for_doc_22nd.push("5行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日5
    error_msg_for_doc_22nd.push("5行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:corrective_action_confirmation_date_5th].present?)
    #是正確認者5
    error_msg_for_doc_22nd.push("5行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(4)).blank?) && (document_params[:content][:corrective_action_reviewer_5th].present?)
    #職種6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:occupation_6th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:occupation_6th].present?)
      error_msg_for_doc_22nd.push("6行目の職種を入力しないでください")
    end
    #必要資格6
    error_msg_for_doc_22nd.push("6行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:required_qualification_6th].present?)
    #作業内容6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:work_content_6th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:work_content_6th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:work_content_6th].present?)
      error_msg_for_doc_22nd.push("6行目の作業内容は入力しないでください")
    end
    #危険予測6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:risk_prediction_6th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:risk_prediction_6th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:risk_prediction_6th].present?)
      error_msg_for_doc_22nd.push("6行目の危険予測は入力しないでください")
    end
    #職長確認6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:foreman_confirmation_6th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の職長確認を選択してください")
    end
    #実施の確認(良否)6
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:implementation_confirmation_6th].blank?)
    #実施の確認(良否)の確認者名6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:implementation_confirmation_person_6th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:implementation_confirmation_person_6th].present?)
      error_msg_for_doc_22nd.push("6行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置6
    if ((subcontractor_array(request_order_uuid).slice(5)).present?) && (document_params[:content][:corrective_action_6th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(5))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:corrective_action_6th].present?)
      error_msg_for_doc_22nd.push("6行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日6
    error_msg_for_doc_22nd.push("6行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:corrective_action_confirmation_date_6th].present?)
    #是正確認者6
    error_msg_for_doc_22nd.push("6行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(5)).blank?) && (document_params[:content][:corrective_action_reviewer_6th].present?)
    #職種7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:occupation_7th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:occupation_7th].present?)
      error_msg_for_doc_22nd.push("7行目の職種を入力しないでください")
    end
    #必要資格7
    error_msg_for_doc_22nd.push("7行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:required_qualification_7th].present?)
    #作業内容7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:work_content_7th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:work_content_7th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:work_content_7th].present?)
      error_msg_for_doc_22nd.push("7行目の作業内容は入力しないでください")
    end
    #危険予測7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:risk_prediction_7th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:risk_prediction_7th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:risk_prediction_7th].present?)
      error_msg_for_doc_22nd.push("7行目の危険予測は入力しないでください")
    end
    #職長確認7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:foreman_confirmation_7th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の職長確認を選択してください")
    end
    #実施の確認(良否)7
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:implementation_confirmation_7th].blank?)
    #実施の確認(良否)の確認者名7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:implementation_confirmation_person_7th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:implementation_confirmation_person_7th].present?)
      error_msg_for_doc_22nd.push("7行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置7
    if ((subcontractor_array(request_order_uuid).slice(6)).present?) && (document_params[:content][:corrective_action_7th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(6))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:corrective_action_7th].present?)
      error_msg_for_doc_22nd.push("7行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日7
    error_msg_for_doc_22nd.push("7行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:corrective_action_confirmation_date_7th].present?)
    #是正確認者7
    error_msg_for_doc_22nd.push("7行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(6)).blank?) && (document_params[:content][:corrective_action_reviewer_7th].present?)
    #職種8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:occupation_8th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:occupation_8th].present?)
      error_msg_for_doc_22nd.push("8行目の職種を入力しないでください")
    end
    #必要資格8
    error_msg_for_doc_22nd.push("8行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:required_qualification_8th].present?)
    #作業内容8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:work_content_8th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:work_content_8th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:work_content_8th].present?)
      error_msg_for_doc_22nd.push("8行目の作業内容は入力しないでください")
    end
    #危険予測8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:risk_prediction_8th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:risk_prediction_8th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:risk_prediction_8th].present?)
      error_msg_for_doc_22nd.push("8行目の危険予測は入力しないでください")
    end
    #職長確認8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:foreman_confirmation_8th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の職長確認を選択してください")
    end
    #実施の確認(良否)8
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:implementation_confirmation_8th].blank?)
    #実施の確認(良否)の確認者名8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:implementation_confirmation_person_8th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:implementation_confirmation_person_8th].present?)
      error_msg_for_doc_22nd.push("8行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置8
    if ((subcontractor_array(request_order_uuid).slice(7)).present?) && (document_params[:content][:corrective_action_8th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(7))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:corrective_action_8th].present?)
      error_msg_for_doc_22nd.push("8行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日8
    error_msg_for_doc_22nd.push("8行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:corrective_action_confirmation_date_8th].present?)
    #是正確認者8
    error_msg_for_doc_22nd.push("8行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(7)).blank?) && (document_params[:content][:corrective_action_reviewer_8th].present?)
    #職種9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:occupation_9th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:occupation_9th].present?)
      error_msg_for_doc_22nd.push("9行目の職種を入力しないでください")
    end
    #必要資格9
    error_msg_for_doc_22nd.push("9行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:required_qualification_9th].present?)
    #作業内容9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:work_content_9th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:work_content_9th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:work_content_9th].present?)
      error_msg_for_doc_22nd.push("9行目の作業内容は入力しないでください")
    end
    #危険予測9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:risk_prediction_9th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:risk_prediction_9th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:risk_prediction_9th].present?)
      error_msg_for_doc_22nd.push("9行目の危険予測は入力しないでください")
    end
    #職長確認9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:foreman_confirmation_9th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の職長確認を選択してください")
    end
    #実施の確認(良否)9
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:implementation_confirmation_9th].blank?)
    #実施の確認(良否)の確認者名9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:implementation_confirmation_person_9th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:implementation_confirmation_person_9th].present?)
      error_msg_for_doc_22nd.push("9行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置9
    if ((subcontractor_array(request_order_uuid).slice(8)).present?) && (document_params[:content][:corrective_action_9th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(8))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:corrective_action_9th].present?)
      error_msg_for_doc_22nd.push("9行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日9
    error_msg_for_doc_22nd.push("9行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:corrective_action_confirmation_date_9th].present?)
    #是正確認者9
    error_msg_for_doc_22nd.push("9行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(8)).blank?) && (document_params[:content][:corrective_action_reviewer_9th].present?)
    #職種10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:occupation_10th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:occupation_10th].present?)
      error_msg_for_doc_22nd.push("10行目の職種を入力しないでください")
    end
    #必要資格10
    error_msg_for_doc_22nd.push("10行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:required_qualification_10th].present?)
    #作業内容10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:work_content_10th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:work_content_10th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:work_content_10th].present?)
      error_msg_for_doc_22nd.push("10行目の作業内容は入力しないでください")
    end
    #危険予測10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:risk_prediction_10th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:risk_prediction_10th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:risk_prediction_10th].present?)
      error_msg_for_doc_22nd.push("10行目の危険予測は入力しないでください")
    end
    #職長確認10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:foreman_confirmation_10th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の職長確認を選択してください")
    end
    #実施の確認(良否)10
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:implementation_confirmation_10th].blank?)
    #実施の確認(良否)の確認者名10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:implementation_confirmation_person_10th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:implementation_confirmation_person_10th].present?)
      error_msg_for_doc_22nd.push("10行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置10
    if ((subcontractor_array(request_order_uuid).slice(9)).present?) && (document_params[:content][:corrective_action_10th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(9))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:corrective_action_10th].present?)
      error_msg_for_doc_22nd.push("10行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日10
    error_msg_for_doc_22nd.push("10行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:corrective_action_confirmation_date_10th].present?)
    #是正確認者10
    error_msg_for_doc_22nd.push("10行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(9)).blank?) && (document_params[:content][:corrective_action_reviewer_10th].present?)
    #職種11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:occupation_11th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:occupation_11th].present?)
      error_msg_for_doc_22nd.push("11行目の職種を入力しないでください")
    end
    #必要資格11
    error_msg_for_doc_22nd.push("11行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:required_qualification_11th].present?)
    #作業内容11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:work_content_11th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:work_content_11th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:work_content_11th].present?)
      error_msg_for_doc_22nd.push("11行目の作業内容は入力しないでください")
    end
    #危険予測11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:risk_prediction_11th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:risk_prediction_11th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:risk_prediction_11th].present?)
      error_msg_for_doc_22nd.push("11行目の危険予測は入力しないでください")
    end
    #職長確認11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:foreman_confirmation_11th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の職長確認を選択してください")
    end
    #実施の確認(良否)11
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:implementation_confirmation_11th].blank?)
    #実施の確認(良否)の確認者名11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:implementation_confirmation_person_11th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:implementation_confirmation_person_11th].present?)
      error_msg_for_doc_22nd.push("11行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置11
    if ((subcontractor_array(request_order_uuid).slice(10)).present?) && (document_params[:content][:corrective_action_11th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(10))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:corrective_action_11th].present?)
      error_msg_for_doc_22nd.push("11行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日11
    error_msg_for_doc_22nd.push("11行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:corrective_action_confirmation_date_11th].present?)
    #是正確認者11
    error_msg_for_doc_22nd.push("11行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(10)).blank?) && (document_params[:content][:corrective_action_reviewer_11th].present?)
    #職種12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:occupation_12th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:occupation_12th].present?)
      error_msg_for_doc_22nd.push("12行目の職種を入力しないでください")
    end
    #必要資格12
    error_msg_for_doc_22nd.push("12行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:required_qualification_12th].present?)
    #作業内容12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:work_content_12th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:work_content_12th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:work_content_12th].present?)
      error_msg_for_doc_22nd.push("12行目の作業内容は入力しないでください")
    end
    #危険予測12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:risk_prediction_12th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:risk_prediction_12th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:risk_prediction_12th].present?)
      error_msg_for_doc_22nd.push("12行目の危険予測は入力しないでください")
    end
    #職長確認12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:foreman_confirmation_12th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の職長確認を選択してください")
    end
    #実施の確認(良否)12
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:implementation_confirmation_12th].blank?)
    #実施の確認(良否)の確認者名12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:implementation_confirmation_person_12th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:implementation_confirmation_person_12th].present?)
      error_msg_for_doc_22nd.push("12行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置12
    if ((subcontractor_array(request_order_uuid).slice(11)).present?) && (document_params[:content][:corrective_action_12th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(11))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:corrective_action_12th].present?)
      error_msg_for_doc_22nd.push("12行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日12
    error_msg_for_doc_22nd.push("12行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:corrective_action_confirmation_date_12th].present?)
    #是正確認者12
    error_msg_for_doc_22nd.push("12行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(11)).blank?) && (document_params[:content][:corrective_action_reviewer_12th].present?)
    #職種13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:occupation_13th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:occupation_13th].present?)
      error_msg_for_doc_22nd.push("13行目の職種を入力しないでください")
    end
    #必要資格13
    error_msg_for_doc_22nd.push("13行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:required_qualification_13th].present?)
    #作業内容13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:work_content_13th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:work_content_13th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:work_content_13th].present?)
      error_msg_for_doc_22nd.push("13行目の作業内容は入力しないでください")
    end
    #危険予測13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:risk_prediction_13th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:risk_prediction_13th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:risk_prediction_13th].present?)
      error_msg_for_doc_22nd.push("13行目の危険予測は入力しないでください")
    end
    #職長確認13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:foreman_confirmation_13th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の職長確認を選択してください")
    end
    #実施の確認(良否)13
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:implementation_confirmation_13th].blank?)
    #実施の確認(良否)の確認者名13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:implementation_confirmation_person_13th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:implementation_confirmation_person_13th].present?)
      error_msg_for_doc_22nd.push("13行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置13
    if ((subcontractor_array(request_order_uuid).slice(12)).present?) && (document_params[:content][:corrective_action_13th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(12))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:corrective_action_13th].present?)
      error_msg_for_doc_22nd.push("13行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日13
    error_msg_for_doc_22nd.push("13行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:corrective_action_confirmation_date_13th].present?)
    #是正確認者13
    error_msg_for_doc_22nd.push("13行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(12)).blank?) && (document_params[:content][:corrective_action_reviewer_13th].present?)
    #職種14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:occupation_14th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:occupation_14th].present?)
      error_msg_for_doc_22nd.push("14行目の職種を入力しないでください")
    end
    #必要資格14
    error_msg_for_doc_22nd.push("14行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:required_qualification_14th].present?)
    #作業内容14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:work_content_14th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:work_content_14th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:work_content_14th].present?)
      error_msg_for_doc_22nd.push("14行目の作業内容は入力しないでください")
    end
    #危険予測14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:risk_prediction_14th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:risk_prediction_14th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:risk_prediction_14th].present?)
      error_msg_for_doc_22nd.push("14行目の危険予測は入力しないでください")
    end
    #職長確認14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:foreman_confirmation_14th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の職長確認を選択してください")
    end
    #実施の確認(良否)14
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:implementation_confirmation_14th].blank?)
    #実施の確認(良否)の確認者名14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:implementation_confirmation_person_14th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:implementation_confirmation_person_14th].present?)
      error_msg_for_doc_22nd.push("14行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置14
    if ((subcontractor_array(request_order_uuid).slice(13)).present?) && (document_params[:content][:corrective_action_14th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(13))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:corrective_action_14th].present?)
      error_msg_for_doc_22nd.push("14行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日14
    error_msg_for_doc_22nd.push("14行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:corrective_action_confirmation_date_14th].present?)
    #是正確認者14
    error_msg_for_doc_22nd.push("14行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(13)).blank?) && (document_params[:content][:corrective_action_reviewer_14th].present?)
    #職種15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:occupation_15th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:occupation_15th].present?)
      error_msg_for_doc_22nd.push("15行目の職種を入力しないでください")
    end
    #必要資格15
    error_msg_for_doc_22nd.push("15行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:required_qualification_15th].present?)
    #作業内容15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:work_content_15th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:work_content_15th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:work_content_15th].present?)
      error_msg_for_doc_22nd.push("15行目の作業内容は入力しないでください")
    end
    #危険予測15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:risk_prediction_15th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:risk_prediction_15th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:risk_prediction_15th].present?)
      error_msg_for_doc_22nd.push("15行目の危険予測は入力しないでください")
    end
    #職長確認15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:foreman_confirmation_15th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の職長確認を選択してください")
    end
    #実施の確認(良否)15
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:implementation_confirmation_15th].blank?)
    #実施の確認(良否)の確認者名15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:implementation_confirmation_person_15th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:implementation_confirmation_person_15th].present?)
      error_msg_for_doc_22nd.push("15行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置15
    if ((subcontractor_array(request_order_uuid).slice(14)).present?) && (document_params[:content][:corrective_action_15th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(14))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:corrective_action_15th].present?)
      error_msg_for_doc_22nd.push("15行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日15
    error_msg_for_doc_22nd.push("15行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:corrective_action_confirmation_date_15th].present?)
    #是正確認者15
    error_msg_for_doc_22nd.push("15行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(14)).blank?) && (document_params[:content][:corrective_action_reviewer_15th].present?)
    #職種16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:occupation_16th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:occupation_16th].present?)
      error_msg_for_doc_22nd.push("16行目の職種を入力しないでください")
    end
    #必要資格16
    error_msg_for_doc_22nd.push("16行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:required_qualification_16th].present?)
    #作業内容16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:work_content_16th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:work_content_16th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:work_content_16th].present?)
      error_msg_for_doc_22nd.push("16行目の作業内容は入力しないでください")
    end
    #危険予測16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:risk_prediction_16th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:risk_prediction_16th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:risk_prediction_16th].present?)
      error_msg_for_doc_22nd.push("16行目の危険予測は入力しないでください")
    end
    #職長確認16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:foreman_confirmation_16th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の職長確認を選択してください")
    end
    #実施の確認(良否)16
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:implementation_confirmation_16th].blank?)
    #実施の確認(良否)の確認者名16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:implementation_confirmation_person_16th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:implementation_confirmation_person_16th].present?)
      error_msg_for_doc_22nd.push("16行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置16
    if ((subcontractor_array(request_order_uuid).slice(15)).present?) && (document_params[:content][:corrective_action_16th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(15))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:corrective_action_16th].present?)
      error_msg_for_doc_22nd.push("16行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日16
    error_msg_for_doc_22nd.push("16行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:corrective_action_confirmation_date_16th].present?)
    #是正確認者16
    error_msg_for_doc_22nd.push("16行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(15)).blank?) && (document_params[:content][:corrective_action_reviewer_16th].present?)
    #職種17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:occupation_17th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の職種を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:occupation_17th].present?)
      error_msg_for_doc_22nd.push("17行目の職種を入力しないでください")
    end
    #必要資格17
    error_msg_for_doc_22nd.push("17行目の危険作業の名称、及び各種免許・資格の名称を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:required_qualification_17th].present?)
    #作業内容17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:work_content_17th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の作業内容を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:work_content_17th].size > $CHARACTER_LIMIT30)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の作業内容は30字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:work_content_17th].present?)
      error_msg_for_doc_22nd.push("17行目の作業内容は入力しないでください")
    end
    #危険予測17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:risk_prediction_17th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の危険予測を入力してください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:risk_prediction_17th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の危険予測は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:risk_prediction_17th].present?)
      error_msg_for_doc_22nd.push("17行目の危険予測は入力しないでください")
    end
    #職長確認17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:foreman_confirmation_17th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の職長確認を選択してください")
    end
    #実施の確認(良否)17
    error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の良否(実施の確認)を選択してください") if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:implementation_confirmation_17th].blank?)
    #実施の確認(良否)の確認者名17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:implementation_confirmation_person_17th].blank?)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の確認者(実施の確認)を選択してください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:implementation_confirmation_person_17th].present?)
      error_msg_for_doc_22nd.push("17行目の確認者(実施の確認)を選択しないでください")
    end
    #是正指示・指導・処置17
    if ((subcontractor_array(request_order_uuid).slice(16)).present?) && (document_params[:content][:corrective_action_17th].size > $CHARACTER_LIMIT20)
      error_msg_for_doc_22nd.push("#{business_name(subcontractor_array(request_order_uuid).slice(16))}の是正指示・指導・処置は20字以内にしてください")
    elsif ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:corrective_action_17th].present?)
      error_msg_for_doc_22nd.push("17行目の是正指示・指導・処置は入力しないでください")
    end
    #是正確認日17
    error_msg_for_doc_22nd.push("17行目の是正確認日を入力しないでください") if ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:corrective_action_confirmation_date_17th].present?)
    #是正確認者17
    error_msg_for_doc_22nd.push("17行目の確認者(是正確認)を選択しないでください") if ((subcontractor_array(request_order_uuid).slice(16)).blank?) && (document_params[:content][:corrective_action_reviewer_17th].present?)
    #朝礼時、周知・指示事項及び混在作業・調整事項1
    error_msg_for_doc_22nd.push('1行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_1st].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他1
    error_msg_for_doc_22nd.push('1行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_1st].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）1
    error_msg_for_doc_22nd.push('1行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_1st].size > $CHARACTER_LIMIT20
    #是正処理・報告1
    error_msg_for_doc_22nd.push('1行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_1st].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項2
    error_msg_for_doc_22nd.push('2行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_2nd].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他2
    error_msg_for_doc_22nd.push('2行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_2nd].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）2
    error_msg_for_doc_22nd.push('2行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_2nd].size > $CHARACTER_LIMIT20
    #是正処理・報告2
    error_msg_for_doc_22nd.push('2行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_2nd].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項3
    error_msg_for_doc_22nd.push('3行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_3rd].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他3
    error_msg_for_doc_22nd.push('3行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_3rd].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）3
    error_msg_for_doc_22nd.push('3行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_3rd].size > $CHARACTER_LIMIT20
    #是正処理・報告3
    error_msg_for_doc_22nd.push('3行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_3rd].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項4
    error_msg_for_doc_22nd.push('4行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_4th].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他4
    error_msg_for_doc_22nd.push('4行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_4th].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）4
    error_msg_for_doc_22nd.push('4行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_4th].size > $CHARACTER_LIMIT20
    #是正処理・報告4
    error_msg_for_doc_22nd.push('4行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_4th].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項5
    error_msg_for_doc_22nd.push('5行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_5th].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他5
    error_msg_for_doc_22nd.push('5行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_5th].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）5
    error_msg_for_doc_22nd.push('5行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_5th].size > $CHARACTER_LIMIT20
    #是正処理・報告5
    error_msg_for_doc_22nd.push('5行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_5th].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項6
    error_msg_for_doc_22nd.push('6行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_6th].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他6
    error_msg_for_doc_22nd.push('6行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_6th].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）6
    error_msg_for_doc_22nd.push('6行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_6th].size > $CHARACTER_LIMIT20
    #是正処理・報告6
    error_msg_for_doc_22nd.push('6行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_6th].size > $CHARACTER_LIMIT20
    #朝礼時、周知・指示事項及び混在作業・調整事項7
    error_msg_for_doc_22nd.push('7行目の朝礼時、周知・指示事項及び混在作業・調整事項を30字以内にしてください') if document_params[:content][:notifications_and_instructions_7th].size > $CHARACTER_LIMIT30
    #行事・パトロール・搬入・その他7
    error_msg_for_doc_22nd.push('7行目の行事・パトロール・搬入・その他を20字以内にしてください') if document_params[:content][:events_and_patrols_7th].size > $CHARACTER_LIMIT20
    #統責者・巡視記録（内容）7
    error_msg_for_doc_22nd.push('7行目の内容(統責者・巡視記録)を20字以内にしてください') if document_params[:content][:patrol_record_content_7th].size > $CHARACTER_LIMIT20
    #是正処理・報告7
    error_msg_for_doc_22nd.push('7行目の是正処理・報告を20字以内にしてください') if document_params[:content][:corrective_action_report_7th].size > $CHARACTER_LIMIT20
    #委任期間（自）年月日
    error_msg_for_doc_22nd.push('委任期間(自)年月日を入力してください') if document_params[:content][:delegation_date_from].blank?
    #委任期間（自）時間
    error_msg_for_doc_22nd.push('委任期間(自)時間を入力してください') if document_params[:content][:delegation_time_from].blank?
    #委任期間（至）年月日
    error_msg_for_doc_22nd.push('委任期間(至)年月日を入力してください') if document_params[:content][:delegation_date_to].blank?
    #委任期間（至）時間
    error_msg_for_doc_22nd.push('委任期間(至)時間を入力してください') if document_params[:content][:delegation_time_to].blank?
    #統括安全衛生責任者・署名年月日
    error_msg_for_doc_22nd.push('統括安全衛生責任者・署名年月日を入力してください') if document_params[:content][:officer_signature_date].blank?
    #統括安全衛生責任者代行者・署名年月日
    error_msg_for_doc_22nd.push('統括安全衛生責任者代行者・署名年月日を入力してください') if document_params[:content][:officer_substitute_signature_date].blank?
    error_msg_for_doc_22nd
  end

  #下請会社(協力会社)の配列の取得
  def subcontractor_array(request_order_uuid)
    request_order = RequestOrder.find_by(uuid: request_order_uuid)
    request_order_list = RequestOrder.where(order_id: request_order.order_id).where.not(parent_id: nil)
    subcontractor_array = []
    request_order_list.each do |record|
      subcontractor_array << record.business_id
    end
    return subcontractor_array
  end

  #会社名の取得
  def business_name(business_id)
    Business.find_by(id: business_id).name
  end

  # rubocop:enable all
end
