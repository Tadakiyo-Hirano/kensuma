class CreateWorkerSkillTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_skill_trainings do |t|
      t.json :images
      t.references :worker, foreign_key: true, null: false
      t.references :skill_training, foreign_key: true, null: false

      t.timestamps
    end
    add_index :worker_skill_trainings, [:worker_id, :skill_training_id], unique: true 
  end
end
