class Solvent < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :name, presence: true
  validates :classification, presence: true
  validates :ingredients, presence: true

  def to_param
    uuid
  end
end
