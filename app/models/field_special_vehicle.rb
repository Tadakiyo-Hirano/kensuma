class FieldSpecialVehicle < ApplicationRecord
  belongs_to :field_special_vehicleable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :vehicle_type, presence: true
  validates :carry_on_company_name, presence: true
  validates :owning_company_name, presence: true
  validates :use_company_name, presence: true
  validates :carry_on_date, presence: true
  validates :carry_out_date, presence: true
  validates :use_place, presence: true
  validates :lease_type, presence: true

  def to_param
    uuid
  end
end
