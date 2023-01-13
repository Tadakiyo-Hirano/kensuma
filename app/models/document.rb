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
    # 持込年月日
    if document_params[:content][:date_submitted].blank?
      error_msg_for_doc_14th.push('提出日を入力してください')
    end
    # 搬出予定年月日
    if document_params[:content][:date_submitted].blank?
      error_msg_for_doc_14th.push('提出日を入力してください')
    end
      error_msg_for_doc_14th
  end
end

# #エラーメッセージ(工事安全衛生計画書用)
# def error_msg_for_doc_19th(document_params)
#   error_msg_for_doc_19th = []
#   #作成日
#   if document_params[:content][:date_created].blank?
#     error_msg_for_doc_19th.push('作成日を入力してください')
#   end
#   #工事安全衛生方針
#   if document_params[:content][:safety_and_health_construction_policy].blank?
#     error_msg_for_doc_19th.push('工事安全衛生方針を記入してください')
#   elsif document_params[:content][:safety_and_health_construction_policy].length > 300
#     error_msg_for_doc_19th.push('工事安全衛生方針を300字以内にしてください')
#   else
#     nil
#   end
#   error_msg_for_doc_19th
# end
