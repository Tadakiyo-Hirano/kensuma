class FieldFire < ApplicationRecord
  belongs_to :field_fireable, polymorphic: true
  has_many :field_fire_fire_use_targets, dependent: :destroy
  has_many :fire_use_targets, through: :field_fire_fire_use_targets
  has_many :field_fire_fire_types, dependent: :destroy
  has_many :fire_types, through: :field_fire_fire_types
  has_many :field_fire_fire_managements, dependent: :destroy
  has_many :fire_managements, through: :field_fire_fire_managements

  before_create -> { self.uuid = SecureRandom.uuid }

  before_validation(on: :create) do
    errors[:base] << '火気情報は1件までしか登録できません' if field_fireable && field_fireable.field_fires.count >= 1
  end

  validates :use_place, presence: true, length: { maximum: 100 }
  validates :other_use_target, length: { maximum: 10 }
  validates :usage_period_start, presence: true
  validates :usage_period_end, presence: true
  validates :usage_time_start, presence: true
  validates :usage_time_end, presence: true
  validates :other_fire_type, length: { maximum: 20 }
  validates :precautions, presence: true, length: { maximum: 40 }
  validates :fire_origin_responsible, presence: true
  validates :fire_use_responsible, presence: true

  def to_param
    uuid
  end
end
