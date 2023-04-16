class WorkerSkillTraining < ApplicationRecord
  belongs_to :worker
  belongs_to :skill_training

  validates :worker_id, uniqueness: { scope: :skill_training_id }

  mount_uploaders :images, WorkerSkillTrainingsUploader
end
