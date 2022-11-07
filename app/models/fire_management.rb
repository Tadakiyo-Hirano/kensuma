class FireManagement < ApplicationRecord
  has_many :field_fire_fire_managements
  has_many :field_fires, through: :field_fire_managements
end
