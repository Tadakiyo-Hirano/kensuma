require 'rails_helper'

RSpec.describe 'News', type: :system do
  let!(:admin) { create(:admin, email: 'foo@example.com', password: '123456', password_confirmation: '123456') }
  let!(:user) { create(:user, email: 'userx@example.com', password: '123456', password_confirmation: '123456') }
  let!(:business) { create(:business, user: user) } # userのbusinessが無いとログイン後にダッシュボードに遷移できないので追加
  let!(:news_a) { create(:news, title: 'お知らせ-A', content: 'これはお知らせ-Aの内容です', status: 'draft', delivered_at: DateTime.now.yesterday, uuid: SecureRandom.uuid) }
  let!(:news_b) { create(:news, title: 'お知らせ-B', content: 'これはお知らせ-Bの内容です', status: 'published', delivered_at: DateTime.now.yesterday, uuid: SecureRandom.uuid) }

  before(:each) do
    # ステージングにて一時的にメール認証スキップ中の為下記コメント
    # user.skip_confirmation! # ユーザー作成時のメールによる認証をスキップできる
    user.save!
  end

  describe 'active_admin/newsに遷移した場合' do
    before(:each) do
      sign_in(admin)
      visit _system__dashboard_path
      visit _system__news_index_path
      visit edit__system__news_path(news_a)
    end

    context 'お知らせ編集ページを表示(正常系)' do
      it 'お知らせ編集ページで各項目を入力(正常系)' do
        fill_in 'news[title]', with: 'お知らせ-Aの編集' # 内容を書き換える
        fill_in 'news[content]', with: 'お知らせ-Aの内容の編集です' # 内容を書き換える
        fill_in 'news[delivered_at]', with: '2022-01-01 09:00' # 内容を書き換える
        select 'Published', from: 'news[status]' # 全ての項目が入力された状態で「Published」を選択する
        click_button 'お知らせを更新'
        expect(page).to have_content('お知らせ')
      end
    end

    context 'お知らせ編集ページを表示(異常系)' do
      it 'お知らせ編集ページで各項目を入力(異常系)' do
        fill_in 'news[title]', with: nil # 「タイトル」にnilを入力
        fill_in 'news[content]', with: 'お知らせ-Aの内容の編集です'
        fill_in 'news[delivered_at]', with: '2022-01-01 09:00' # 内容を書き換える
        select 'Published', from: 'news[status]' # 「タイトル」がnilのまま「Published」を選択
        click_button 'お知らせを更新'
        # 入力項目に空が一つでもあると、「Published」では更新できない
        expect(page).not_to have_content('お知らせ の詳細')
      end
    end
  end

  describe 'users/newsに遷移した場合' do
    before(:each) do
      visit root_url
      sign_in(user)
      # あらかじめbusinessを作成しているため、ダッシュボードに遷移できる
      visit users_dash_boards_path
      visit users_news_index_path
    end

    context 'お知らせ一覧ページに遷移した場合' do
      it 'お知らせ一覧ページを表示' do
        expect(page).to have_content('お知らせ一覧')
      end
    end

    describe 'お知らせ詳細ページに遷移した場合' do
      before(:each) do
        visit users_news_path(news_b)
      end

      context 'お知らせ詳細ページを表示' do
        it 'お知らせ詳細ページにタイトルが含まれること' do
          expect(page).to have_content(news_b.title)
        end
      end
    end
  end
end
