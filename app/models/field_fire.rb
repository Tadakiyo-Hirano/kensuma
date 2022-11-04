class FieldFire < ApplicationRecord
  belongs_to :field_fireable, polymorphic: true
  has_many :field_fire_fire_use_targets
  has_many :fire_use_targets, through: :field_fire_fire_use_targets

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :use_place, presence: true, length: { maximum: 100 }

  def to_param
    uuid
  end
end
