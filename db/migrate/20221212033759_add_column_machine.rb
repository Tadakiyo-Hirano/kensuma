class AddColumnMachine < ActiveRecord::Migration[6.1]
  def change
    add_column :machines, :extra_inspection_item1, :string
    add_column :machines, :extra_inspection_item2, :string
    add_column :machines, :extra_inspection_item3, :string
    add_column :machines, :extra_inspection_item4, :string
    add_column :machines, :extra_inspection_item5, :string
  end
end
