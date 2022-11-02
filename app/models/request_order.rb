class RequestOrder < ApplicationRecord
  belongs_to :order
  belongs_to :business
  has_many :documents, dependent: :destroy
  has_many :field_workers, as: :field_workerable, dependent: :destroy
  has_many :field_cars, as: :field_carable, dependent: :destroy
  has_many :field_solvents, as: :field_solventable, dependent: :destroy
  has_many :field_special_vehicles, as: :field_special_vehicleable, dependent: :destroy
  has_many :field_machines, as: :field_machineable, dependent: :destroy

  enum status: { requested: 0, submitted: 1, fix_requested: 2, approved: 3 }
  enum professional_construction: { y: 0, n: 1 }
  enum lead_engineer_check: { full_time: 0, non_dedicated: 1 }

  validates :construction_name,                  presence: true, on: :update  # 工事名
  validates :construction_details,               presence: true, on: :update  # 工事内容
  validates :start_date,                         presence: true, on: :update  # 工期(自)
  validates :end_date,                           presence: true, on: :update  # 工期(至)
  validates :contract_date,                      presence: true, on: :update  # 契約日
  validates :supervisor_name,                    presence: true, on: :update  # 監督員(氏名)
  validates :supervisor_apply,                   presence: true, on: :update  # 監督員(権限及び意見の申出方法)
  validates :construction_manager_name,          presence: true, on: :update  # 工事担任責任者(氏名)
  validates :construction_manager_position_name, presence: true, on: :update  # 工事担任責任者(役職名)
  validates :site_agent_name,                    presence: true, on: :update  # 現場代理人(氏名)
  validates :site_agent_apply,                   presence: true, on: :update  # 現場代理人(権限及び意見の申出方法)
  validates :lead_engineer_name,                 presence: true, on: :update  # 主任技術者(氏名)
  validates :lead_engineer_check,                presence: true, on: :update  # 主任技術者(専任or非専任)
  validates :work_chief_name,                    presence: true, on: :update  # 作業主任者(氏名)
  validates :work_conductor_name,                presence: true, on: :update  # 作業指揮者名(氏名)
  validates :safety_officer_name,                presence: true, on: :update  # 安全衛生担当責任者(氏名)
  validates :safety_manager_name,                presence: true, on: :update  # 安全衛生責任者(氏名)
  validates :safety_promoter_name,               presence: true, on: :update  # 安全推進者(氏名)
  validates :foreman_name,                       presence: true, on: :update  # 職長(氏名)

  has_closure_tree

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
