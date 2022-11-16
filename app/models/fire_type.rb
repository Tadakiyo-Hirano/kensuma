class FireType < ApplicationRecord
  has_many :field_fire_fire_types, dependent: :destroy
  has_many :field_fires, through: :field_fire_types
end
