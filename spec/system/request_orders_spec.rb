require 'rails_helper'

RSpec.describe 'RequestOrders', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:order) { create(:order, business: business) }
  let(:request_order) { create(:request_order, business: business, order: order) }

  describe '下請発注情報関連' do
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

    context '下請発注情報' do
      it '下請発注情報一覧画面へ遷移できること' do
        visit users_request_orders_path
        expect(page).to have_content '下請発注情報一覧'
      end

      it '詳細画面へ遷移すること' do
        visit users_request_order_path(request_order)
        expect(page).to have_content '下請発注情報詳細'
        expect(page).to have_content request_order.status_i18n
        expect(page).to have_content request_order.business.name
      end
    end

    context '下請け発注依頼' do
      it '下請け発注依頼登録画面' do
        user = create(:user)
        business = create(:business, user: user, name: 'test')

        visit new_users_request_order_sub_request_order_path(request_order)
        expect(page).to have_content '下請け発注依頼登録'

        select business.name, from: 'business_ids'

        click_button '登録'

        # 登録後、発注依頼詳細画面へ
        expect(page).to have_content '下請発注情報詳細'
      end
    end

    context '下請け発注依頼～発注詳細' do
      before(:each) do
        visit new_users_request_order_sub_request_order_path(request_order)
      end

      it '詳細画面へ遷移すること' do
        expect(page).to have_content '下請け発注依頼登録'
        click_on '戻る'
        expect(page).to have_content '下請発注情報詳細'
        expect(page).to have_content request_order.status_i18n
        expect(page).to have_content request_order.business.name
      end
    end
  end
end
