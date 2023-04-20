class WorkerMedical < ApplicationRecord
  belongs_to :worker
  has_many :worker_exams, dependent: :destroy # 中間テーブル
  has_many :special_med_exams, through: :worker_exams
  accepts_nested_attributes_for :worker_exams, allow_destroy: true,
    reject_if:     proc { |attributes| attributes['special_med_exam_id'].blank? }

  enum health_condition: {
    good:   0,
    normal: 1,
    bad:    2
  }, _prefix: true

  enum is_med_exam: { y: 0, n: 1 }, _prefix: true         # 健康診断受診の有無
  enum is_special_med_exam: { y: 0, n: 1 }, _prefix: true # 特別健康診断受診の有無

  validates :med_exam_on, presence: true
  validates :max_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }
  validates :min_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }
  validates :health_condition, presence: true
  validates :is_med_exam, presence: true
end
