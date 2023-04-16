class SafetyHealthEducation < ApplicationRecord
  has_many :safety_health_educations, dependent: :destroy
  has_many :workers, through: :safety_health_educations

  validates :name, presence: true
end
