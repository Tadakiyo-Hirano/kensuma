class CreateWorkerSafetyHealthEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_safety_health_educations do |t|
      t.json :images
      t.references :worker, null: false, foreign_key: true
      t.references :safety_health_education, null: false, foreign_key: true, index: { name: 'index_safety_health_education_id' }

      t.timestamps
    end
    add_index :worker_safety_health_educations, [:worker_id, :safety_health_education_id], unique: true, name: 'idx_w_s_h_e'
  end
end
