class WorkerMedical < ApplicationRecord
  belongs_to :worker
  has_many :special_med_exams

  enum health_condition: {
    good:   0,
    normal: 1,
    bad:    2
  }, _prefix: true

  enum is_med_exam: { y: 0, n: 1 }, _prefix: true         # 健康診断受診の有無
  enum is_special_med_exam: { y: 0, n: 1 }, _prefix: true # 特別健康診断受診の有無

  validates :med_exam_on, presence: true, if: :med_exam_y?
  validates :med_exam_on, absence: true, unless: :med_exam_y?
  validates :max_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }, if: :med_exam_y?
  validates :max_blood_pressure, absence: true, unless: :med_exam_y?
  validates :min_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }, if: :med_exam_y?
  validates :min_blood_pressure, absence: true, unless: :med_exam_y?
  validates :is_special_med_exam, presence: true
  validates :special_med_exam_on, presence: true, if: :special_med_exam_y?
  validates :special_med_exam_on, absence: true, unless: :special_med_exam_y?
  validates :health_condition, presence: true
  validates :is_med_exam, presence: true

  private

  def special_med_exam_y?
    is_special_med_exam == 'y'
  end

  def med_exam_y?
    self.is_med_exam == 'y'
  end
end
