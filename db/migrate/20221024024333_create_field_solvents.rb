class CreateFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    create_table :field_solvents do |t|
      t.string :uuid, null: false
      t.string :solvent_name_one, null: false
      t.string :solvent_name_two
      t.string :solvent_name_three
      t.string :solvent_name_four
      t.string :solvent_name_five
      t.string :carried_quantity_one, null: false
      t.string :carried_quantity_two
      t.string :carried_quantity_three
      t.string :carried_quantity_four
      t.string :carried_quantity_five
      t.string :solvent_classification_one, null: false
      t.string :solvent_classification_two
      t.string :solvent_classification_three
      t.string :solvent_classification_four
      t.string :solvent_classification_five
      t.string :solvent_ingredients_one, null: false
      t.string :solvent_ingredients_two
      t.string :solvent_ingredients_three
      t.string :solvent_ingredients_four
      t.string :solvent_ingredients_five
      t.string :using_location
      t.string :storing_place
      t.string :using_tool
      t.date :usage_period_start
      t.date :usage_period_end
      t.integer :working_process
      t.integer :sds
      t.string :ventilation_control
      t.references :field_solventable, polymorphic: true

      t.timestamps
    end
  end
end
