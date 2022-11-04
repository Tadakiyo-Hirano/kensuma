class FireType < ApplicationRecord
  has_many :field_fire_fire_types
  has_many :field_fires, through: :field_fire_types
end
