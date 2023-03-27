class CreateWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :workers do |t|
      t.string :name, null: false # 氏名
      t.string :name_kana, null: false # フリガナ
      t.string :country, null: false # 国籍
      t.string :my_address, null: false # 住所
      t.string :my_phone_number, null: false # 電話番号
      t.string :family_address, null: false # [緊急連絡先]住所
      t.string :family_phone_number, null: false # [緊急連絡先]電話番号
      t.date :birth_day_on, null: false # 生年月日
      t.integer :abo_blood_type, null: false, default: 0 # 血液型
      t.integer :rh_blood_type, null: false, default: 0 # 血液型（RH）
      t.date :hiring_on, null: false # 雇入年月日
      t.integer :experience_term_before_hiring, null: false # 雇入前経験年数
      t.integer :blank_term, null: false # ブランク年数
      t.string :career_up_id # 技能者ID(キャリアアップシステム)
      t.json :career_up_image # 建設キャリアアップシステムカードの写し
      t.references :business, foreign_key: true, null: false
      t.string :uuid, null: false
      t.json :job_title, null: false # 役職
      t.integer :employment_contract, null: false, default: 0 # 雇用契約書 enum
      t.string :family_name,null: false # [緊急連絡先]氏名
      t.string :relationship,null: false # [緊急連絡先]続柄
      t.string :email # メールアドレス
      t.integer :sex, null: false, default: 0 # 性別
      t.integer :status_of_residence # 在留資格
      t.date :maturity_date # 在留期間満期日
      t.integer :confirmed_check # キャリアアップシステム登録情報が最新であることの確認済
      t.date :confirmed_check_date # キャリアアップシステム登録情報が最新であることの確認日
      t.string :passport_front # パスポートの写し表
      t.string :passport_back # パスポートの写し裏
      t.string :residence_card_front # 在留カードの写し表
      t.string :residence_card_back # 在留カードの写し裏
      t.string :employment_condition # 受入企業と外国人建設就労者等との間の雇用条件書の写し
      t.integer :post_code # 郵便番号
      t.string :driver_licence # 自動車運転免許
      t.string :driver_licence_number # 免許証番号
      t.string :seal # 認印
      t.json :employee_card # 従業員証

      t.timestamps
    end
  end
end
