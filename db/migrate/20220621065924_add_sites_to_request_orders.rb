class AddSitesToRequestOrders < ActiveRecord::Migration[6.1]
  def change

    ## 下請会社

    add_column :request_orders, :occupation,                                  :string   # 職種
    add_column :request_orders, :construction_name,                           :string   # 工事名
    add_column :request_orders, :construction_details,                        :string   # 工事内容
    add_column :request_orders, :start_date,                                  :date     # 工期(自)
    add_column :request_orders, :end_date,                                    :date     # 工期(至)
    add_column :request_orders, :contract_date,                               :date     # 契約日

    add_column :request_orders, :site_agent_name,                             :string   # 現場代理人(氏名)
    add_column :request_orders, :site_agent_apply,                            :string   # 現場代理人(権限及び意見の申出方法)

    add_column :request_orders, :supervisor_name,                             :string   # 監督員(氏名)
    add_column :request_orders, :supervisor_apply,                            :string   # 監督員(権限及び意見の申出方法)

    add_column :request_orders, :professional_engineer_name,                  :string   # 専門技術者(氏名)
    add_column :request_orders, :professional_engineer_details,               :string   # 専門技術者(担当工事内容)
    add_column :request_orders, :professional_engineer_qualification,         :string   # 専門技術者(資格内容)

    add_column :request_orders, :professional_construction,                   :integer  # 特定専門工事(有無)

    add_column :request_orders, :construction_manager_name,                   :string   # 工事担任責任者(氏名)
    add_column :request_orders, :construction_manager_position_name,          :string   # 工事担任責任者(役職名)

    add_column :request_orders, :lead_engineer_name,                          :string   # 主任技術者(氏名)
    add_column :request_orders, :lead_engineer_check,                         :integer  # 主任技術者(専任or非専任)
    add_column :request_orders, :lead_engineer_qualification,                 :string   # 主任技術者(資格内容)

    add_column :request_orders, :work_chief_name,                             :string   # 作業主任者(氏名)
    add_column :request_orders, :work_conductor_name,                         :string   # 作業指揮者名(氏名)
    add_column :request_orders, :safety_officer_name,                         :string   # 安全衛生担当責任者(氏名)
    add_column :request_orders, :safety_manager_name,                         :string   # 安全衛生責任者(氏名)
    add_column :request_orders, :safety_promoter_name,                        :string   # 安全推進者(氏名)
    add_column :request_orders, :foreman_name,                                :string   # 職長(氏名)
    add_column :request_orders, :registered_core_engineer_name,               :string   # 登録基幹技能者(氏名)
    add_column :request_orders, :registered_core_engineer_qualification,      :string   # 登録基幹技能者(資格内容)
    add_column :request_orders, :construction_license,                        :json     # 工事に必要な建設許可証

  end
end
