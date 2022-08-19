class AddBusinessHealthInsuranceStatusesToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :business_health_insurance_status, :integer, null: false  # 健康保険(加入状況) enum
  end
end
