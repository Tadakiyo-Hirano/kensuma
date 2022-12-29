class RenameFromSolventNameToSolventName1OnFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :field_solvents, :solvent_name, :solvent_name_1
  end
end
