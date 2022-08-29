require 'rails_helper'

RSpec.describe 'Workers', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:worker) { create(:worker, business: business) }
  let(:worker_medical) { create(:worker_medical, worker: worker) }

  before(:each) do
    # ステージングにて一時的にメール認証スキップ中の為下記コメント
    # user.skip_confirmation!
    user.save!
    business.save!
    sign_in(user)
    visit users_dash_boards_path
  end

  describe '作業員情報のCRUDテスト' do
    before(:each) do
      worker.save!
      worker_medical.save!
    end

    describe '一覧機能' do
      it '作業員情報一覧ページに遷移' do
        click_on '作業員'
        expect(page).to have_current_path users_workers_path, ignore_query: true
        expect(page).to have_content('作業員情報一覧')
      end
    end

    describe '新規登録機能' do
      it '作業員情報登録画面へ遷移する' do
        visit users_workers_path
        click_on '作業員情報新規作成画面へ'
        expect(page).to have_current_path new_users_worker_path, ignore_query: true
        expect(page).to have_content('作業員情報登録')
      end

      context '入力内容が正しい場合' do
        it '登録ができ、詳細画面が表示される' do
          License.create!(name: 'サンプルライセンス', license_type: 0)
          SkillTraining.create!(name: 'サンプル技能講習', short_name: 'サン技')
          SpecialEducation.create!(name: 'サンプル特別教育')
          SpecialMedExam.create!(name: 'サンプル特別健康診断')

          expect {
            visit new_users_worker_path
            # Worker
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
            fill_in 'worker[job_title]', with: '役職'
            fill_in 'worker[hiring_on]', with: '2022-01-28'
            fill_in 'worker[experience_term_before_hiring]', with: 1
            fill_in 'worker[blank_term]', with: 1
            # WorkerLicense
            select 'サンプルライセンス', from: 'worker[worker_licenses_attributes][0][license_id]'
            fill_in 'worker[worker_licenses_attributes][0][got_on]', with: '2022-01-28'
            # WorkerSkillTraining
            select 'サンプル技能講習', from: 'worker[worker_skill_trainings_attributes][0][skill_training_id]'
            fill_in 'worker[worker_skill_trainings_attributes][0][got_on]', with: '2022-01-28'
            # WorkerSpecialEducation
            select 'サンプル特別教育', from: 'worker[worker_special_educations_attributes][0][special_education_id]'
            fill_in 'worker[worker_special_educations_attributes][0][got_on]', with: '2022-01-28'
            # WoekerMedical
            fill_in 'worker[worker_medical_attributes][med_exam_on]', with: '2022-03-01'
            fill_in 'worker[worker_medical_attributes][max_blood_pressure]', with: '120'
            fill_in 'worker[worker_medical_attributes][min_blood_pressure]', with: '70'
            fill_in 'worker[worker_medical_attributes][special_med_exam_on]', with: '2022-03-01'
            # WorkerExam
            select 'サンプル特別健康診断', from: 'worker[worker_medical_attributes][worker_exams_attributes][0][special_med_exam_id]'
            fill_in 'worker[worker_medical_attributes][worker_exams_attributes][0][got_on]', with: '2022-03-01'
            attach_file 'worker[worker_medical_attributes][worker_exams_attributes][0][images][]', 'app/assets/images/photo1.png'
            # WorkerInsurance
            select '健康保険組合', from: 'worker[worker_insurance_attributes][health_insurance_type]'
            fill_in 'worker[worker_insurance_attributes][health_insurance_name]', with: 'サンプル健康保険'
            select '厚生年金', from: 'worker[worker_insurance_attributes][pension_insurance_type]'
            select '被保険者', from: 'worker[worker_insurance_attributes][employment_insurance_type]'
            fill_in 'worker[worker_insurance_attributes][employment_insurance_number]', with: '0000'
            select '建退共手帳', from: 'worker[worker_insurance_attributes][severance_pay_mutual_aid_type]'
            fill_in 'worker[worker_insurance_attributes][severance_pay_mutual_aid_name]', with: 'テスト共済制度'
            click_button '登録'
          }.to change(Worker,
            :count).by(1).and change(WorkerLicense,
              :count).by(1).and change(WorkerSkillTraining, :count).by(1).and change(WorkerSpecialEducation, :count).by(1)
          expect(page).to have_content '作業員情報を作成しました'
          expect(page).to have_content '作業員情報詳細'
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
          fill_in 'worker[job_title]', with: ''
          fill_in 'worker[hiring_on]', with: '2022-01-28'
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_button '登録'
          expect(page).to have_content '入力エラー'
          expect(page).to have_content '作業員情報登録'
          expect(page).to have_no_content '作業員情報詳細'
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
          expect(page).to have_content '作業員情報詳細'
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
          expect(page).to have_no_content '作業員情報詳細'
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
        }.to change(Worker,
          :count).by(-1).and change(WorkerLicense,
            :count).by(-1).and change(WorkerSkillTraining, :count).by(-1).and change(WorkerSpecialEducation, :count).by(-1)
        expect(page).to have_current_path users_workers_path, ignore_query: true
        expect(page).to have_content '作業員情報一覧'
      end
    end
  end
end
