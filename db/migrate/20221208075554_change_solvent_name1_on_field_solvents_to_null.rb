class ChangeSolventName1OnFieldSolventsToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :field_solvents, :solvent_name_1, false
    change_column_null :field_solvents, :carried_quantity_1, false
    change_column_null :field_solvents, :solvent_classification_1, false
    change_column_null :field_solvents, :solvent_ingredients_1, false
  end

  def down
    change_column_null :field_solvents, :solvent_name_1, true
    change_column_null :field_solvents, :carried_quantity_1, true
    change_column_null :field_solvents, :solvent_classification_1, true
    change_column_null :field_solvents, :solvent_ingredients_1, true
  end
end
