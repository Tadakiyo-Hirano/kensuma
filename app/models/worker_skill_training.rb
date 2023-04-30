class WorkerSkillTraining < ApplicationRecord
  belongs_to :worker
  belongs_to :skill_training

  validates :skill_training_id, presence: true, if: :skill_training_id_valid?
  validate :valid_images

  mount_uploaders :images, WorkerSkillTrainingsUploader

  private

  def skill_training_id_valid?
    images.blank?
  end

  def valid_images
    if skill_training_id.present? && (images.blank? || images == [])
      errors.add(:images, 'を入力してください') && return
    end
  end
end
