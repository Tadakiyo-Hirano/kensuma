require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:order) { create(:order, business: business) }

  describe '現場情報関連' do
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

    it 'ログイン後現場情報一覧画面へ遷移できること' do
      visit users_orders_path
      expect(page).to have_content '現場情報一覧'
    end

    context '現場情報登録' do
      it '新規登録したあと詳細画面へ遷移すること' do
        visit new_users_order_path

        fill_in 'order[site_name]', with: order.site_name
        fill_in 'order[order_name]', with: order.order_name
        fill_in 'order[order_post_code]', with: order.order_post_code
        fill_in 'order[order_address]', with: order.order_address
        click_button '登録'

        visit users_order_path(order)
        expect(page).to have_content '現場情報詳細'
        expect(page).to have_content order.site_uu_id
      end
    end

    context '現場情報編集' do
      it '更新したあと詳細画面へ遷移すること' do
        visit edit_users_order_path(order)

        fill_in 'order[site_name]', with: 'edit site_name'
        click_button '更新'

        visit users_order_path(order)
        expect(page).to have_content '現場情報詳細'
        expect(page).to have_content 'edit site_name'
      end
    end

    context '現場情報削除' do
      it '削除したあと一覧画面に遷移すること', js: true do
        visit users_order_path(order)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq "#{order.site_uu_id}を削除します。本当によろしいですか？"
          expect(page).to have_content "#{order.site_uu_id}を削除しました"
        }.to change(Order, :count).by(-1)

        visit users_orders_path
        expect(page).to have_content '現場情報一覧'
      end
    end
  end
end
