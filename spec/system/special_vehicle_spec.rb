require 'rails_helper'

RSpec.describe 'Special_Vehicles', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:special_vehicle) { create(:special_vehicle, business: business) }

  describe '特殊車両関連' do
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

    it 'ログイン後に特殊車両情報一覧画面へ遷移できること' do
      visit users_special_vehicles_path
      expect(page).to have_content '特殊車両情報一覧'
    end

    context '特殊車両情報登録' do
      it '新規登録したあと詳細画面へ遷移すること' do
        visit new_users_special_vehicle_path

        # 名称
        fill_in 'special_vehicle[name]', with: special_vehicle.name
        # メーカー
        fill_in 'special_vehicle[maker]', with: special_vehicle.maker
        # 規格・性能
        fill_in 'special_vehicle[standards_performance]', with: special_vehicle.standards_performance
        # 製造年
        fill_in 'special_vehicle[year_manufactured]', with: special_vehicle.year_manufactured
        # 管理番号(整理番号)
        fill_in 'special_vehicle[control_number]', with: special_vehicle.control_number
        # 自主検査有効期限(正規・年次)
        fill_in 'special_vehicle[check_exp_date_year]', with: special_vehicle.check_exp_date_year
        # 自主検査有効期限(正規・月次)
        fill_in 'special_vehicle[check_exp_date_month]', with: special_vehicle.check_exp_date_month
        # 自主検査有効期限(特定)
        fill_in 'special_vehicle[check_exp_date_specific]', with: special_vehicle.check_exp_date_specific
        # 移動式クレーン等の性能検査有効期限
        fill_in 'special_vehicle[check_exp_date_machine]', with: special_vehicle.check_exp_date_machine
        # 自動車検査証有効期限
        fill_in 'special_vehicle[check_exp_date_car]', with: special_vehicle.check_exp_date_car

        # ========== 任意保険ここから ==========
        # 任意保険加入額(対人)
        select '1,000', from: 'special_vehicle[personal_insurance]'
        # 任意保険加入額(対物)
        select '2,000', from: 'special_vehicle[objective_insurance]'
        # 任意保険加入額(搭乗者)
        select '3,000', from: 'special_vehicle[passenger_insurance]'
        # 任意保険加入額(その他)
        select '4,000', from: 'special_vehicle[other_insurance]'
        # 任意保険加入有効期限
        fill_in 'special_vehicle[exp_date_insurance]', with: '2022-01-28'
        # ========== 任意保険ここまで ==========

        click_button '登録'

        visit users_special_vehicle_path(special_vehicle)
        expect(page).to have_content '特殊車両情報詳細'
        expect(page).to have_content special_vehicle.name
      end
    end

    context '特殊車両情報編集' do
      it '更新したあと詳細画面へ遷移すること' do
        visit edit_users_special_vehicle_path(special_vehicle)

        fill_in 'special_vehicle[name]', with: '編集後名称'
        click_button '更新'

        visit users_special_vehicle_path(special_vehicle)
        expect(page).to have_content '特殊車両情報詳細'
        expect(page).to have_content '編集後名称'
      end
    end

    context '特殊車両情報削除' do
      it '削除したあと一覧画面に遷移すること', js: true do
        visit users_special_vehicle_path(special_vehicle)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq "#{special_vehicle.name}の特殊車両情報を削除します。本当によろしいですか？"
          expect(page).to have_content "#{special_vehicle.name}を削除しました"
        }.to change(SpecialVehicle, :count).by(-1)

        visit users_special_vehicles_path
        expect(page).to have_content '特殊車両情報一覧'
      end
    end
  end
end
