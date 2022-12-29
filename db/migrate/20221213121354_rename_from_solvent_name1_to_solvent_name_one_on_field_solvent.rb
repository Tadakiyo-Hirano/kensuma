class RenameFromSolventName1ToSolventNameOneOnFieldSolvent < ActiveRecord::Migration[6.1]
  def change
    rename_column :field_solvents, :solvent_name_1, :solvent_name_one
    rename_column :field_solvents, :solvent_name_2, :solvent_name_two
    rename_column :field_solvents, :solvent_name_3, :solvent_name_three
    rename_column :field_solvents, :solvent_name_4, :solvent_name_four
    rename_column :field_solvents, :solvent_name_5, :solvent_name_five

    rename_column :field_solvents, :carried_quantity_1, :carried_quantity_one
    rename_column :field_solvents, :carried_quantity_2, :carried_quantity_two
    rename_column :field_solvents, :carried_quantity_3, :carried_quantity_three
    rename_column :field_solvents, :carried_quantity_4, :carried_quantity_four
    rename_column :field_solvents, :carried_quantity_5, :carried_quantity_five

    rename_column :field_solvents, :solvent_classification_1, :solvent_classification_one
    rename_column :field_solvents, :solvent_classification_2, :solvent_classification_two
    rename_column :field_solvents, :solvent_classification_3, :solvent_classification_three
    rename_column :field_solvents, :solvent_classification_4, :solvent_classification_four
    rename_column :field_solvents, :solvent_classification_5, :solvent_classification_five

    rename_column :field_solvents, :solvent_ingredients_1, :solvent_ingredients_one
    rename_column :field_solvents, :solvent_ingredients_2, :solvent_ingredients_two
    rename_column :field_solvents, :solvent_ingredients_3, :solvent_ingredients_three
    rename_column :field_solvents, :solvent_ingredients_4, :solvent_ingredients_four
    rename_column :field_solvents, :solvent_ingredients_5, :solvent_ingredients_five
  end
end
