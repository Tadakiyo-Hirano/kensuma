class CreateFieldFireFireManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :field_fire_fire_managements do |t|
      t.references :field_fire, null: false, foreign_key: true
      t.references :fire_management, null: false, foreign_key: true

      t.timestamps
    end
  end
end
