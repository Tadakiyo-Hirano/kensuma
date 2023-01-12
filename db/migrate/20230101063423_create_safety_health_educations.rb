class CreateSafetyHealthEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :safety_health_educations do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
