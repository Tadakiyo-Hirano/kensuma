class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true
  serialize :field_workers, JSON

  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :proper_management_licenses, ProperManagementLicensesUploader
  enum sendoff_education: { educated: 0, not_educated: 1 }, _suffix: true       # 送り出し教育の受講有無

  validates :admission_worker_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end

  def youth_field_workers?
    Time.zone.now < self.birthday_on.since(18.years)
  end
end
