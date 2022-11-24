class RemoveMakerFromSolvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :solvents, :maker, :string, null: false
  end
end
