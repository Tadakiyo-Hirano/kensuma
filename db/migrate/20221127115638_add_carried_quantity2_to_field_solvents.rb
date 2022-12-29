class AddCarriedQuantity2ToFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    add_column :field_solvents, :carried_quantity_2, :string
    add_column :field_solvents, :carried_quantity_3, :string
    add_column :field_solvents, :carried_quantity_4, :string
    add_column :field_solvents, :carried_quantity_5, :string
  end
end
