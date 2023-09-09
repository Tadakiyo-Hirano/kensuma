class AddNameKanaToTables < ActiveRecord::Migration[6.1]
  def change
    add_column :special_educations, :name_kana, :string
    add_column :skill_trainings, :name_kana, :string
    add_column :licenses, :name_kana, :string
    add_column :safety_health_educations, :name_kana, :string
  end
end
