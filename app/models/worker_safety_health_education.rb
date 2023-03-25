class WorkerSafetyHealthEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :safety_health_education

  validates :worker_id, uniqueness: { scope: :safety_health_education_id }

  mount_uploaders :images, WorkerSafetyHealthEducationUploader
end
