class FieldSolvent < ApplicationRecord
  belongs_to :field_solventable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :solvent_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
