class ColumnWith24thReport < ActiveRecord::Migration[6.1]
  def change
    add_column :field_workers, :occupation,               :string                             # 職種（書類記入用）
    add_column :field_workers, :sendoff_education,        :integer, null: false, default: 0   # 送り出し教育 enum

    add_column :worker_insurances, :has_labor_insurance,  :integer, default: 0                # 労働保険特別加入 enum
    
    add_column :worker_medicals, :health_condition,       :integer, null: false, default: 0   # 最近の健康状態 enum
    add_column :worker_medicals, :is_med_exam,            :integer, null: false, default: 0   # 健康診断の受診 enum
    
  end
end
