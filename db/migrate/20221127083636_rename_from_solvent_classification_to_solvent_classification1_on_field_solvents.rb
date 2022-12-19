class RenameFromSolventClassificationToSolventClassification1OnFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :field_solvents, :solvent_classification, :solvent_classification_1
    rename_column :field_solvents, :solvent_ingredients, :solvent_ingredients_1
  end
end
