class CreateFieldWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :field_workers do |t|
      t.string :uuid, null: false
      t.string :admission_worker_name, null: false
      t.json :content, null: false
      t.date :admission_date_start
      t.date :admission_date_end
      t.date :education_date
      t.string :occupation
      t.integer :sendoff_education
      t.bigint :occupation_id
      t.string :job_description
      t.string :foreign_work_place
      t.date :foreign_date_start
      t.date :foreign_date_end
      t.string :foreign_job
      t.string :foreign_job_description
      t.binary :proper_management_license
      
      t.references :field_workerable, polymorphic: true
      t.timestamps
    end
  end
end
