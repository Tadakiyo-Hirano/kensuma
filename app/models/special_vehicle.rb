class SpecialVehicle < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :check_exp_date_year, presence: true
  validates :check_exp_date_month, presence: true
  validates :check_exp_date_specific, presence: true
  validates :check_exp_date_machine, presence: true
  validates :check_exp_date_car, presence: true

  def to_param
    uuid
  end
end
