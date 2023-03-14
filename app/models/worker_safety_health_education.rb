class WorkerSafetyHealthEducation < ApplicationRecord
  belongs_to :worker_id
  belongs_to :safety_health_education_id

  mount_uploaders :images, WorkerSafetyHealthEducationUploader
end
