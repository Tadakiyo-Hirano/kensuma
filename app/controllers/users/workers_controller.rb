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
          my_address:                    '東京都港区1-1',
          my_phone_number:               '01234567898',
          family_name:                   'フェルナンデス',
          relationship:                  '父親',
          family_address:                '埼玉県三郷市1-1',
          family_phone_number:           '09876543210',
          birth_day_on:                  '2000-01-28',
          abo_blood_type:                :a,
          rh_blood_type:                 :plus,
          job_title:                     '主任',
          hiring_on:                     '2022-01-28',
          experience_term_before_hiring: 10,
          blank_term:                    3,
          career_up_id:                  '1',
          sex:                           :man
          # ============================================
        )
        @worker.worker_licenses.build(
          # テスト用デフォルト値 ==========================
          got_on:     '2022-01-01',
          license_id: 1
          # ============================================
        )
        @worker.worker_skill_trainings.build(
          # テスト用デフォルト値 ==========================
          got_on:            '2022-02-01',
          skill_training_id: 2
          # ============================================
        )
        @worker.worker_special_educations.build(
          # テスト用デフォルト値 ==========================
          got_on:               '2022-03-01',
          special_education_id: 3
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
          employment_insurance_number:   '0000',
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
    end

    def create
      @worker = current_business.workers.build(worker_params_with_converted)
      if @worker.save
        health_insurance_name_nil(@worker.worker_insurance.health_insurance_type, @worker.worker_insurance)
        employment_insurance_number_nil(@worker.worker_insurance.employment_insurance_type, @worker.worker_insurance)
        flash[:success] = '作業員情報を作成しました'
        redirect_to users_worker_path(@worker)
      else
        render :new
      end
    end

    def show; end

    def edit
      @worker.worker_licenses.build if @worker.licenses.blank?
      @worker.worker_skill_trainings.build if @worker.skill_trainings.blank?
      @worker.worker_special_educations.build if @worker.special_educations.blank?
    end

    def update
      if @worker.update(worker_params_with_converted)
        health_insurance_name_nil(@worker.worker_insurance.health_insurance_type, @worker.worker_insurance)
        employment_insurance_number_nil(@worker.worker_insurance.employment_insurance_type, @worker.worker_insurance)
        flash[:success] = '更新しました'
        redirect_to users_worker_path(@worker)
      else
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

    private

    def set_worker
      @worker = current_business.workers.find_by(uuid: params[:uuid])
    end

    def worker_params_with_converted
      converted_params = worker_params.dup
      # 半角スペースがある場合、全角スペースに変換
      converted_params[:name] = worker_params[:name].gsub(/[\s　]+/, "　")
      converted_params[:name_kana] = worker_params[:name_kana].gsub(/[\s　]+/, "　")
      converted_params
    end

    # 健康保険が健康保険組合もしくは建設国保でなければ保険名をnilにする
    def health_insurance_name_nil(health_insurance_type, worker)
      unless %w[health_insurance_association construction_national_health_insurance].include?(health_insurance_type)
        worker.update(health_insurance_name: nil)
      end
    end

    # 雇用保険が被保険者であ無ければ被保険者番号の下4桁をnilにする
    def employment_insurance_number_nil(employment_insurance_type, worker)
      unless employment_insurance_type == :insured
        worker.update(employment_insurance_number: nil)
      end
    end

    def worker_params
      params.require(:worker).permit(:name, :name_kana,
        :country, :my_address, :my_phone_number, :family_address,
        :family_phone_number, :birth_day_on, :abo_blood_type,
        :rh_blood_type, :job_title, :hiring_on, :experience_term_before_hiring,
        :blank_term, :career_up_id, :employment_contract, :family_name, :relationship, :email, :sex,
        worker_licenses_attributes:           [:id, :got_on, :license_id, { images: [] }, :_destroy],
        worker_skill_trainings_attributes:    [:id, :got_on, :skill_training_id, { images: [] }, :_destroy],
        worker_special_educations_attributes: [:id, :got_on, :special_education_id, { images: [] }, :_destroy],
        worker_medical_attributes:            [
          :id, :med_exam_on, :max_blood_pressure, :min_blood_pressure, :special_med_exam_on, :health_condition, :is_med_exam,
          { worker_exams_attributes: [:id, :got_on, :worker_medical_id, :special_med_exam_id, { images: [] }, :_destroy] }
        ],
        worker_insurance_attributes:          %i[
          id health_insurance_type health_insurance_name pension_insurance_type employment_insurance_type
          employment_insurance_number severance_pay_mutual_aid_type severance_pay_mutual_aid_name has_labor_insurance
        ]
      )
    end
  end
end
