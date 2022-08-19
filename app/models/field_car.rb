class FieldCar < ApplicationRecord
  belongs_to :field_carable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :car_name, presence: true
  validates :content, presence: true
  validates :starting_point, length: { maximum: 40 }
  validates :waypoint_first, length: { maximum: 40 }
  validates :waypoint_second, length: { maximum: 40 }
  validates :arrival_point, length: { maximum: 40 }

  def to_param
    uuid
  end
end
