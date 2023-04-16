class CreateWorkerSpecialEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_special_educations do |t|
      t.json :images # 特別教育修了証明書の写し
      t.references :worker, foreign_key: true, null: false
      t.references :special_education, foreign_key: true, null: false

      t.timestamps
    end
    add_index :worker_special_educations,
              [:worker_id, :special_education_id],
              unique: true,
              name: 'worker_special_education_index' 
  end
end
