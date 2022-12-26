class FieldMachine < ApplicationRecord
  belongs_to :field_machineable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :machine_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
