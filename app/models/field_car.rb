class FieldCar < ApplicationRecord
  belongs_to :field_carable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :car_name, presence: true
  validates :content, presence: true

  def to_param
    uuid
  end
end
