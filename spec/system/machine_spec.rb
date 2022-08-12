require 'rails_helper'

RSpec.describe 'Machines', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:machine) { create(:machine, name: '電動ドリル', standards_performance: 'sample_standards_performance', control_number: 'sample_control_number', inspector: 'sample_inspector', handler: 'sample_handler', inspection_date: DateTime.now.yesterday, business: business) }

  describe '機械関連' do
    before(:each) do
      user.skip_confirmation!
      user.save!
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後機械情報一覧へ画面遷移できること' do
      visit users_machines_path
      expect(page).to have_content '機械情報一覧'
    end

    context '機械情報登録' do
      it '新規登録した後に詳細画面へ遷移できること' do
        visit new_users_machine_path

        select '電動カンナ', from: 'machine[name]'
        fill_in 'machine[standards_performance]', with: machine.standards_performance
        fill_in 'machine[control_number]', with: machine.control_number
        select 'サンプル取扱者', from: 'machine[handler]'
        select 'サンプル管理者', from: 'machine[inspector]'
        fill_in 'machine[inspection_date]', with: machine.inspection_date

        click_button '登録'
        expect(page).to have_content '機械情報を登録しました'
      end
    end

    context '機械情報編集' do
      it '機械情報が編集できること' do
        visit edit_users_machine_path(machine)

        select '電動ドリル', from: 'machine[name]'

        click_button '更新'
        expect(page).to have_content '更新しました'
      end
    end

    context '機械情報削除' do
      it '機械情報を削除できること', js: true do
        visit users_machine_path(machine)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq "#{machine.name}の機械情報を削除します。本当によろしいですか？"
          expect(page).to have_content "#{machine.name}を削除しました"
        }.to change(Machine, :count).by(-1)

        visit users_machines_path
        expect(page).to have_content '機械情報一覧'
      end
    end
  end
end
