class Worker < ApplicationRecord
  belongs_to :business
  has_one :worker_insurance, dependent: :destroy
  accepts_nested_attributes_for :worker_insurance, allow_destroy: true

  has_many :worker_licenses, dependent: :destroy
  has_many :licenses, through: :worker_licenses
  accepts_nested_attributes_for :worker_licenses, allow_destroy: true,
    reject_if:     proc { |attributes| attributes['license_id'].blank? }

  has_many :worker_skill_trainings, dependent: :destroy
  has_many :skill_trainings, through: :worker_skill_trainings
  accepts_nested_attributes_for :worker_skill_trainings, allow_destroy: true,
    reject_if:     proc { |attributes| attributes['skill_training_id'].blank? }

  has_many :worker_special_educations, dependent: :destroy
  has_many :special_educations, through: :worker_special_educations
  accepts_nested_attributes_for :worker_special_educations, allow_destroy: true,
    reject_if:     proc { |attributes| attributes['special_education_id'].blank? }

  has_many :worker_safety_health_education, dependent: :destroy
  has_many :safety_health_education, through: :worker_safety_health_education
  accepts_nested_attributes_for :worker_safety_health_education, allow_destroy: true,
    reject_if:     proc { |attributes| attributes['safety_health_education_id'].blank? }

  has_one :worker_medical, dependent: :destroy
  accepts_nested_attributes_for :worker_medical, allow_destroy: true

  enum abo_blood_type: { a: 0, b: 1, ab: 2, o: 3 }
  enum rh_blood_type: { plus: 0, minus: 1, rh_null: 2 }
  enum employment_contract: { available: 0, not_available: 1, not_applicable: 2 }, _prefix: true       # 雇用契約書取り交わし状況
  enum sex: { man: 0, woman: 1 }
  enum status_of_residence: { permanent_resident: 0, specified_skill: 1, specific_activity: 2 }, _prefix: true # 在留資格
  enum confirmed_check: { checked: 1, unchecked: 0 }, _prefix: true # キャリアアップシステム登録情報が最新であることの確認日

  before_create -> { self.uuid = SecureRandom.uuid }

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_POST_CODE_REGEX = /\A\d{7}\z/
  before_validation :remove_hyphen_to_post_code
  before_validation :full_width_to_half_width([post_code])
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヴー\s\p{blank}]+\z/u, message: 'はカタカナで入力してください' }
  validates :country, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX, message: 'はexample@email.comのような形式で入力してください' }
  validates :post_code, presence: true, format: { with: VALID_POST_CODE_REGEX, message: 'は7桁で入力してください' }
  validates :my_address, presence: true
  validates :my_phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: 'はハイフン無しの10桁または11桁で入力してください' }
  validates :family_address, presence: true
  validates :family_phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: 'はハイフン無しの10桁または11桁で入力してください' }
  validates :birth_day_on, presence: true
  validates :abo_blood_type, presence: true
  validates :rh_blood_type, presence: true
  validates :job_title, presence: true
  validates :hiring_on, presence: true
  validates :experience_term_before_hiring, presence: true
  validates :blank_term, presence: true
  validates :employment_contract, presence: true
  validates :family_name, presence: true
  validates :relationship, presence: true
  validates :sex, presence: true
  validates :driver_licence_number, presence: true, format: { with: /\A\d{12}\z/, message: 'は12桁で入力してください' }, if: :driver_licence_present?
  # validates :status_of_residence, presence: true
  # validates :maturity_date
  # validates :confirmed_check, presence: true
  # validates :confirmed_check_date
  # validates :responsible_director
  # validates :responsible_name
  # validates :responsible_contact_address

  def to_param
    uuid
  end

  def driver_licence_present?
    driver_licence.present?
  end

  # JSON型のカラムからJSONオブジェクトを取得する
  def set_json_data(colum, key, value)
    self.colum ||= {}
    self.colum[key] = value
  end
  
  # JSON型のカラムからJSONオブジェクトを取得する
  def get_json_data(colum, key)
    self.colum.try(:[], key)
  end
  
  # JSON型のカラムから指定したキーに対応する値を削除する
  def delete_json_data(colum, key)
    self.colum.try(:slice!, key)
  end

  private
    def remove_hyphen_to_post_code
      # ハイフンを除外する
      self.post_code = post_code.to_s.gsub(/[-ー]/, '') if post_code.present?
    end

    def full_width_to_half_width(colum_names)
      colum_names.each do |colum_name|
        self.colum.name = colum_name.tr('Ａ-Ｚａ-ｚ０-９', 'A-Za-z0-9')
      end
    end
end
