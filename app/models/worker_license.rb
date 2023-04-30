class WorkerLicense < ApplicationRecord
  belongs_to :worker
  belongs_to :license

  validates :worker_id, uniqueness: { scope: :license_id }
  validates :license_id, presence: true, if: :license_valid?
  validate :valid_images

  mount_uploaders :images, WorkerLicensesUploader

  private

  def license_valid?
    images.blank?
  end

  def valid_images
    if license_id.present? && images.blank?
      errors.add(:images, '技能検定合格証明書の写しを入力してください') && return
    end
  end
end
