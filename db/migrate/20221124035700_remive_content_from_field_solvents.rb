class RemiveContentFromFieldSolvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :field_solvents, :content, :json, null: false
  end
end
