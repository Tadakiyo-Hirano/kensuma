class WorkerSafetyHealthEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :safety_health_education
  validates :safety_health_education_id, presence: true, if: :safety_health_education_id_valid?
  validate :valid_images
  validates :worker_id, uniqueness: { scope: :safety_health_education_id }

  mount_uploaders :images, WorkerSafetyHealthEducationUploader

  private

  def safety_health_education_id_valid?
    images.blank?
  end

  def valid_images
    if safety_health_education_id.present? && images.blank?
      errors.add(:images, '安全衛生教育修了証明書の写しを入力してください') && return
    end
  end
end
