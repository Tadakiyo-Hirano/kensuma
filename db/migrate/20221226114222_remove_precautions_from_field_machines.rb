class RemovePrecautionsFromFieldMachines < ActiveRecord::Migration[6.1]
  def change
    remove_column :field_machines, :precautions, :string
  end
end
