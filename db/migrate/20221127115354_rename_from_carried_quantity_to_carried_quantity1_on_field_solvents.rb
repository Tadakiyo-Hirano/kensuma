class RenameFromCarriedQuantityToCarriedQuantity1OnFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :field_solvents, :carried_quantity, :carried_quantity_1
  end
end
