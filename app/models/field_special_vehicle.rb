class FieldSpecialVehicle < ApplicationRecord
  belongs_to :field_special_vehicleable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum vehicle_type: { crane: 0, construction: 1 }
  enum lease_type: { own: 0, lease: 1 }

  validates :vehicle_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
