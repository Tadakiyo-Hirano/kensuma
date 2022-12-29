class AddColumnsToFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    add_column :field_solvents, :solvent_classification, :string, null: false
    add_column :field_solvents, :solvent_ingredients, :string, null: false
  end
end
