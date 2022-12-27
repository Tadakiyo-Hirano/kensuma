require 'rails_helper'

RSpec.describe '管理者', type: :system do
  # テストユーザーを作成する
  let!(:admin) { create(:admin, email: 'foo@example.com', password: '123456', password_confirmation: '123456') }

  describe 'active_admin/devise/sessions' do
    context '管理者ログインページへアクセスした場合' do
      it 'ログイン画面を表示' do
        visit new_admin_session_path
        expect(page).to have_content('ログイン')
      end
    end

    context 'メールアドレスとパスワードが登録済み情報と合致する場合' do
      it 'ログインしダッシュボードを表示' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_button 'ログイン'
        # ログイン後遷移先変更時に修正の必要あり
        expect(page).to have_current_path _system__dashboard_path, ignore_query: true
        expect(page).to have_content('ログインしました。')
      end
    end

    context 'メールアドレスとパスワードが登録済み情報と合致しない場合' do
      it 'ログインできない' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'bar@example.com'
        fill_in 'admin[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end

    context 'メールアドレスとパスワードが未入力の場合' do
      it 'ログインできない' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end

    context 'ログアウトをクリックした場合' do
      it 'ログアウトしログイン画面を表示' do
        sign_in(admin)
        visit _system__dashboard_path
        click_link 'ログアウト'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('ログイン')
      end
    end
  end

  describe '管理者ログイン後' do
    before(:each) do
      sign_in(admin)
      visit _system__dashboard_path
    end

    describe 'ヘッダーからの画面遷移' do
      context 'ダッシュボードをクリックした場合' do
        it 'ダッシュボードを表示' do
          click_link 'ダッシュボード'
          expect(page).to have_current_path _system__dashboard_path, ignore_query: true
          expect(page).to have_content('ダッシュボード')
        end
      end

      context '管理者をクリックした場合' do
        it '管理者一覧を表示' do
          click_link '管理者'
          expect(page).to have_current_path _system__admins_path, ignore_query: true
          expect(page).to have_content('管理者')
        end
      end

      context 'コメントをクリックした場合' do
        it 'コメント一覧を表示' do
          click_link 'コメント'
          expect(page).to have_current_path _system__comments_path, ignore_query: true
          expect(page).to have_content('コメント')
        end
      end

      context 'ユーザーをクリックした場合' do
        it 'ユーザー一覧を表示' do
          click_link 'ユーザー'
          expect(page).to have_current_path _system__users_path, ignore_query: true
          expect(page).to have_content('ユーザー')
        end
      end
    end

    describe '管理者一覧ページからの遷移' do
      before(:each) { visit _system__admins_path }

      context '閲覧をクリックした場合' do
        it '管理者詳細ページを表示' do
          click_link '閲覧'
          expect(page).to have_current_path _system__admin_path(admin), ignore_query: true
          expect(page).to have_content('管理者 の詳細')
        end
      end

      context '編集をクリックした場合' do
        it '管理者編集ページを表示' do
          click_link '編集'
          expect(page).to have_current_path edit__system__admin_path(admin), ignore_query: true
          expect(page).to have_content('管理者 を編集する')
        end
      end
    end

    describe '管理者詳細ページからの遷移' do
      before(:each) { visit _system__admin_path(admin) }

      context '管理者を編集するをクリックした場合' do
        it '管理者編集ページを表示' do
          click_link '管理者 を編集する'
          expect(page).to have_current_path edit__system__admin_path(admin), ignore_query: true
          expect(page).to have_content('管理者 を編集する')
        end
      end
    end

    describe 'ユーザー一覧ページからの遷移' do
      let!(:user) { create(:user) }

      before(:each) { visit _system__users_path }

      context 'ユーザーを作成するをクリックした場合' do
        it 'ユーザー登録ページを表示' do
          click_link 'ユーザー を作成する'
          expect(page).to have_current_path new__system__user_path, ignore_query: true
          expect(page).to have_content('ユーザー を作成する')
        end
      end

      context '閲覧をクリックした場合' do
        it 'ユーザー詳細ページを表示' do
          click_link '閲覧'
          expect(page).to have_current_path _system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー の詳細')
        end
      end

      context '編集をクリックした場合' do
        it 'ユーザー編集ページを表示' do
          click_link '編集'
          expect(page).to have_current_path edit__system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー を編集する')
        end
      end

      context '削除をクリックした場合', js: true do
        it '削除アラートからユーザーが削除できる' do
          click_link '削除'
          expect {
            page.accept_confirm
            expect(page).to have_content 'ユーザー を作成する' # この１行なければエラー出る。Ajaxの処理完了までのクッション的役割として一つ以上のfindやexpectが必要。本当は削除後のアラートが望ましいが現在は未実装
          }.to change(User, :count).by(-1)
        end
      end
      # 又はexpect以降は下記でもOK。ただ、書き方が古いらしい。
      #   expect {
      #     expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
      #     page.driver.browser.switch_to.alert.accept
      #     expect(page).to have_content 'ユーザー を作成する'
      #   }.to change{ User.count }.by(-1)
    end

    describe 'ユーザー詳細ページからの遷移' do
      let!(:user) { create(:user) }

      before(:each) { visit _system__user_path(user) }

      context 'ユーザーを編集するをクリックした場合' do
        it 'ユーザー編集ページを表示' do
          click_link 'ユーザー を編集する'
          expect(page).to have_current_path edit__system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー を編集する')
        end
      end

      context 'ユーザーを削除するをクリックした場合', js: true do
        it '削除アラートからユーザーが削除できる' do
          click_link 'ユーザー を削除する'
          expect {
            page.accept_confirm
            expect(page).to have_content 'ユーザー を作成する' # この１行なければエラー出る。Ajaxの処理完了までのクッション的役割として一つ以上のfindやexpectが必要。本当は削除後のアラートが望ましいが現在は未実装
          }.to change(User, :count).by(-1)
        end
      end
      # 又はexpect以降は下記でもOK。ただ、書き方が古いらしい。
      #   expect {
      #     expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
      #     page.driver.browser.switch_to.alert.accept
      #     expect(page).to have_content 'ユーザー を作成する'
      #   }.to change{ User.count }.by(-1)
    end
  end
end
