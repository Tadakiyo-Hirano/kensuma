class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.json :site_content
      t.json :orderer_content
      t.json :prime_content
      t.json :sub_content
      t.json :share_content
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
