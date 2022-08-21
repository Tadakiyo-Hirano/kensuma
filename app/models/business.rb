class Business < ApplicationRecord
  belongs_to :user
  has_many :cars, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :request_orders, dependent: :destroy
  has_many :workers, dependent: :destroy
  has_many :solvents, dependent: :destroy
  has_many :business_occupations
  has_many :occupations, through: :business_occupations
  accepts_nested_attributes_for :business_occupations, allow_destroy: true

  enum business_type: { corporation: 0, freelance: 1, Individual_five_over: 2, Individual_five_less: 3 }
  enum business_health_insurance_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true               # 健康保険(加入状況)
  enum business_welfare_pension_insurance_join_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true # 厚生年金保険(加入状況)
  enum business_pension_insurance_join_status: { welfare: 0, national: 1, recipient: 2 }                      # 年金保険(加入状況)
  enum business_employment_insurance_join_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true      # 雇用保険(加入状況)
  enum business_retirement_benefit_mutual_aid_status: { available: 0, not_available: 1 }, _prefix: true       # 退職金共済制度(加入状況)

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
  validates :business_health_insurance_status, presence: true                                                                 # 健康保険(加入状況)
  validates :business_health_insurance_association, length: { maximum: 20 }                                                   # 健康保険(組合名)
  validates :business_health_insurance_office_number, format: { with: /\A\d{6,8}\z/, message: 'は6桁または8桁で入力してください' } # 健康保険(事業所整理記号及び事業所番号)
  validates :business_welfare_pension_insurance_join_status, presence: true                                                   # 厚生年金保険(加入状況)
  validates :business_welfare_pension_insurance_office_number, { length: { is: 14 } }                                         # 厚生年金保険(事業所整理記号)
  validates :business_pension_insurance_join_status, presence: true                                                           # 年金保険(加入状況)
  validates :business_employment_insurance_join_status, presence: true                                                        # 雇用保険(加入状況)
  validates :business_employment_insurance_number, { length: { is: 11 } }                                                     # 雇用保険(番号)
  validates :business_retirement_benefit_mutual_aid_status, presence: true                                                    # 退職金共済制度(加入状況)

  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :stamp_images, StampImagesUploader
end
