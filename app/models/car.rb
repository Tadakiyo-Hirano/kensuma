class Car < ApplicationRecord
  belongs_to :business
  belongs_to :car_insurance_company
  has_many :car_voluntary_insurances, class_name: 'CarVoluntaryInsurance', foreign_key: :car_voluntary_id, dependent: :destroy
  has_many :company_voluntaries, through: :car_voluntary_insurances, source: :company_voluntary
  accepts_nested_attributes_for :car_voluntary_insurances

  validates :owner_name, presence: true
  validates :vehicle_model, presence: true
  validates :vehicle_number, presence: true
  validates :vehicle_inspection_start_on, presence: true
  validates :vehicle_inspection_end_on, presence: true
  validates :liability_securities_number, presence: true
  validates :liability_insurance_start_on, presence: true
  validates :liability_insurance_end_on, presence: true

  mount_uploaders :images, CarsUploader
end
