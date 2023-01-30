class RemoveInspectionDateFromMachines < ActiveRecord::Migration[6.1]
  def change
    remove_column :machines, :inspection_date, :date, null: false
  end
end
