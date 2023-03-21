class CreateWorkerSkillTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_skill_trainings do |t|
      t.json :images # 技能講習修了証明書の写し
      t.references :worker, foreign_key: true, null: false
      t.references :skill_training, foreign_key: true, null: false

      t.timestamps
    end
    add_index :worker_skill_trainings, [:worker_id, :skill_training_id], unique: true 
  end
end
