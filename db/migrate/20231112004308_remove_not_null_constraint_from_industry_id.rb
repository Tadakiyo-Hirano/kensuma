class RemoveNotNullConstraintFromIndustryId < ActiveRecord::Migration[6.1]
  def change
    change_column_null :business_industries, :industry_id, true
  end
end
