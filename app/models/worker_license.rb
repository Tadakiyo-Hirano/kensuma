class WorkerLicense < ApplicationRecord
  belongs_to :worker
  belongs_to :license

  validates :license_id, uniqueness: { scope: :worker_id }

  mount_uploaders :images, WorkerLicensesUploader
end
