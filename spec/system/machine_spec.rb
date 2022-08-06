# require 'rails_helper'

# RSpec.describe 'Machines', type: :system do
#   let(:user) { create(:user) }
#   let(:business) { create(:business, user: user) }
#   let(:machine_test) { create(:machine, uuid: SecureRandom.uuid, name: 'test_name', standards_performance: 'sample_standards_performance', control_number: 'sample_control_number', inspector: 'sample_inspector', handler: 'sample_handler', inspection_date: DateTime.now.yesterday) }

#   describe '機械関連' do
#     before(:each) do
#       user.skip_confirmation!
#       user.save!
#       business.save!
#       visit new_user_session_path
#       fill_in 'user[email]', with: user.email
#       fill_in 'user[password]', with: user.password
#       click_button 'ログイン'
#     end

#     it 'ログイン後機械情報一覧へ画面遷移できること' do
#       visit users_machines_path
#       expect(page).to have_content '機械情報一覧'
#     end

#     context '機械情報登録' do
#       it '新規登録した後に詳細画面へ遷移できること' do
#         visit new_users_machine_path

#         select 'electric_drill', from: 'machine[name]'
#         fill_in 'machine[standards_performance]', with: machine_test.standards_performance
#         fill_in 'machine[control_number]', with: machine_test.control_number
#         fill_in 'machine[inspector]', with: machine_test.inspector
#         fill_in 'machine[handler]', with: machine_test.handler
#         fill_in 'machine[inspection_date]', with: machine_test.inspection_date

#         click_button '登録'
#       end
#     end
#   end
# end