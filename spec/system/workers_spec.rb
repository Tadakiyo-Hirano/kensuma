require 'rails_helper'

RSpec.describe 'Workers', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:worker) { create(:worker, business: business) }

  before(:each) do
    user.skip_confirmation!
    user.save!
    business.save!
    sign_in(user)
    visit users_dash_boards_path
  end

  describe '作業員のCRUDテスト' do
    describe '一覧機能' do
      it '作業員一覧ページに遷移' do
        click_on '作業員'
        expect(page).to have_current_path users_workers_path, ignore_query: true
        expect(page).to have_content('作業員一覧')
      end
    end

    describe '新規登録機能' do
      it '作業員登録画面へ遷移する' do
        visit users_workers_path
        click_on '作業員新規作成画面へ'
        expect(page).to have_current_path new_users_worker_path, ignore_query: true
        expect(page).to have_content('作業員登録')
      end

      context '入力内容が正しい場合' do
        it '登録ができ、詳細画面が表示される' do
          visit new_users_worker_path
          fill_in 'worker[name]', with: 'TestWorker'
          fill_in 'worker[name_kana]', with: 'テストワーカー'
          fill_in 'worker[country]', with: '日本'
          fill_in 'worker[my_address]', with: '東京都'
          fill_in 'worker[my_phone_number]', with: '09012345678'
          fill_in 'worker[family_address]', with: '東京都'
          fill_in 'worker[family_phone_number]', with: '08087654321'
          fill_in 'worker[birth_day_on]', with: '2022-01-28'
          select 'A型', from: 'worker[abo_blood_type]'
          select '−', from: 'worker[rh_blood_type]'
          fill_in 'worker[job_type]', with: 1
          fill_in 'worker[hiring_on]', with: '2022-01-28'
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_button '登録'
          expect(page).to have_content '作業員を作成しました'
          expect(page).to have_content '作業員詳細'
          expect(page).to have_content 'TestWorker'
        end
      end

      context '入力内容が正しくない場合' do
        it '登録できず、登録画面が表示される' do
          visit new_users_worker_path
          fill_in 'worker[name]', with: ''
          fill_in 'worker[name_kana]', with: ''
          fill_in 'worker[country]', with: ''
          fill_in 'worker[my_address]', with: ''
          fill_in 'worker[my_phone_number]', with: ''
          fill_in 'worker[family_address]', with: ''
          fill_in 'worker[family_phone_number]', with: ''
          fill_in 'worker[birth_day_on]', with: ''
          select 'A型', from: 'worker[abo_blood_type]'
          select '−', from: 'worker[rh_blood_type]'
          fill_in 'worker[job_type]', with: 1
          fill_in 'worker[hiring_on]', with: '2022-01-28'
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_button '登録'
          expect(page).to have_content '入力エラー'
          expect(page).to have_content '作業員登録'
          expect(page).to have_no_content '作業員詳細'
        end
      end
    end

    describe '編集機能' do
      context '入力内容が正しい場合' do
        it '編集でき、詳細画面が表示される' do
          visit edit_users_worker_path(worker)
          fill_in 'worker[name]', with: '編集後ワーカー'
          click_button '更新'
          expect(page).to have_current_path users_worker_path(worker), ignore_query: true
          expect(page).to have_content '作業員詳細'
          expect(page).to have_content '編集後ワーカー'
        end
      end

      context '入力内容が正しくない場合' do
        it '編集できず、編集画面が表示される' do
          visit edit_users_worker_path(worker)
          fill_in 'worker[name]', with: ''
          click_button '更新'
          expect(page).to have_content '入力エラー'
          expect(page).to have_content '作業員情報編集'
          expect(page).to have_no_content '作業員詳細'
        end
      end
    end

    describe '削除機能' do
      it '削除ができ、一覧画面が表示される', js: true do
        visit users_worker_path(worker)
        click_on '削除'
        expect {
          expect(page.accept_confirm).to eq "#{worker.name}を削除します。本当によろしいですか？"
          expect(page).to have_content "#{worker.name}を削除しました"
        }.to change(Worker, :count).by(-1)
        expect(page).to have_current_path users_workers_path, ignore_query: true
        expect(page).to have_content '作業員一覧'
      end
    end
  end
end
