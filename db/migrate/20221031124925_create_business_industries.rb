class CreateBusinessIndustries < ActiveRecord::Migration[6.1]
  def change
    create_table :business_industries do |t|
      t.references :business, null: false, foreign_key: true
      t.references :industry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
