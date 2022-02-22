require 'rails_helper'

RSpec.describe 'Cars', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:car) { create(:car, business: business) }

  describe '車両関連' do
    before(:each) do
      user.skip_confirmation!
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
        visit new_users_car_path

        fill_in 'car[owner_name]', with: car.owner_name
        fill_in 'car[safety_manager]', with: car.safety_manager
        fill_in 'car[vehicle_model]', with: car.vehicle_model
        fill_in 'car[vehicle_number]', with: car.vehicle_number
        fill_in 'car[vehicle_inspection_start_on]', with: car.vehicle_inspection_start_on
        fill_in 'car[vehicle_inspection_end_on]', with: car.vehicle_inspection_end_on
        fill_in 'car[liability_securities_number]', with: car.liability_securities_number
        fill_in 'car[liability_insurance_start_on]', with: car.liability_insurance_start_on
        fill_in 'car[liability_insurance_end_on]', with: car.liability_insurance_end_on
        fill_in 'car[voluntary_securities_number]', with: car.voluntary_securities_number
        fill_in 'car[voluntary_insurance_start_on]', with: car.voluntary_insurance_start_on
        fill_in 'car[voluntary_securities_number]', with: car.voluntary_insurance_end_on
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
