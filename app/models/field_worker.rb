class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :admission_worker_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
