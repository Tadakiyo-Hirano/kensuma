class AddBusinessHealthInsuranceStatusesToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :business_health_insurance_status,                 :integer, null: false  # 健康保険(加入状況) enum
    add_column :businesses, :business_health_insurance_association,            :string                # 健康保険(組合名)
    add_column :businesses, :business_health_insurance_office_number,          :string                # 健康保険(事業所整理記号及び事業所番号)

    add_column :businesses, :business_welfare_pension_insurance_join_status,   :integer, null: false  # 厚生年金保険(加入状況) enum
    add_column :businesses, :business_welfare_pension_insurance_office_number, :string                # 厚生年金保険(事業所整理記号)

    add_column :businesses, :business_pension_insurance_join_status,           :integer, null: false  # 年金保険(加入状況) enum

    add_column :businesses, :business_employment_insurance_join_status,        :integer, null: false  # 雇用保険(加入状況) enum
    add_column :businesses, :business_employment_insurance_number,             :string                # 雇用保険(番号)

    add_column :businesses, :business_retirement_benefit_mutual_aid_status,    :integer, null: false  # 退職金共済制度(加入状況) enum
  end
end
