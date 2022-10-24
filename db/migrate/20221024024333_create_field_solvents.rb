class CreateFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    create_table :field_solvents do |t|
      t.string :uuid, null: false
      t.string :solvent_name, null: false
      t.json :content, null: false
      t.string :carried_quantity
      t.string :using_location
      t.string :storing_place
      t.string :using_tool
      t.date :usage_period_start
      t.date :usage_period_end
      t.integer :working_process
      t.integer :sds
      t.string :ventilation_control

      t.timestamps
    end
  end
end
