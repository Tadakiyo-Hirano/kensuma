# rubocop:disable all
require 'rails_helper'

RSpec.describe 'Documnents', type: :system do
  pending "add some examples (or delete) #{__FILE__}"
  let(:user) { create(:user) }
  let(:user_first_sub) { create(:user, name: '1次下請けユーザー', email: 'first_sub-user@example.com', password: '123456', password_confirmation: '123456', role: 'admin') }
  let(:user_second_sub) { create(:user, name: '2次下請けユーザー', email: 'second_sub-user@example.com', password: '123456', password_confirmation: '123456', role: 'admin') }
  let(:business) { create(:business, user: user) }
  let(:business_first_sub) { create(:business, user: user_first_sub) }
  let(:business_second_sub) { create(:business, user: user_second_sub) }
  let(:order) { create(:order, business: business) }
  let(:request_order) { field_worker.field_workerable }
  let(:request_order_first_sub) { create(:request_order, parent_id: 1, business: business_first_sub, order: order) }
  let(:request_order_second_sub) { create(:request_order, parent_id: 2, business: business_second_sub, order: order) }
  let(:worker) { create(:worker, business: business) }
  let(:worker_first_sub) { create(:worker, name: '1次下請けワーカ', business: business_first_sub) }
  let(:worker_second_sub) { create(:worker, name: '2次下請けワーカ', business: business_second_sub) }
  let(:field_worker) { create(:request_order_field_worker) }
  let(:document) { create(:document, business: business, request_order: request_order) }
  let(:cover) { create(:document, :cover, business: business, request_order: request_order) }
  let(:table) { create(:document, :table, business: business, request_order: request_order) }
  let(:doc_3rd) { create(:document, :doc_3rd, business: business, request_order: request_order) }
  let(:doc_8th) { create(:document, :doc_8th, business: business, request_order: request_order) }
  let(:doc_19th) { create(:document, :doc_19th, business: business, request_order: request_order) }
  let(:doc_21st) { create(:document, :doc_21st, business: business, request_order: request_order) }

  describe '書類関連' do
    before(:each) do
      # ステージングにて一時的にメール認証スキップ中の為下記コメント
      # user.skip_confirmation!
      user.save!
      user_first_sub.save!
      user_second_sub.save!
      business.save!
      business_first_sub.save!
      business_second_sub.save!
      field_worker.save!
      request_order.save!
      request_order.update!(business_id: business.id, order_id: order.id)
      request_order_first_sub.save!
      request_order_second_sub.save!
      worker.save!
      worker_first_sub.save!
      worker_second_sub.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'

      document_pages = 24 # 書類の種類の数
      document_pages.times do |page|
        create(:document, request_order: request_order, business: business, document_type: page + 1)
      end
    end

    # it 'ログイン後発注一覧画面へ遷移できること' do
    #   visit users_request_order_documents_path(request_order)
    #   expect(page).to have_content '書類一覧'
    # end

    # context '表紙' do
    #   subject { cover }

    #   it '表紙の詳細画面へ遷移できること' do
    #     visit users_request_order_document_path(request_order, subject)
    #   end
    # end

    # context '目次' do
    #   subject { table }

    #   it '目次の詳細画面へ遷移できること' do
    #     visit users_request_order_document_path(request_order, subject)
    #     expect(page).to have_content '目次'
    #   end
    # end

    # context '施工体制台帳作成建設工事の通知' do
    #   subject { doc_3rd }

    #   it '施工体制台帳作成建設工事の通知の詳細画面へ遷移できること' do
    #     visit users_request_order_document_path(request_order, subject)
    #     expect(page).to have_content '全建統⼀様式第２号(施⼯体制台帳作成建設⼯事の通知)'
    #   end
    # end

    # context '作業員名簿' do
    #   subject { doc_8th }

    #   it '作業員名簿の詳細画面へ遷移できること' do
    #     visit users_request_order_document_path(request_order, subject)
    #     expect(page).to have_content '全建統⼀様式第５号改(作業員名簿)'
    #   end
    # end

    describe '工事安全衛生計画書' do
      subject { doc_19th }

      context '正常系' do
        it '工事安全衛生計画書の詳細画面へ遷移できること' do
          visit users_request_order_document_path(request_order, subject)
          expect(page).to have_content '工事安全衛生計画書'
          # expect(page).to have_content order.confirm_name
          expect(page).to have_content order.site_name
          expect(page).to have_content business.name
          expect(page).to have_content order.site_agent_name
        end

        it '工事安全衛生計画書の編集画面へ遷移できること' do
          visit users_request_order_document_path(request_order, subject)
          click_link '編集'
          expect(page).to have_content '編集中'
        end

        it '正しく入力した際はshow画面に反映されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          fill_in 'document_content[date_created]', with: '令和5年1月7日'
          fill_in 'document_content[safety_and_health_construction_policy]', with: '当社及び作業所の安全衛生ルールを遵守。'
          fill_in 'document_content[safety_and_health_construction_objective]', with: '墜落危険作業では安全帯を使用 (使用率 100%) する。'
          select '1', from: 'document_content[construction_type_period_month_1st]'
          check 'document_content[construction_type_period_week_one_1st]'
          fill_in 'document_content[construction_type_1st]', with: '足場組立て工事'
          fill_in 'document_content[construction_type_1st_period_1st]', with: '24/1/5 ↔︎ 24/1/19'
          fill_in 'document_content[daily_safety_and_health_activity]', with: '安全ミーティング'
          fill_in 'document_content[main_machine_equipment]', with: '積載型移動式クレーン'
          fill_in 'document_content[main_tool]', with: 'ハンマ'
          fill_in 'document_content[main_material]', with: '枠組み足場材'
          fill_in 'document_content[protective_equipment]', with: '保護帽'
          fill_in 'document_content[qualified_staff]', with: '移動式クレーン運転免許者'
          fill_in 'document_content[work_classification_1st]', with: '移動式クレーンの設置'
          fill_in 'document_content[predicted_disaster_1st]', with: 'クレーンの設置場所の地盤状態が悪く、クレーンが転倒する。'
          choose 'document_content[risk_possibility_1st]_low'
          choose 'document_content[risk_seriousness_1st]_low'
          fill_in 'document_content[risk_reduction_measures_1st]', with: '設置地盤に凸凹、傾斜等がある場合は、地盤を整地するか角材等により水平にする'
          check 'document_content[carry_on_machine]'
          fill_in 'document_content[use_notification]', with: 'xx使用届'

          click_button '更新する'

          tds = all('tbody tr')[38].all('td')

          expect(page).to have_content '令和5年1月7日'
          expect(page).to have_content '当社及び作業所の安全衛生ルールを遵守。'
          expect(page).to have_content '墜落危険作業では安全帯を使用 (使用率 100%) する。'
          expect(page).to have_content '1月'
          expect(page).to have_content '1週'
          expect(page).to have_content '足場組立て工事'
          expect(page).to have_content '24/1/5 ↔︎ 24/1/19'
          expect(page).to have_content '安全ミーティング'
          expect(page).to have_content '積載型移動式クレーン'
          expect(page).to have_content 'ハンマ'
          expect(page).to have_content '枠組み足場材'
          expect(page).to have_content '保護帽'
          expect(page).to have_content '移動式クレーン運転免許者'
          expect(page).to have_content '移動式クレーンの設置'
          expect(page).to have_content 'クレーンの設置場所の地盤状態が悪く、クレーンが転倒する。'
          expect(page).to have_content 'ほとんどない'
          expect(page).to have_content '軽微'
          expect(page).to have_content '設置地盤に凸凹、傾斜等がある場合は、地盤を整地するか角材等により水平にする'
          expect(page).to have_content 'xx使用届'
          expect(tds[5]).to have_content '2'
          expect(tds[6]).to have_content '1'
        end

        it '下請けが工事安全衛生計画書の画面へ遷移し、表示されること' do
          click_link 'ログアウト'
          fill_in 'user[email]', with: user_first_sub.email
          fill_in 'user[password]', with: user_first_sub.password
          click_button 'ログイン'
          document_pages = 24 # 書類の種類の数
          document_pages.times do |page|
            create(:document, request_order: request_order_first_sub, business: business_first_sub, document_type: page + 1)
          end
          document_uuid = business_first_sub.documents.find_by(document_type: 'doc_19th').uuid

          visit users_request_order_document_path(request_order_first_sub, document_uuid)

          expect(page).to have_content '工事安全衛生計画書'
          # expect(page).to have_content order.confirm_name
          expect(page).to have_content order.site_name
          expect(page).to have_content business_first_sub.name
          expect(page).to have_content order.site_agent_name
          expect(page).to have_content request_order_first_sub.safety_officer_name
          expect(page).to have_content request_order_first_sub.construction_manager_name
          expect(page).to have_content request_order_first_sub.foreman_name
        end
      end

      context '異常系' do
        it '空白の際は空白NGな項目に対してエラーメッセーが表示されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          click_button '更新する'
          expect(page).to have_content '作成日を入力してください'
          expect(page).to have_content '工事安全衛生方針を記入してください'
          expect(page).to have_content '工事安全衛生目標を記入してください'
        end

        it '文字数オーバによるエラーメッセージが表示されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          fill_in 'document_content[safety_and_health_construction_policy]', with: 'a' * 301
          fill_in 'document_content[safety_and_health_construction_objective]', with: 'a' * 301
          fill_in 'document_content[construction_type_1st]', with: 'a' * 21
          fill_in 'document_content[daily_safety_and_health_activity]', with: 'a' * 301
          fill_in 'document_content[main_machine_equipment]', with: 'a' * 51
          fill_in 'document_content[main_tool]', with: 'a' * 51
          fill_in 'document_content[main_material]', with: 'a' * 51
          fill_in 'document_content[protective_equipment]', with: 'a' * 51
          fill_in 'document_content[qualified_staff]', with: 'a' * 51
          fill_in 'document_content[work_classification_1st]', with: 'a' * 51
          fill_in 'document_content[predicted_disaster_1st]', with: 'a' * 51
          fill_in 'document_content[risk_reduction_measures_1st]', with: 'a' * 201
          fill_in 'document_content[subcontractor_construction_workers_position_1st]', with: 'a' * 21

          click_button '更新する'

          expect(page).to have_content '工事安全衛生方針を300字以内にしてください'
          expect(page).to have_content '工事安全衛生目標を300字以内にしてください'
          expect(page).to have_content '1つ目の工種を20文字以内にしてください'
          expect(page).to have_content '日常の安全衛生活動を300字以内にしてください'
          expect(page).to have_content '主な使用機械設備を50字以内にしてください'
          expect(page).to have_content '主な使用機器・工具を50字以内にしてください'
          expect(page).to have_content '主な使用資材枠を50字以内にしてください'
          expect(page).to have_content '使用保護具を50字以内にしてください'
          expect(page).to have_content '有資格者・配置予定者を50字以内にしてください'
          expect(page).to have_content '1つ目の作業区分を50字以内にしてください'
          expect(page).to have_content '1つ目の予測される災害を50字以内にしてください'
          expect(page).to have_content '1つ目のリスク低減措置を200字以内にしてください'
          expect(page).to have_content '1つ目の職名を20字以内にしてください'
        end

        it '組み合わせによる記載漏れのエラー表示(元請け)' do
          visit edit_users_request_order_document_path(request_order, subject)
          select '1', from: 'document_content[construction_type_period_month_1st]'
          fill_in 'document_content[construction_type_1st]', with: '足場組立て工事'
          fill_in 'document_content[work_classification_1st]', with: '移動式クレーンの設置'
          check 'document_content[carry_on_machine]'

          click_button '更新する'
          expect(page).to have_content '1列目の工種別工事期間の月が入力されているので週のどれかを選択してください'
          expect(page).to have_content '1行目の工種が入力されているので工種期間を入力してください'
          expect(page).to have_content '1列目の月(週)が入力されているので2行目以降の期間を入力してください'
          expect(page).to have_content '1行目の作業が入力されていますが、1行目の他項目で入力漏れがあります。'
          expect(page).to have_content '1行4列目の使用届の名前を入力してください'

          check 'document_content[construction_type_period_week_one_1st]'
          fill_in 'document_content[construction_type_1st_period_1st]', with: '24/1/5 ↔︎ 24/1/19'
          fill_in 'document_content[predicted_disaster_1st]', with: 'クレーンの設置場所の地盤状態が悪く、クレーンが転倒する。'
          fill_in 'document_content[use_notification]', with: 'xx使用届'

          click_button '更新する'
          expect(page).to have_content '1列目の工種別工事期間の週が入力されているので月を入力してください'
          expect(page).to have_content '1行目の工種期間が入力されているので工種を入力してください'
          expect(page).to have_content '1行目の作業を入力していください。'
          expect(page).to have_content '1行4列目の使用届のチェックをしてください'
        end

        it '組み合わせによる記載漏れのエラー表示(下請け)' do
          click_link 'ログアウト'
          fill_in 'user[email]', with: user_first_sub.email
          fill_in 'user[password]', with: user_first_sub.password
          click_button 'ログイン'
          document_pages = 24 # 書類の種類の数
          document_pages.times do |page|
            create(:document, request_order: request_order_first_sub, business: business_first_sub, document_type: page + 1)
          end
          document_uuid = business_first_sub.documents.find_by(document_type: 'doc_19th').uuid

          visit edit_users_request_order_document_path(request_order_first_sub, document_uuid)

          select worker_second_sub.name, from: 'document_content[subcontractor_construction_workers_name_1st]'

          click_button '更新する'
          expect(page).to have_content '1行目の職名を入力してください。'

          fill_in 'document_content[subcontractor_construction_workers_position_1st]', with: '職長兼オペレーター'
          click_button '更新する'

          expect(page).to have_content '1行目の氏名を入力してください。'
        end
      end
    end

    xdescribe '新規入場時等教育実施報告書' do # 受講者氏名（student_name）（※必須）がエラーとなる為pending
      subject { doc_21st }

      context '正常系' do
        it '新規入場時等教育実施報告書の詳細画面へ遷移できること' do
          visit users_request_order_document_path(request_order, subject)
          expect(page).to have_content '新規入場時等教育実施報告書'
          expect(page).to have_content order.site_name
          expect(page).to have_content order.site_agent_name
          expect(page).to have_content business.name
          expect(page).to have_content order.site_agent_name
        end

        it '新規入場時等教育実施報告書の編集画面へ遷移できること' do
          visit users_request_order_document_path(request_order, subject)
          click_link '編集'
          expect(page).to have_content 'チェックを入れてください'
        end

        it '正しく入力した際はshow画面に反映されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          expect(page).to have_content 'チェックを入れてください'
          fill_in 'document_content[prime_contractor_confirmation]', with: 'AA'
          fill_in 'document_content[date_submitted]', with: '2023年2月1日'
          check 'document_content[newly_entrance]'
          fill_in 'document_content[date_implemented]', with: '令和5年1月10日'
          select '09', from: 'document[content[start_time](4i)]'
          select '11', from: 'document[content[end_time](4i)]'
          fill_in 'document_content[implementation_time]', with: '2'
          fill_in 'document_content[location]', with: '作業所会議室'
          fill_in 'document_content[education_method]', with: '講義、スライド'
          fill_in 'document_content[education_content]', with: '作用所の規則と概要について'
          fill_in 'document_content[teachers_company]', with: '株式会社　山田工務店'
          fill_in 'document_content[teacher_name]', with: '加藤　安全衛生推進者'
          # select 'admission_worker_name1', from: 'document[content[student_name]][]' # 一旦保留
          # fill_in 'document[content[student_name]][]', with: 'admission_worker_name1'
          # select 'admission_worker_name1', from: 'document_content[student_name]'
          # find("#document_content[student_name]").find("option[value='admission_worker_name1']").select_option
          # find("option[value='admission_worker_name1']").select_option
          # select 'admission_worker_nam1', from: 'select2-data-document_content[student_name]'
          # first('.select2-container', minimum: 1).click
          # find('li.select2-results__option[role="treeitem"]', text: 'admission_worker_nam1').click
          fill_in 'document_content[material]', with: '新規入場者の安全の手引き'

          click_button '更新'

          expect(page).to have_content 'AA'
          expect(page).to have_content '2023年2月1日'
          expect(page).to have_selector '.circle', text: '新規入場時'
          expect(page).to have_content '令和5年1月10日'
          expect(page).to have_content '9時'
          expect(page).to have_content '11時'
          expect(page).to have_content '2'
          expect(page).to have_content '作業所会議室'
          expect(page).to have_content '講義、スライド'
          expect(page).to have_content '作用所の規則と概要について'
          expect(page).to have_content '株式会社　山田工務店'
          expect(page).to have_content '加藤　安全衛生推進者'
          # expect(page).to have_content 'admission_worker_name1' # 一旦保留
          expect(page).to have_content '新規入場者の安全の手引き'
        end
      end

      context '異常系' do
        it '必須項目に対してエラーメッセーが表示されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          click_button '更新'
          expect(page).to have_content '確認者を入力してください'
          expect(page).to have_content '提出日を入力してください'
          expect(page).to have_content 'どれか一つをチェックしてください'
          expect(page).to have_content '実施日付を入力してください'
          expect(page).to have_content '始時間を入力してください'
          expect(page).to have_content '終時間を入力してください'
          expect(page).to have_content '時間を入力してください'
          expect(page).to have_content '実施場所を入力してください'
          expect(page).to have_content '教育方法を入力してください'
          expect(page).to have_content '教育内容を入力してください'
          expect(page).to have_content '講師の会社名を入力してください'
          expect(page).to have_content '講師名を入力してください'
          # expect(page).to have_content '受講者氏名を入力してください' # 一旦保留
          expect(page).to have_content '資料を入力してください'
        end

        it '文字数オーバによるエラーメッセージが表示されること' do
          visit edit_users_request_order_document_path(request_order, subject)
          fill_in 'document_content[location]', with: 'a' * 51
          fill_in 'document_content[education_method]', with: 'a' * 51
          fill_in 'document_content[education_content]', with: 'a' * 501
          fill_in 'document_content[material]', with: 'a' * 101

          click_button '更新'

          expect(page).to have_content '実施場所を50字以内にしてください'
          expect(page).to have_content '教育方法を50字以内にしてください'
          expect(page).to have_content '教育内容を500字以内にしてください'
          expect(page).to have_content '資料を100字以内にしてください'
        end
      end
    end
  end
end
# rubocop:enable all
