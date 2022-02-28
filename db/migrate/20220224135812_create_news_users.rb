class CreateNewsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :news_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :news, null: false, foreign_key: true

      t.timestamps
    end
  end
end
