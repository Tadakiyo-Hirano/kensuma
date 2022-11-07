require 'rails_helper'

RSpec.describe 'Businesses', type: :system do
  pending "add some examples (or delete) #{__FILE__}"
  # let(:user) { create(:user) }

  # let(:business) { create(:business) }

  # describe '会社情報関連' do
  #   before(:each) do
  #     # ステージングにて一時的にメール認証スキップ中の為下記コメント
  #     # user.skip_confirmation!
  #     user.save!
  #     visit new_user_session_path
  #     fill_in 'user[email]', with: user.email
  #     fill_in 'user[password]', with: user.password
  #     click_button 'ログイン'
  #   end

  #   context '画面への推移が正常' do
  #     it '会社情報新規作成' do
  #       # 会社情報新規登録画面へ遷移
  #       visit new_users_business_path
  #       # new_users_businesses_pathへ遷移することを期待する
  #       expect(page).to have_current_path new_users_business_path, ignore_query: true
  #       # 遷移されたページに'会社情報登録'の文字列があることを期待する
  #       expect(page).to have_content '会社情報登録'
  #     end
  #   end
  # end
end
