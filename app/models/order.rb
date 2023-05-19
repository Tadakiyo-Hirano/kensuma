class Order < ApplicationRecord
  belongs_to :business
  has_many :request_orders, dependent: :destroy
  has_many :field_workers, as: :field_workerable, dependent: :destroy
  has_many :field_cars, as: :field_carable, dependent: :destroy
  has_many :field_fires, as: :field_fireable, dependent: :destroy
  has_many :field_solvents, as: :field_solventable, dependent: :destroy
  has_many :field_special_vehicles, as: :field_special_vehicleable, dependent: :destroy
  has_many :field_machines, as: :field_machineable, dependent: :destroy

  enum supervising_engineer_check: { full_time: 0, non_dedicated: 1 }

  # 現場
  validates :site_career_up_id, numericality: { only_integer: true }, length: { minimum: 14, maximum: 14 }, allow_blank: true
  validates :site_name,    presence: true, length: { maximum: 100 } # 事業所名(現場名)
  validates :site_address, presence: true, length: { maximum: 50 }  # 施工場所(住所)

  # 発注者
  validates :order_name,             presence: true                                          # 発注者(会社名or氏名)
  validates :order_post_code,        presence: true, format: { with: /\A\^\d{5}$|^\d{7}\z/ } # 発注者(郵便番号)
  validates :order_address,          presence: true                                          # 発注者(住所)
  validates :order_supervisor_name,  presence: true                                          # 監督員(氏名)
  validates :order_supervisor_apply, presence: true, length: { maximum: 40 }                 # 監督員(権限及び意見の申出方法)

  # 元請会社
  validates :construction_name,                          presence: true                          # 工事名
  validates :start_date,                                 presence: true                          # 工期(自)
  validates :end_date,                                   presence: true                          # 工期(至)
  validates :contract_date,                              presence: true                          # 契約日
  validates :site_agent_name,                            presence: true                          # 現場代理人(氏名)
  validates :site_agent_apply,                           presence: true, length: { maximum: 40 } # 現場代理人(権限及び意見の申出方法)
  validates :supervisor_name,                            presence: true                          # 監督員(氏名)
  validates :supervisor_apply,                           presence: true, length: { maximum: 40 } # 監督員(権限及び意見の申出方法)
  validates :supervising_engineer_name,                  presence: true                          # 監督技術者･主任技術者(氏名)
  validates :supervising_engineer_check,                 presence: true                          # 監督技術者・主任技術者(専任or非専任)
  validates :health_and_safety_manager_name,             presence: true                          # 元方安全衛生管理者(氏名)
  validates :submission_destination,                     presence: true                          # 提出先及び担当者(部署･氏名)

  # 氏名無しで更新させない
  validate :name_is_required_professional_engineer_name_1st
  validate :name_is_required_professional_engineer_name_2nd
  validate :name_is_required_supervising_engineer_assistant_qualification

  before_create -> { self.site_uu_id = SecureRandom.uuid }

  def to_param
    site_uu_id
  end

  private

    def name_is_required_professional_engineer_name_1st
      if professional_engineer_name_1st.blank? && (professional_engineer_details_1st.present? || professional_engineer_qualification_1st.present?)
        errors.add(:professional_engineer_name_1st, '専門技術者の氏名を入力してください')
      end
    end

    def name_is_required_professional_engineer_name_2nd
      if professional_engineer_name_2nd.blank? && (professional_engineer_details_2nd.present? || professional_engineer_qualification_2nd.present?)
        errors.add(:professional_engineer_name_2nd, '専門技術者2の氏名を入力してください')
      end
    end  

    def name_is_required_supervising_engineer_assistant_qualification
      if supervising_engineer_assistant_name.blank? && supervising_engineer_assistant_qualification.present?
        errors.add(:supervising_engineer_assistant_name, '監督技術者補佐の氏名を入力してください')
      end
    end    
  end
