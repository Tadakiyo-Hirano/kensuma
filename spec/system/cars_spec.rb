require 'rails_helper'

RSpec.describe 'Cars', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:car_insurance_company) { create(:car_insurance_company) }
  let(:car) { create(:car, business: business, car_insurance_company: car_insurance_company) }
  let(:car_voluntary_insurance) do
    create(:car_voluntary_insurance, car_voluntary_id: car.id, company_voluntary_id: car_insurance_company.id)
  end

  describe '車両関連' do
    before(:each) do
      # ステージングにて一時的にメール認証スキップ中の為下記コメント
      # user.skip_confirmation!
      user.save!
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後車両情報一覧画面へ遷移できること' do
      visit users_cars_path
      expect(page).to have_content '車両情報一覧'
    end

    context '車両情報登録' do
      it '新規登録したあと詳細画面へ遷移すること' do
        CarInsuranceCompany.create!(name: 'test_company1')
        CarInsuranceCompany.create!(name: 'test_company2')

        visit new_users_car_path

        # 使用目的
        select '通勤用', from: 'car[usage]'
        # 車両所有者氏名
        fill_in 'car[owner_name]', with: car.owner_name
        # 安全運転管理者
        fill_in 'car[safety_manager]', with: car.safety_manager
        # 車両型名
        fill_in 'car[vehicle_name]', with: car.vehicle_name
        # 車両型式
        fill_in 'car[vehicle_model]', with: car.vehicle_model
        # 車両番号
        fill_in 'car[vehicle_number]', with: car.vehicle_number
        # 車検初め
        fill_in 'car[vehicle_inspection_start_on]', with: car.vehicle_inspection_start_on
        # 車検終わり
        fill_in 'car[vehicle_inspection_end_on]', with: car.vehicle_inspection_end_on

        # ========== 自賠責保険ここから ==========
        # 自賠責保険会社
        select 'test_company1', from: 'car_car_insurance_company_id'
        # 自賠責証券番号
        fill_in 'car[liability_securities_number]', with: car.liability_securities_number
        # 自賠責保険初め
        fill_in 'car[liability_insurance_start_on]', with: car.liability_insurance_start_on
        # 自賠責保険終わり
        fill_in 'car[liability_insurance_end_on]', with: car.liability_insurance_end_on

        # ========== 自賠責保険ここまで ==========

        # ========== 任意保険ここから ==========
        # 任意保険会社
        select 'test_company2', from: 'car_car_voluntary_insurances_attributes_0_company_voluntary_id'
        # 対人保険金
        select car_voluntary_insurance.personal_insurance, from: 'car_car_voluntary_insurances_attributes_0_personal_insurance'
        # 対物保険金
        select car_voluntary_insurance.objective_insurance, from: 'car_car_voluntary_insurances_attributes_0_objective_insurance'
        # 任意保険証券番号
        fill_in 'car[car_voluntary_insurances_attributes][0][voluntary_securities_number]', with: car_voluntary_insurance.voluntary_securities_number.to_i
        # 任意保険初め
        fill_in 'car[car_voluntary_insurances_attributes][0][voluntary_insurance_start_on]', with: car_voluntary_insurance.voluntary_insurance_start_on
        # 任意保険終わり
        fill_in 'car[car_voluntary_insurances_attributes][0][voluntary_insurance_end_on]', with: car_voluntary_insurance.voluntary_insurance_end_on
        # ========== 任意保険ここまで ==========

        click_button '登録'

        visit users_car_path(car)
        expect(page).to have_content '車両情報詳細'
        expect(page).to have_content car.owner_name
      end
    end

    context '車両情報編集' do
      it '更新したあと詳細画面へ遷移すること' do
        visit edit_users_car_path(car)

        fill_in 'car[owner_name]', with: 'edit name'
        click_button '更新'

        visit users_car_path(car)
        expect(page).to have_content '車両情報詳細'
        expect(page).to have_content 'edit name'
      end
    end

    context '車両情報削除' do
      it '削除したあと一覧画面に遷移すること', js: true do
        visit users_car_path(car)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq "#{car.vehicle_model}の車両情報を削除します。本当によろしいですか？"
          expect(page).to have_content "#{car.vehicle_model}を削除しました"
        }.to change(Car, :count).by(-1)

        visit users_cars_path
        expect(page).to have_content '車両情報一覧'
      end
    end
  end
end
