class WorkerInsurance < ApplicationRecord
  belongs_to :worker

  enum health_insurance_type: {
    health_insurance_association:           0,
    japan_health_insurance_association:     1,
    construction_national_health_insurance: 2,
    national_health_insurance:              3,
    exemption:                              4
  }, _prefix: true

  enum pension_insurance_type: {
    welfare:   0,
    national:  1,
    recipient: 2
  }, _prefix: true

  enum employment_insurance_type: {
    insured:   0,
    day:       1,
    exemption: 2
  }, _prefix: true

  enum severance_pay_mutual_aid_type: {
    kentaikyo: 0,
    tyutaikyo: 1,
    none:      2,
    other:     3
  }, _prefix: true

  enum has_labor_insurance: { join: 0, not_join: 1, exemption: 2 }, _prefix: true       # 労働保険特別加入の有無

  validates :health_insurance_type, presence: true
  validates :health_insurance_name, presence: true, if: :insurance_name_valid?
  validates :pension_insurance_type, presence: true
  validates :employment_insurance_type, presence: true
  validates :employment_insurance_number, length: { is: 11 }, if: :employment_insurance_number_valid?
  validates :severance_pay_mutual_aid_type, presence: true
  validates :severance_pay_mutual_aid_name, presence: true, if: :severance_pay_mutual_aid_name_valid?

  private

  # 健康保険が健康保険組合もしくは建設国保であればtrue
  def insurance_name_valid?
    %w[health_insurance_association construction_national_health_insurance].include?(health_insurance_type)
  end

  # 雇用保険が被保険者であればtrue
  def employment_insurance_number_valid?
    employment_insurance_type == 'insured'
  end

  def severance_pay_mutual_aid_name_valid?
    severance_pay_mutual_aid_type == 'other'
  end
end
