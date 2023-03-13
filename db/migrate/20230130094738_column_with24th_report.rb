class ColumnWith24thReport < ActiveRecord::Migration[6.1]
  def change
    add_column :field_workers, :occupation,               :string                             # 職種（書類記入用）
    add_column :field_workers, :sendoff_education,        :integer, null: false, default: 0   # 送り出し教育 enum
  end
end
