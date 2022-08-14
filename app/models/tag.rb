class Tag < ApplicationRecord
  has_many :machine_tags, dependent: :destroy
  has_many :machine, through: :machine_tags
end
