class CreateWorkerInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_insurances do |t|
      t.integer :health_insurance_type, null: false # 健康保険 emum
      t.string :health_insurance_name # 保険名
      t.json :health_insurance_image # 健康保険証の写し
      t.integer :pension_insurance_type, null: false # 年金保険 emum
      t.integer :employment_insurance_type # 雇用保険 emum
      t.integer :has_labor_insurance # 労働保険特別加入 enum
      t.string :employment_insurance_number # 被保険者番号
      t.integer :severance_pay_mutual_aid_type, null: false # 建設業退職金共済手帳 emum
      t.string :severance_pay_mutual_aid_name # その他（　　　）
      t.references :worker, foreign_key: true, null: false

      t.timestamps
    end
  end
end
