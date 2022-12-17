class ChangeDateSubmittedOnFieldSolventsToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :field_solvents, :date_submitted, false
  end

  def down
    change_column_null :field_solvents, :date_submitted, true
  end
end
