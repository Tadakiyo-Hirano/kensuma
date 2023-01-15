class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :field_solvents, :solvent_name_1, true
    change_column_null :field_solvents, :solvent_classification, true
    change_column_null :field_solvents, :solvent_ingredients, true
  end

  def down
    change_column_null :field_solvents, :solvent_name_1, false
    change_column_null :field_solvents, :solvent_classification, false
    change_column_null :field_solvents, :solvent_ingredients, false
  end
end
