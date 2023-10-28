class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :worker_insurances, :health_insurance_type, true
    change_column_null :worker_insurances, :pension_insurance_type, true
    change_column_null :worker_insurances, :severance_pay_mutual_aid_type, true
  end

  def down
    change_column_null :worker_insurances, :health_insurance_type, false
    change_column_null :worker_insurances, :pension_insurance_type, false
    change_column_null :worker_insurances, :severance_pay_mutual_aid_type, false
  end
end
