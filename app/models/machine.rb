class Machine < ApplicationRecord
  belongs_to :business
  has_many :machine_tags, dependent: :destroy
  has_many :tags, through: :machine_tags

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :name, presence: true
  validates :standards_performance, presence: true
  validates :control_number, presence: true
  validates :inspector, presence: true
  validates :handler, presence: true
  validates :inspection_date, presence: true

  def to_param
    uuid
  end
end
