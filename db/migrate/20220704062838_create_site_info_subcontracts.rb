class CreateSiteInfoSubcontracts < ActiveRecord::Migration[6.1]
  def change
    create_table :site_info_subcontracts do |t|
      t.string     :construction_name,                  null: false                    # 工事名
      t.string     :construction_details,               null: false                    # 工事内容
      t.date       :start_date,                         null: false                    # 工期(自)
      t.date       :end_date,                           null: false                    # 工期(至)
      t.date       :contract_date,                      null: false                    # 契約日
      t.string     :site_agent_name,                    null: false                    # 現場代理人(氏名)
      t.string     :site_agent_apply,                   null: false                    # 現場代理人(権限及び意見の申出方法)
      t.string     :supervisor_name,                    null: false                    # 監督員(氏名)
      t.string     :supervisor_apply,                   null: false                    # 監督員(権限及び意見の申出方法)
      t.string     :professional_engineer_name                                         # 専門技術者(氏名)
      t.string     :professional_engineer_details                                      # 専門技術者(担当工事内容)
      t.integer    :professional_construction                                          # 特定専門工事(有無)
      t.string     :construction_manager_name,          null: false                    # 工事担任責任者(氏名)
      t.string     :construction_manager_position_name, null: false                    # 工事担任責任者(役職名)
      t.string     :lead_engineer_name,                 null: false                    # 主任技術者(氏名)
      t.integer    :lead_engineer_check,                null: false                    # 主任技術者(専任or非専任)
      t.string     :work_chief_name,                    null: false                    # 作業主任者(氏名)
      t.string     :work_conductor_name,                null: false                    # 作業指揮者名(氏名)
      t.string     :safety_officer_name,                null: false                    # 安全衛生担当責任者(氏名)
      t.string     :safety_manager_name,                null: false                    # 安全衛生責任者(氏名)
      t.string     :safety_promoter_name,               null: false                    # 安全推進者(氏名)
      t.string     :foreman_name,                       null: false                    # 職長(氏名)
      t.string     :registered_core_engineer_name,      null: false                    # 登録基幹技能者(氏名)
      t.references :business,                           null: false, foreign_key: true
      t.references :request_order,                      null: false, foreign_key: true

      t.timestamps
    end
  end
end
