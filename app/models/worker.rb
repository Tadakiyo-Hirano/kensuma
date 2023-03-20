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

  has_one :worker_medical, dependent: :destroy
  accepts_nested_attributes_for :worker_medical, allow_destroy: true

  enum abo_blood_type: { a: 0, b: 1, ab: 2, o: 3 }
  enum rh_blood_type: { plus: 0, minus: 1, rh_null: 2 }
  enum employment_contract: { available: 0, not_available: 1, not_applicable: 2 }, _prefix: true       # 雇用契約書取り交わし状況
  enum sex: { man: 0, woman: 1 }
  enum status_of_residence: { specific_activity: 0, specified_skill: 1 }, _prefix: true # 在留資格
  enum confirmed_check: { checked: 1, unchecked: 0 }, _prefix: true # キャリアアップシステム登録情報が最新であることの確認日

  before_create -> { self.uuid = SecureRandom.uuid }

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヴー・]+\z/u, message: 'はカタカナで入力してください' }
  validates :country, presence: true
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
end
