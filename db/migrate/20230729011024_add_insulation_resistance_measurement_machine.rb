class AddInsulationResistanceMeasurementMachine < ActiveRecord::Migration[6.1]
  def change
    add_column :machines, :insulation_resistance_measurement, :integer
  end
end
