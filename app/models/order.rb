class Order < ApplicationRecord
  belongs_to :business

  enum status: { created: 0, completed: 1 }

  validates :status, presence: true
  validates :site_name, presence: true
  validates :order_name, presence: true
  validates :order_post_code, presence: true, format: { with: /\A\^\d{5}$|^\d{7}\z/ }
  validates :order_address, presence: true

  before_create -> { self.site_uu_id = SecureRandom.uuid }
end
