class SpecialVehicle < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :periodic_self_inspections, PeriodicSelfInspectionsUploader
  mount_uploaders :in_house_inspections, InHouseInspectionsUploader

  enum vehicle_type: { crane: 0, construction: 1 }
  enum personal_insurance_unlimited: { not_joined: 0, unlimited: 1, price_entry: 2 }, _prefix: true
  enum objective_insurance_unlimited: { not_joined: 0, unlimited: 1, price_entry: 2 }, _prefix: true
  enum passenger_insurance_unlimited: { not_joined: 0, unlimited: 1, price_entry: 2 }, _prefix: true
  enum other_insurance_unlimited: { not_joined: 0, unlimited: 1, price_entry: 2 }, _prefix: true

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
  validates :personal_insurance, length: { maximum: 9 }, numericality: { greater_than: 0 }, allow_nil: true
  validates :objective_insurance, length: { maximum: 9 }, numericality: { greater_than: 0 }, allow_nil: true
  validates :passenger_insurance, length: { maximum: 9 }, numericality: { greater_than: 0 }, allow_nil: true
  validates :other_insurance, length: { maximum: 9 }, numericality: { greater_than: 0 }, allow_nil: true

  validate :insurance_presence_if_price_entry_exists

  def insurance_presence_if_price_entry_exists
    if personal_insurance_unlimited == "price_entry" && personal_insurance.blank?
      errors.add(:personal_insurance, message: "の保険金額を入力してください")
    end

    if objective_insurance_unlimited == "price_entry" && objective_insurance.blank?
      errors.add(:objective_insurance, message: "の保険金額を入力してください")
    end

    if passenger_insurance_unlimited == "price_entry" && passenger_insurance.blank?
      errors.add(:passenger_insurance, message: "の保険金額を入力してください")
    end
    if other_insurance_unlimited == "price_entry" && other_insurance.blank?
      errors.add(:other_insurance, message: "の保険金額を入力してください")
    end
  end

  def to_param
    uuid
  end
end
