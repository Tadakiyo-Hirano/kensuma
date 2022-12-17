class AddDateSubmittedToFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    add_column :field_solvents, :date_submitted, :date
  end
end
