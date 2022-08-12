class AddColumnsToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :usage, :integer, null: false
    add_column :cars, :vehicle_name, :string, null: false
  end
end
