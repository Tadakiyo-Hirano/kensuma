class CreateSolvents < ActiveRecord::Migration[6.1]
  def change
    create_table :solvents do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :maker, null: false
      t.string :classification, null: false
      t.string :ingredients, null: false
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
