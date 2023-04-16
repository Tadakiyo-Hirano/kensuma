class FieldSpecialVehicle < ApplicationRecord
  belongs_to :field_special_vehicleable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum lease_type: { own: 0, lease: 1 }

  validates :vehicle_name, presence: true
  validates :content, presence: true
  validates :use_place, length: { maximum: 100 }
  validates :contact_prevention, length: { maximum: 40 }
  validates :precautions, length: { maximum: 500 }

  def to_param
    uuid
  end
end
