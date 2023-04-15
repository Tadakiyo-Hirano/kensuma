module Users
  class WorkersController < Users::Base
    before_action :set_worker, only: %i[show edit update destroy]

    def index
      @workers = current_business.workers
    end

    def new
      if Rails.env.development?
        @worker = current_business.workers.new(
          # テスト用デフォルト値 ==========================
          name:                          'サンプル作業員',
          name_kana:                     'サンプルサギョウイン',
          country:                       'JP',
          email:                         "test_#{Worker.last.id + 1}@email.com",
          my_address:                    '東京都港区1-1',
          my_phone_number:               '012345678901',
          family_name:                   'フェルナンデス',
          relationship:                  '父親',
          family_address:                '埼玉県三郷市1-1',
          family_phone_number:           '1234567890',
          birth_day_on:                  '2000-01-28',
          abo_blood_type:                :a,
          rh_blood_type:                 :plus,
          job_title:                     '主任',
          hiring_on:                     '2022-01-28',
          experience_term_before_hiring: 10,
          blank_term:                    3,
          driver_licence:                '普通',
          career_up_id:                  '%14d' % rand(99999999999999),
          sex:                           :man,
          post_code:                     "1234567"
          # ============================================
        )
        worker_add_hyhpen(@worker)
        @worker.worker_licenses.build(
          # テスト用デフォルト値 ==========================
          license_id: 1
          # ============================================
        )
        @worker.worker_skill_trainings.build(
          # テスト用デフォルト値 ==========================
          skill_training_id: 2
          # ============================================
        )
        @worker.worker_special_educations.build(
          # テスト用デフォルト値 ==========================
          special_education_id: 3
          # ============================================
        )
        @worker.worker_safety_health_educations.build(
          # テスト用デフォルト値 ==========================
          safety_health_education_id: 1
          # ============================================
        )
        worker_medical = @worker.build_worker_medical(
          # テスト用デフォルト値 ==========================
          is_med_exam:         :y,
          health_condition:    :good,
          med_exam_on:         '2022-03-01',
          max_blood_pressure:  120,
          min_blood_pressure:  70,
          special_med_exam_on: '2022-03-01'
          # ============================================
        )
        worker_medical.worker_exams.build(
          # テスト用デフォルト値 ==========================
          special_med_exam_id: 4,
          got_on:              '2022-03-01'
          # ============================================
        )
        @worker.build_worker_insurance(
          # テスト用デフォルト値 ==========================
          health_insurance_type:         :health_insurance_association,
          health_insurance_name:         'サンプル健康保険',
          pension_insurance_type:        :welfare,
          employment_insurance_type:     :insured,
          employment_insurance_number:   '12345678901',
          severance_pay_mutual_aid_type: :kentaikyo,
          severance_pay_mutual_aid_name: 'テスト共済制度'
          # ============================================
        )
      else
        @worker = current_business.workers.new(
          # 本番環境用デフォルト値 ==========================
          country:        'JP',
          abo_blood_type: :a,
          rh_blood_type:  :plus,
          sex:            :man
          # ============================================
        )
        worker_add_hyhpen(@worker)
        @worker.worker_licenses.build
        @worker.worker_skill_trainings.build
        @worker.worker_special_educations.build
        worker_medical = @worker.build_worker_medical(
          # 本番環境用デフォルト値 ==========================
          is_med_exam:      :y,
          health_condition: :good
          # ============================================
        )
        worker_medical.worker_exams.build
        @worker.build_worker_insurance(
          # 本番環境用デフォルト値 ==========================
          health_insurance_type:         :health_insurance_association,
          pension_insurance_type:        :welfare,
          employment_insurance_type:     :insured,
          severance_pay_mutual_aid_type: :kentaikyo
          # ============================================
        )
      end
      @driver_licence = []
    end

    def create
      @worker = current_business.workers.build(worker_params_with_converted)
      if @worker.save
        flash[:success] = '作業員情報を作成しました'
        redirect_to users_worker_path(@worker)
      else
        worker_add_hyhpen(@worker)
        if driver_licences_params[:driver_licences].present?
          @driver_licence = driver_licences_params[:driver_licences].values
        else
          @driver_licence = []
        end
        render :new
      end
    end

    def show
      worker_add_hyhpen(@worker)
    end

    def edit
      @worker.worker_licenses.build if @worker.licenses.blank?
      @worker.worker_skill_trainings.build if @worker.skill_trainings.blank?
      @worker.worker_special_educations.build if @worker.special_educations.blank?
      worker_add_hyhpen(@worker)
      @driver_licence = format_array(@worker.driver_licence)
    end

    def update
      if @worker.update(worker_params_with_converted)
        flash[:success] = '更新しました'
        redirect_to users_worker_path(@worker)
      else
        worker_add_hyhpen(@worker)
        if driver_licences_params[:driver_licences].present?
          @driver_licence = driver_licences_params[:driver_licences].values
        else
          @driver_licence = []
        end
        render :edit
      end
    end

    def destroy
      @worker.destroy!
      flash[:danger] = "#{@worker.name}を削除しました"
      redirect_to users_workers_url
    end

    def update_workerlicense_images
      worker = current_business.workers.find(params[:worker_id])
      worker_license = worker.worker_licenses.find(params[:worker_license_id])
      remain_images = worker_license.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_license.update!(images: remain_images)
      flash[:danger] = '証明画像を削除しました'
      redirect_to edit_users_worker_url(worker) and return
    end

    def update_workerskilltraining_images
      worker = current_business.workers.find(params[:worker_id])
      worker_skill_training = worker.worker_skill_trainings.find(params[:worker_skill_training_id])
      remain_images = worker_skill_training.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_skill_training.update!(images: remain_images)
      flash[:danger] = '証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    def update_workerspecialeducation_images
      worker = current_business.workers.find(params[:worker_id])
      worker_special_education = worker.worker_special_educations.find(params[:worker_special_education_id])
      remain_images = worker_special_education.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_special_education.update!(images: remain_images)
      flash[:danger] = '証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    def update_workerexam_images
      worker = current_business.workers.find(params[:worker_id])
      worker_exam = worker.worker_medical.worker_exams.find(params[:worker_exam_id])
      remaining_images = worker_exam.images
      deleting_images = remaining_images.delete_at(params[:index].to_i)
      deleting_images.try(:remove!)
      worker_exam.update!(images: remaining_images)
      flash[:danger] = '証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    def update_worker_safety_health_education_images
      worker = current_business.workers.find(params[:worker_id])
      worker_safety_health_education = worker.worker_safety_health_educations.find(params[:safety_health_education_id])
      remaining_images = worker_safety_health_education.images
      deleting_images = remaining_images.delete_at(params[:index].to_i)
      deleting_images.try(:remove!)
      worker_safety_health_education.update!(images: remaining_images)
      flash[:danger] = '証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    private

    def set_worker
      @worker = current_business.workers.find_by(uuid: params[:uuid])
    end

    def worker_params_with_converted
      converted_params = worker_params.dup
      # 全角スペースを半角スペースに変換
      %i[name name_kana].each do |key|
        next unless converted_params[key].present?

        converted_params[key] = space_full_width_to_half_width(converted_params[key])
      end

      # ハイフンを除去する
      %i[my_phone_number family_phone_number post_code career_up_id driver_licence_number].each do |key|
        next unless converted_params[key].present?

        converted_params[key] = reject_hyphen(converted_params[key])
      end

      # スペースを除去する
      %i[career_up_id driver_licence_number].each do |key|
        next unless converted_params[key].present?

        converted_params[key] = reject_space(converted_params[key])
      end

      # 全角数字を半角に変換
      %i[
        my_phone_number
        family_phone_number
        post_code
        career_up_id
        driver_licence_number
        blank_term
        experience_term_before_hiring
        driver_licence_number
      ].each do |key|
        next unless converted_params[key].present?

        converted_params[key] = full_width_to_half_width(converted_params[key])
      end

      # 保険名及び被保険者番号が必須でない場合パラメータを空文字にする
      %i[health_insurance_name employment_insurance_number].each do |key|
        next unless converted_params[key].present?

        converted_params[key] = health_insurance_name_nil(converted_params[health_insurance_type])
        converted_params[key] = health_insurance_name_nil(converted_params[employment_insurance_type])
      end
      # 運転免許証のデータを作成
      if driver_licences_params[:driver_licences].present?
        converted_params[:driver_licence] = driver_licences_string(driver_licences_params[:driver_licences])
      else
        converted_params[:driver_licence_number] = ''
      end
      converted_params
    end

    # 健康保険が健康保険組合もしくは建設国保でなければ保険名を空文字にする
    def health_insurance_name_nil(key, health_insurance_type)
      health_insurance_name_precenses = %w[health_insurance_association construction_national_health_insurance]
      if key == 'health_insurance_name' && health_insurance_name_precenses.exclude?(health_insurance_type)
        ''
      end
    end

    # 雇用保険が被保険者で無ければ被保険者番号を空文字にする
    def employment_insurance_number_nil(key, employment_insurance_type)
      if key == 'employment_insurance_number' && employment_insurance_type != :insured
        ''
      end
    end

    # 単数作業員情報のハイフン差し込み
    def worker_add_hyhpen(worker)
      @my_phone_number = phone_number_add_hyphen(worker.my_phone_number)
      @family_phone_number = phone_number_add_hyphen(worker.family_phone_number)
      @post_code = add_hyphen([3], worker.post_code)
      @career_up_id = add_hyphen([4, 4, 4], worker.career_up_id)
      @driver_licence_number = add_hyphen([4, 4], worker.driver_licence_number)
    end

    # 送られたハッシュの値をつなげた文字列に変換
    def driver_licences_string(driver_licences_params)
      driver_licences_params.values.join(' ')
    end

    def worker_params
      params.require(:worker).permit(:name, :name_kana,
        :country, :my_address, :my_phone_number, :family_address, :post_code, { career_up_images: [] },
        :family_phone_number, :birth_day_on, :abo_blood_type, { employee_cards: [] }, :driver_licence,
        :rh_blood_type, :job_title, :hiring_on, :experience_term_before_hiring, :driver_licence_number,
        :blank_term, :career_up_id, :employment_contract, :family_name, :relationship, :email, :sex, :seal, :status_of_residence,
        worker_licenses_attributes:                 [:id, :license_id, { images: [] }, :_destroy],
        worker_safety_health_educations_attributes: [:id, :safety_health_education_id, { images: [] }, :_destroy],
        worker_skill_trainings_attributes:          [:id, :skill_training_id, { images: [] }, :_destroy],
        worker_special_educations_attributes:       [:id, :special_education_id, { images: [] }, :_destroy],
        worker_medical_attributes:                  [
          :id, :med_exam_on, :max_blood_pressure, :min_blood_pressure, :special_med_exam_on, :health_condition, :is_med_exam,
          { worker_exams_attributes: [:id, :got_on, :worker_medical_id, :special_med_exam_id, { images: [] }, :_destroy] }
        ],
        worker_insurance_attributes:                %i[
          id
          health_insurance_type
          health_insurance_name
          pension_insurance_type
          employment_insurance_type
          employment_insurance_number
          severance_pay_mutual_aid_type
          severance_pay_mutual_aid_name
          has_labor_insurance
        ]
      )
    end

    def driver_licences_params
      params.permit(driver_licences: [:LL, :ML, :MLC, :MLL, :SL, :SLL, :LLT, :SLT, :SLSP, :MOP, :TDL])
    end
  end
end
