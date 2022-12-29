class FieldMachine < ApplicationRecord
  belongs_to :field_machineable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  before_validation(on: :create) do
    errors[:base] << '現場機械情報は10件までしか登録できません' if field_machineable && field_machineable.field_machines.count >= 10
  end

  validates :machine_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
