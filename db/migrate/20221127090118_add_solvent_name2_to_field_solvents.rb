class AddSolventName2ToFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    add_column :field_solvents, :solvent_name_2, :string
    add_column :field_solvents, :solvent_name_3, :string
    add_column :field_solvents, :solvent_name_4, :string
    add_column :field_solvents, :solvent_name_5, :string

    add_column :field_solvents, :solvent_classification_2, :string
    add_column :field_solvents, :solvent_classification_3, :string
    add_column :field_solvents, :solvent_classification_4, :string
    add_column :field_solvents, :solvent_classification_5, :string

    add_column :field_solvents, :solvent_ingredients_2, :string
    add_column :field_solvents, :solvent_ingredients_3, :string
    add_column :field_solvents, :solvent_ingredients_4, :string
    add_column :field_solvents, :solvent_ingredients_5, :string
  end
end
