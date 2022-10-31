class FieldFire < ApplicationRecord
  belongs_to :field_fireable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :use_plase, presence: true, length: { maximum: 100 }

  def to_param
    uuid
  end
end
