class CreateIndustries < ActiveRecord::Migration[6.1]
  def change
    create_table :industries do |t|
      t.string :name, null: false
      t.timestamps
    end
    
    add_reference :occupations, :industry, foreign_key: true
  end
end
