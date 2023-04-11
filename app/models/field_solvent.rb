class FieldSolvent < ApplicationRecord
  belongs_to :field_solventable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  before_validation(on: :create) do
    errors[:base] << '有機溶剤情報は1件までしか登録できません' if field_solventable && field_solventable.field_solvents.count >= 1
  end

  enum working_process: { y: 0, n: 1 }, _prefix: true
  enum sds: { y: 0, n: 1 }, _prefix: true

  validates :solvent_name_one, presence: true
  validates :carried_quantity_one, presence: true
  validates :using_location, length: { maximum: 100 }
  validates :storing_place, length: { maximum: 100 }
  validates :using_tool, length: { maximum: 40 }

  def to_param
    uuid
  end
end
