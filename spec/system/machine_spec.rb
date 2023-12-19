require 'rails_helper'
# pending
RSpec.xdescribe 'Machines', type: :system do # 「describe」を「xdescribe」とすることでテスト全体をpending
  pending "add some examples (or delete) #{__FILE__}"
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:machine) do
    create(:machine, name: '電動ドリル', standards_performance: 'sample_standards_performance',
    control_number: 'sample_control_number', inspector: 'sample_inspector', handler: 'sample_handler',
    business: business, extra_inspection_item1: 'test', extra_inspection_item2: 'test')
  end

  describe '機械関連' do
    before(:each) do
      # ユーザーメール認証スキップのためコメントアウト
      # user.skip_confirmation!
      user.save!
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後持込機械情報一覧へ画面遷移できること' do
      visit users_machines_path
      expect(page).to have_content '持込機械情報一覧'
    end

    context '持込機械情報登録' do
      it '新規登録した後に詳細画面へ遷移できること' do
        visit new_users_machine_path

        select '電動カンナ', from: 'machine[name]'
        fill_in 'machine[standards_performance]', with: machine.standards_performance
        fill_in 'machine[control_number]', with: machine.control_number
        select 'サンプル取扱者', from: 'machine[handler]'
        select 'サンプル管理者', from: 'machine[inspector]'
        fill_in 'machine[extra_inspection_item1]', with: machine.extra_inspection_item1
        fill_in 'machine[extra_inspection_item2]', with: machine.extra_inspection_item2

        click_button '登録'
        expect(page).to have_content '持込機械情報を登録しました'
      end
    end

    context '持込機械情報の重複確認１' do
      it '新規登録時の重複内容が削除されていること' do
        visit edit_users_machine_path(machine)

        expect(Machine.last.extra_inspection_item2).not_to eq ''
      end
    end

    context '持込機械情報編集' do
      it '持込機械情報が編集できること' do
        visit edit_users_machine_path(machine)

        select '電動ドリル', from: 'machine[name]'
        fill_in 'machine[extra_inspection_item2]', with: 'test'

        click_button '更新'
        expect(page).to have_content '更新しました'
      end
    end

    context '持込機械情報の重複確認２' do
      it '更新時の重複内容が削除されていること' do
        visit edit_users_machine_path(machine)

        expect(Machine.last.extra_inspection_item2).not_to eq ''
      end
    end

    context '持込機械情報削除' do
      it '持込機械情報を削除できること', js: true do
        visit users_machine_path(machine)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq "#{machine.name}の持込機械情報を削除します。本当によろしいですか？"
          expect(page).to have_content "#{machine.name}を削除しました"
        }.to change(Machine, :count).by(-1)

        visit users_machines_path
        expect(page).to have_content '持込機械情報一覧'
      end
    end
  end
end
