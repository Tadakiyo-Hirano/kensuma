class AddColumn2Machine < ActiveRecord::Migration[6.1]
  def change
    add_column :machines, :extra_inspection_item6, :string
  end
end
