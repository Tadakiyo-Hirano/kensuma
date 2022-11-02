class Business < ApplicationRecord
  belongs_to :user
  has_many :cars, dependent: :destroy
  has_many :special_vehicles, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :request_orders, dependent: :destroy
  has_many :workers, dependent: :destroy
  has_many :machines, dependent: :destroy
  has_many :solvents, dependent: :destroy
  has_many :business_occupations
  has_many :occupations, through: :business_occupations
  has_many :business_industries
  has_many :industries, through: :business_industries
  accepts_nested_attributes_for :business_occupations, allow_destroy: true
  accepts_nested_attributes_for :business_industries, allow_destroy: true

  enum business_type: { corporation: 0, freelance: 1, Individual_five_over: 2, Individual_five_less: 3 }
  enum business_health_insurance_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true               # 健康保険(加入状況)
  enum business_welfare_pension_insurance_join_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true # 厚生年金保険(加入状況)
  enum business_pension_insurance_join_status: { welfare: 0, national: 1, recipient: 2 }                      # 年金保険(加入状況)
  enum business_employment_insurance_join_status: { join: 0, not_join: 1, not_coverd: 2 }, _prefix: true      # 雇用保険(加入状況)
  enum business_retirement_benefit_mutual_aid_status: { available: 0, not_available: 1 }, _prefix: true       # 退職金共済制度(加入状況)
  enum construction_license_status: { available: 0, not_available: 1 }, _prefix: true                         # 建設許可証(保持情報)
  enum construction_license_permission_type_minister_governor: { minister_permission: 0, governor_permission: 1 } # 建設許可証(許可種別)
  enum construction_license_governor_permission_prefecture: {
    hokkaido: 0,
    aomori: 1,
    iwate: 2,
    miyagi: 3,
    akita: 4,
    yamagata: 5,
    fukushima: 6,
    ibaraki: 7,
    tochigi: 8,
    gunma: 9,
    saitama: 10,
    chiba: 11,
    tokyo: 12,
    kanagawa: 13,
    niigata: 14,
    toyama: 15,
    ishikawa: 16,
    fukui: 17,
    yamanashi: 18,
    nagano: 19,
    gifu: 20,
    shizuoka: 21,
    aichi: 22,
    mie: 23,
    shiga: 24,
    kyoto: 25,
    osaka: 26,
    hyogo: 27,
    nara: 28,
    wakayama: 29,
    tottori: 30,
    shimane: 31,
    okayama: 32,
    hiroshima: 33,
    yamaguchi: 34,
    tokushima: 35,
    kagawa: 36,
    ehime: 37,
    kochi: 38,
    fukuoka: 39,
    saga: 40,
    nagasaki: 41,
    kumamoto: 42,
    oita: 43,
    miyazaki: 44,
    kagoshima: 45,
    kagoshima: 46,
    okinawa: 47
  }                                                                                                 # 建設許可証(都道府県)
  enum construction_license_permission_type_identification_general: { identification: 0, general: 1 }  # 建設許可証(許可種別)

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
  validates :business_health_insurance_status, presence: true # 健康保険(加入状況)
  validates :business_health_insurance_association, length: { maximum: 20 } # 健康保険(組合名)
  validates :business_health_insurance_office_number, allow_blank: true, format: { with: /\A\d{6,8}\z/, message: 'は数字6桁または8桁で入力してください' } # 健康保険(事業所整理記号及び事業所番号) 一旦6桁から8桁で保存可能として実装
  validates :business_welfare_pension_insurance_join_status, presence: true # 厚生年金保険(加入状況)
  validates :business_welfare_pension_insurance_office_number, length: { is: 14, message: 'は数字14桁で入力してください' }, allow_blank: true # 厚生年金保険(事業所整理記号)
  validates :business_pension_insurance_join_status, presence: true # 年金保険(加入状況)
  validates :business_employment_insurance_join_status, presence: true # 雇用保険(加入状況)
  validates :business_employment_insurance_number, length: { is: 11, message: 'は数字11桁で入力してください' }, allow_blank: true # 雇用保険(番号)
  validates :business_retirement_benefit_mutual_aid_status, presence: true # 退職金共済制度(加入状況)
  validates :construction_license_status, presence: true
  validates :construction_license_permission_type_minister_governor, presence: true
  validates :construction_license_governor_permission_prefecture, presence: true
  validates :construction_license_permission_type_identification_general, presence: true
  validates :construction_license_number_double_digit, format: { with: /\A\d{2}\z/, message: 'は数字2桁で入力してください' }, presence: true
  validates :construction_license_number_six_digits, format: { with: /\A\d{1,6}\z/, message: 'は数字6桁以下で入力してください' }, presence: true
  validates :construction_license_number, presence: true
  validates :construction_license_updated_at, presence: true



  before_create -> { self.uuid = SecureRandom.uuid }

  mount_uploaders :stamp_images, StampImagesUploader
end
