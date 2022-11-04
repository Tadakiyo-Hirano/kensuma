class CreateFieldFires < ActiveRecord::Migration[6.1]
  def change
    create_table :field_fires do |t|
      t.string :uuid, null: false
      t.string :use_place, null: false
      t.string :other_usages
      t.date :usage_period_start
      t.date :usage_period_end
      t.time :usage_time_start
      t.time :usage_time_end
      t.string :precautions
      t.string :fire_origin_responsible
      t.string :fire_use_responsible
      t.references :field_fireable, polymorphic: true

      t.timestamps
    end
  end
end
