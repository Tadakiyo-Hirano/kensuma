class RemoveDateSubmittedFromFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :field_solvents, :date_submitted, :date, null: false
  end
end
