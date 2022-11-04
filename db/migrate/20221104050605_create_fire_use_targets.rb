class CreateFireUseTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :fire_use_targets do |t|
      t.string :name

      t.timestamps
    end
  end
end
