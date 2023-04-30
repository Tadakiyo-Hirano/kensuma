class WorkerSkillTraining < ApplicationRecord
  belongs_to :worker
  belongs_to :skill_training

  validates :worker_id, uniqueness: { scope: :skill_training_id }
  validates :skill_training_id, presence: true, if: :skill_training_id_valid?
  validate :valid_images

  mount_uploaders :images, WorkerSkillTrainingsUploader

  private

  def skill_training_id_valid?
    images.blank?
  end

  def valid_images
    if skill_training_id.present? && images.blank?
      errors.add(:images, '技能講習修了証明書の写しを入力してください') && return
    end
  end
end
