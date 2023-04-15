class SpecialVehicle < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :periodic_self_inspections, PeriodicSelfInspectionsUploader
  mount_uploaders :in_house_inspections, InHouseInspectionsUploader
  
  enum vehicle_type: { crane: 0, construction: 1 }
  
  validates :name, presence: true
  validates :maker, presence: true
  validates :owning_company_name, presence: true
  validates :vehicle_type, presence: true
  validates :standards_performance, presence: true
  validates :year_manufactured, presence: true
  validates :control_number, presence: true
  validates :check_exp_date_year, presence: true
  validates :check_exp_date_month, presence: true
  validates :check_exp_date_machine, presence: true
  validates :check_exp_date_car, presence: true

  enum personal_insurance: {
    無制限: 0,
    "1,000": 1, "2,000": 2, "3,000": 3, "4,000": 4, "5,000": 5,
    "6,000": 6, "7,000": 7, "8,000": 8, "9,000": 9, "10,000": 10,
    "11,000": 11, "12,000": 12, "13,000": 13, "14,000": 14, "15,000": 15,
    "16,000": 16, "17,000": 17, "18,000": 18, "19,000": 19, "20,000": 20
  }, _prefix: true

  enum objective_insurance: {
    無制限: 0,
    "1,000": 1, "2,000": 2, "3,000": 3, "4,000": 4, "5,000": 5,
    "6,000": 6, "7,000": 7, "8,000": 8, "9,000": 9, "10,000": 10,
    "11,000": 11, "12,000": 12, "13,000": 13, "14,000": 14, "15,000": 15,
    "16,000": 16, "17,000": 17, "18,000": 18, "19,000": 19, "20,000": 20
  }, _prefix: true

  enum passenger_insurance: {
    無制限: 0,
    "1,000": 1, "2,000": 2, "3,000": 3, "4,000": 4, "5,000": 5,
    "6,000": 6, "7,000": 7, "8,000": 8, "9,000": 9, "10,000": 10,
    "11,000": 11, "12,000": 12, "13,000": 13, "14,000": 14, "15,000": 15,
    "16,000": 16, "17,000": 17, "18,000": 18, "19,000": 19, "20,000": 20
  }, _prefix: true

  enum other_insurance: {
    無制限: 0,
    "1,000": 1, "2,000": 2, "3,000": 3, "4,000": 4, "5,000": 5,
    "6,000": 6, "7,000": 7, "8,000": 8, "9,000": 9, "10,000": 10,
    "11,000": 11, "12,000": 12, "13,000": 13, "14,000": 14, "15,000": 15,
    "16,000": 16, "17,000": 17, "18,000": 18, "19,000": 19, "20,000": 20
  }, _prefix: true

  def to_param
    uuid
  end
end
