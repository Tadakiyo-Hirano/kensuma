class WorkerLicense < ApplicationRecord
  belongs_to :worker
  belongs_to :license

  validates :license_id, presence: true, if: :license_valid?
  validate :valid_images

  mount_uploaders :images, WorkerLicensesUploader

  private

  def license_valid?
    images.blank?
  end

  def valid_images
    if license_id.present? && (images.blank? || images == [])
      errors.add(:images, 'を入力してください') && return
    end
  end
end
