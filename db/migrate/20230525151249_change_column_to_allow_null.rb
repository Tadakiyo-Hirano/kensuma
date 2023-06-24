class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def up
    change_column :orders, :site_address, :string, null: true # null: trueを明示する必要がある
  end

  def down
    change_column :orders, :site_address, :string, null: false
  end
end
