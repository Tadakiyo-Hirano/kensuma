class CreateMachines < ActiveRecord::Migration[6.1]
  def change
    create_table :machines do |t|
      t.string      :uuid,                  null: false
      t.integer     :name,                 null: false # 機械名
      t.string      :standards_performance, null: false # 規格・性能
      t.string      :control_number,        null: false # 管理番号
      t.string      :inspector,             null: false # 点検者
      t.string      :handler,               null: false # 取扱者
      t.date        :inspection_date,       null: false # 点検年月日
      t.string      :inspection_check                   # 機械名 × 点検事項(✓を記載)
      t.references  :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
