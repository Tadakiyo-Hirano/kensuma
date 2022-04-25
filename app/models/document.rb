class Document < ApplicationRecord
  belongs_to :business
  belongs_to :request_order

  before_create -> { self.uuid = SecureRandom.uuid }

  enum document_type: {
    cover_document:             0, # 表紙
    table_of_contents_document: 1, # 目次
    doc_2nd:                    2, # 施工体制台帳作成建設工事の通知
    doc_3rd:                    3,
    doc_4th:                    4,
    doc_5th:                    5, # 作業員名簿
    doc_6th:                    6,
    doc_7th:                    7,
    doc_8th:                    8
  }

  def to_param
    uuid
  end
end