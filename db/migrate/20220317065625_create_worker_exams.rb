class CreateWorkerExams < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_exams do |t|
      t.references :worker_medical, null: false, foreign_key: true
      t.references :special_med_exam, null: false, foreign_key: true

      t.timestamps
    end
    add_index :worker_exams, [:worker_medical_id, :special_med_exam_id], unique: true
  end
end
