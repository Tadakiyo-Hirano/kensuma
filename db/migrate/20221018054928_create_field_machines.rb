class CreateFieldMachines < ActiveRecord::Migration[6.1]
  def change
    create_table :field_machines do |t|
      t.string :uuid, null: false
      t.string :machine_name, null: false
      t.json :content, null: false
      t.date :carry_on_date
      t.date :carry_out_date
      t.string :precautions
      t.references :field_machineable, polymorphic: true

      t.timestamps
    end
  end
end
