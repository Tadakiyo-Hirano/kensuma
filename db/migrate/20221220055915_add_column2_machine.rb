class AddColumn2Machine < ActiveRecord::Migration[6.1]
  def change
    add_column :machines, :extra_inspection_item6, :string
    add_column :machines, :insulation_resistance_measurement, :integer
  end
end
