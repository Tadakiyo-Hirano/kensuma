class CreateWorkerMedicals < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_medicals do |t|
      t.references :worker, null: false, foreign_key: true
      t.date :med_exam_on, null: false # 健康診断日
      t.integer :max_blood_pressure, null: false # 最高
      t.integer :min_blood_pressure, null: false # 最低
      t.date :special_med_exam_on # 診断日
      t.integer :health_condition, null: false, default: 0   # 最近の健康状態 enum
      t.integer :is_med_exam, null: false, default: 0   # 健康診断の受診 enum

      t.timestamps
    end
  end
end
