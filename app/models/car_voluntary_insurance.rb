class CarVoluntaryInsurance < ApplicationRecord
  belongs_to :car_voluntary, class_name: 'Car', foreign_key: 'car_voluntary_id', optional: true
  belongs_to :company_voluntary, class_name: 'CarInsuranceCompany', foreign_key: 'company_voluntary_id'

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
end
