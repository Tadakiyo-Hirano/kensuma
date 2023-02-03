class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }
  
  enum sendoff_education: { educated: 0, not_educated: 1 }, _prefix: true       # 送り出し教育の受講有無
  validates :admission_worker_name, presence: true
  validates :content, presence: true
  validates :sendoff_education, presence: true

  def to_param
    uuid
  end
end
