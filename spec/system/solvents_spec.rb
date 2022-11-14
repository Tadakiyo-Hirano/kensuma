require 'rails_helper'

RSpec.describe 'Solvents', type: :system do
  pending "add some examples (or delete) #{__FILE__}"
  # let(:user) { create(:user) }
  # let(:business) { create(:business, user: user) }
  # # let(:solvent) { create(:solvent, business: business) }
  # let(:solvent_a) { create(:solvent, name: 'TESTシンナー', maker: 'TESTペイント', classification: 'シンナー', ingredients: 'トルエン・キシレン', business: business) }

  # describe '有機溶剤関連' do
  #   before(:each) do
  #     # ステージングにて一時的にメール認証スキップ中の為下記コメント
  #     # user.skip_confirmation!
  #     user.save!
  #     business.save!
  #     visit new_user_session_path
  #     fill_in 'user[email]', with: user.email
  #     fill_in 'user[password]', with: user.password
  #     click_button 'ログイン'
  #   end

  #   it 'ログイン後有機溶剤情報一覧画面へ遷移できること' do
  #     visit users_solvents_path
  #     expect(page).to have_content '有機溶剤情報一覧'
  #   end

  #   context '有機溶剤情報登録(正常系)' do
  #     it '新規登録したあと詳細画面へ遷移すること(正常系)' do
  #       visit new_users_solvent_path

  #       fill_in 'solvent[name]', with: 'TESTシンナー' # 商品名
  #       fill_in 'solvent[maker]', with: solvent_a.maker # メーカー名
  #       fill_in 'solvent[classification]', with: solvent_a.classification # 種別
  #       fill_in 'solvent[ingredients]', with: solvent_a.ingredients # 含有成分

  #       click_button '登録'

  #       visit users_solvent_path(solvent_a)
  #       expect(page).to have_content '有機溶剤情報詳細'
  #       expect(page).to have_content 'TESTシンナー'
  #     end
  #   end

  #   context '有機溶剤情報登録(異常系)' do
  #     it '新規登録したあと詳細画面へ遷移すること(異常系)' do
  #       visit new_users_solvent_path

  #       fill_in 'solvent[name]', with: '' # 商品名
  #       fill_in 'solvent[maker]', with: solvent_a.maker # メーカー名
  #       fill_in 'solvent[classification]', with: solvent_a.classification # 種別
  #       fill_in 'solvent[ingredients]', with: solvent_a.ingredients # 含有成分

  #       click_button '登録'

  #       expect(page).to have_content '有機溶剤情報登録'
  #       expect(page).to have_content '商品名を入力してください'
  #     end
  #   end

  #   context '有機溶剤情報編集' do
  #     it '更新したあと詳細画面へ遷移すること' do
  #       visit edit_users_solvent_path(solvent_a)

  #       fill_in 'solvent[name]', with: 'TESTシンナー_2' # 商品名
  #       click_button '更新'

  #       visit users_solvent_path(solvent_a)
  #       expect(page).to have_content '有機溶剤情報詳細'
  #       expect(page).to have_content 'TESTシンナー_2'
  #     end
  #   end

  #   context '有機溶剤情報編集(異常系)' do
  #     it '更新したあと詳細画面へ遷移すること(異常系)' do
  #       visit edit_users_solvent_path(solvent_a)

  #       fill_in 'solvent[name]', with: '' # 商品名
  #       click_button '更新'

  #       expect(page).to have_content '有機溶剤情報編集'
  #       expect(page).to have_content '商品名を入力してください'
  #     end
  #   end

  #   context '有機溶剤情報削除' do
  #     it '削除したあと一覧画面に遷移すること', js: true do
  #       visit users_solvent_path(solvent_a)
  #       click_on '削除'

  #       expect {
  #         expect(page.accept_confirm).to eq "#{solvent_a.name}の有機溶剤情報を削除します。本当によろしいですか？"
  #         expect(page).to have_content "#{solvent_a.name}を削除しました"
  #       }.to change(Solvent, :count).by(-1)

  #       visit users_solvents_path
  #       expect(page).to have_content '有機溶剤情報一覧'
  #     end
  #   end
  # end
end
