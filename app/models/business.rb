class Business < ApplicationRecord
  belongs_to :user
  has_many :cars, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :workers, dependent: :destroy

  enum business_type: { corporation: 0, freelance: 1, Individual_five_over: 2, Individual_five_less: 3 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :uuid, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/u, message: 'はカタカナで入力して下さい。' }
  validates :branch_name, presence: true
  validates :representative_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :address, presence: true
  validates :post_code, presence: true, format: { with: /\A\^\d{5}$|^\d{7}\z/ }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :business_type, presence: true

  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :stamp_images, StampImagesUploader
end
