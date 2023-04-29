class AddSitesToOrders < ActiveRecord::Migration[6.1]
  def change

    ## 現場
    add_column :orders, :site_career_up_id, :string              # 現場ID(キャリアアップシステム)
    add_column :orders, :site_address,      :string, null: false # 施工場所住所

    ## 発注者
    add_column :orders, :order_supervisor_name,    :string, null: false # 監督員(氏名)
    add_column :orders, :order_supervisor_company, :string              # 監督員(所属会社名)
    add_column :orders, :order_supervisor_apply,   :string, null: false # 監督員(権限及び意見の申出方法)

    ## 元請会社
    add_column :orders, :construction_name,                              :string,  null: false  # 工事名
    add_column :orders, :construction_details,                           :string                # 工事内容
    add_column :orders, :start_date,                                     :date                  # 工期(自)
    add_column :orders, :end_date,                                       :date                  # 工期(至)
    add_column :orders, :contract_date,                                  :date                  # 契約日

    add_column :orders, :site_agent_name,                                :string,  null: false  # 現場代理人(氏名)
    add_column :orders, :site_agent_apply,                               :string,  null: false  # 現場代理人(権限及び意見の申出方法)

    add_column :orders, :supervisor_name,                                :string,  null: false  # 監督員(氏名)
    add_column :orders, :supervisor_apply,                               :string,  null: false  # 監督員(権限及び意見の申出方法)

    add_column :orders, :professional_engineer_name_1st,                 :string                # 専門技術者1(氏名)
    add_column :orders, :professional_engineer_qualification_1st,        :string                # 専門技術者1(資格内容)
    add_column :orders, :professional_engineer_details_1st,              :string                # 専門技術者1(担当工事内容)
    add_column :orders, :professional_engineer_name_2nd,                 :string                # 専門技術者2(氏名)
    add_column :orders, :professional_engineer_qualification_2nd,        :string                # 専門技術者2(資格内容)
    add_column :orders, :professional_engineer_details_2nd,              :string                # 専門技術者2(担当工事内容)

    add_column :orders, :supervising_engineer_name,                      :string,  null: false  # 監督技術者･主任技術者(氏名)
    add_column :orders, :supervising_engineer_check,                     :integer, null: false  # 監督技術者・主任技術者(専任or非専任)〇を付ける
    add_column :orders, :supervising_engineer_qualification,             :string                # 監督技術者･主任技術者(資格内容)

    add_column :orders, :supervising_engineer_assistant_name,            :string                # 監督技術者補佐(氏名)
    add_column :orders, :supervising_engineer_assistant_qualification,   :string                # 監督技術者補佐(資格内容)

    add_column :orders, :general_safety_responsible_person_name,         :string                # 統括安全衛生責任者(氏名)
    add_column :orders, :general_safety_agent_name,                      :string                # 統括安全衛生責任者代行者(氏名)
    add_column :orders, :health_and_safety_manager_name,                 :string,  null: false  # 元方安全衛生管理者(氏名)

    add_column :orders, :submission_destination,                         :string,  null: false  # 提出先及び担当者(部署･氏名)
  end
end
