class WorkerSpecialEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :special_education

  validates :worker_id, uniqueness: { scope: :special_education_id }

  mount_uploaders :images, WorkerSpecialEducationsUploader
end
