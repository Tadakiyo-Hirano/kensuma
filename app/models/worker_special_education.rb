class WorkerSpecialEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :special_education

  validates :worker_id, uniqueness: { scope: :special_education_id }
  validates :special_education_id, presence: true, if: :special_education_id_valid?
  validate :valid_images

  mount_uploaders :images, WorkerSpecialEducationsUploader

  private

  def special_education_id_valid?
    images.blank?
  end

  def valid_images
    if special_education_id.present? && images.blank?
      errors.add(:images, '特別教育修了証明書の写しを入力してください') && return
    end
  end
end
