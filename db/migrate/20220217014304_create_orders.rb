class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.boolean :system_chart_status, null: false, default: false
      t.boolean :edit_status, null: false, default: false
      t.string :site_uu_id, null: false
      t.string :site_name, null: false
      t.string :order_name, null: false
      t.string :order_post_code, null: false
      t.string :order_address, null: false
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
