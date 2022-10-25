class FieldSolvent < ApplicationRecord
  belongs_to :field_solventable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum working_process: { y: 0, n: 1 }, _prefix: true
  enum sds: { y: 0, n: 1 }, _prefix: true

  validates :solvent_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
