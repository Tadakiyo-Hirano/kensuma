class WorkerSpecialEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :special_education

  validates :special_education_id, presence: true, if: :special_education_id_valid?
  validate :valid_images

  mount_uploaders :images, WorkerSpecialEducationsUploader

  private

  def special_education_id_valid?
    images.blank?
  end

  def valid_images
    if special_education_id.present? && (images.blank? || images == [])
      errors.add(:images, 'を入力してください') && return
    end
  end
end
