class CreateWorkerSafetyHealthEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_safety_health_educations do |t|
      t.json :images
      t.references :worker_id, null: false, foreign_key: true
      t.references :safety_health_education_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :worker_safety_health_educations, [:worker_id, :safety_health_education_id], unique: true, name: 'index_s_h_es'
  end
end
