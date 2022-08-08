class CreateFieldWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :field_workers do |t|
      t.string :uuid, null: false
      t.string :admission_worker_name, null: false
      t.json :content, null: false
      t.date :admission_date_start
      t.date :admission_date_end
      t.date :education_date
      t.references :field_workerable, polymorphic: true

      t.timestamps
    end
  end
end
