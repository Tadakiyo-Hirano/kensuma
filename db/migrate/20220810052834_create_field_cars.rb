class CreateFieldCars < ActiveRecord::Migration[6.1]
  def change
    create_table :field_cars do |t|
      t.string :uuid, null: false
      t.string :car_name, null: false
      t.json :content, null: false
      t.string :driver_name
      t.date :usage_period_start
      t.date :usage_period_end
      t.string :starting_point
      t.string :waypoint_first
      t.string :waypoint_second
      t.string :arrival_point
      t.references :field_carable, polymorphic: true

      t.timestamps
    end
  end
end
