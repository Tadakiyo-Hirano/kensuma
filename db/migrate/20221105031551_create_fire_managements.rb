class CreateFireManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :fire_managements do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
