class WorkerExam < ApplicationRecord
  belongs_to :worker_medical
  belongs_to :special_med_exam

  validates :worker_medical_id, uniqueness: { scope: :special_med_exam_id }
end
