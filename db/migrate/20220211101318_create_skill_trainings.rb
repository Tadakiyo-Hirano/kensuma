class CreateSkillTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :skill_trainings do |t|
      t.string :name, null: false
      t.string :short_name, null: false
      t.integer :driving_related
      t.json :details

      t.timestamps
    end
  end
end
