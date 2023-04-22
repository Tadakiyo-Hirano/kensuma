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
  # enum special_med_exam_ids: {                            # 特別健康診断受診
  #   pneumoconiosis:               1, # じん肺
  #   solvent:                      2, # 有機溶剤
  #   lead:                         3, # 鉛
  #   ionizing_radiation:           4, # 電離放射線
  #   specific_chemical_substances: 5, # 特定化学物質
  #   hyperbaric_work:              6, # 高気圧業務
  #   four_way_vertical:            7, # 四方向鉛直
  #   asbestos:                     8, # 石綿
  #   others:                       9  # その他
  # }

  validates :med_exam_on, presence: true
  validates :max_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }
  validates :min_blood_pressure, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 999 }
  validates :health_condition, presence: true
  validates :is_med_exam, presence: true
end
