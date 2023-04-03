module Users::Orders
  class FieldWorkersController < Users::Base
    before_action :set_order
    before_action :set_field_worker, only: :destroy
    before_action :set_field_workers, only: %i[index edit_workers update_workers]

    def index
      field_worker_ids = @field_workers.map { |field_worker| field_worker.content['id'] }
      @worker = current_business.workers.where.not(id: field_worker_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:worker_ids].each do |worker_id|
          @order.field_workers.create!(
            admission_worker_name: Worker.find(worker_id).name,
            content:               worker_info(Worker.find(worker_id))
          )
        end
        flash[:success] = "#{params[:worker_ids].count}名追加しました。"
        redirect_to users_order_field_workers_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_order_field_workers_url
    end

    def destroy
      @field_worker.destroy!
      flash[:danger] = "#{@field_worker.admission_worker_name}を削除しました"
      redirect_to users_order_field_workers_url
    end

    def edit_workers; end

    def update_workers
      workers_params = params[:order][:field_workers]
      @errors = {}
      updated_field_workers = []
      workers_params.each do |id, worker_params|
        worker = FieldWorker.find(id)
        if age_check?(worker_params, worker) && worker_params[:job_description].blank?
          @errors[id] = '作業内容を入力してください'
        elsif worker.update(field_worker_params(worker_params))
          updated_field_workers << worker
        else
          @errors[id] = '更新に失敗しました'
        end
      end

      if @errors.present?
        target_workers = FieldWorker.where(id: @errors.keys.map(&:to_i)).pluck(:admission_worker_name).join(', ')
        flash.now[:error] = flash_message("#{target_workers}の作業内容欄は必須です")
        render :edit_workers, locals: { error_ids: @errors, field_workers: workers_params }
      else
        flash[:success] = '作業員情報を更新しました'
        redirect_to users_order_field_workers_url
      end
    end

    def destroy_image
      field_worker = FieldWorker.find_by(id: params[:id])
      current_images = field_worker.proper_management_licenses
      deleting_images = current_images.delete_at(params[:index].to_i)
      deleting_images.try(:remove!)
      field_worker.update!(proper_management_licenses: current_images)
      flash[:danger] = '削除しました'
      redirect_to edit_workers_users_order_field_workers_path(@order)
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_worker
      @field_worker = @order.field_workers.find_by(uuid: params[:uuid])
    end

    def set_field_workers
      @field_workers = @order.field_workers
    end

    def field_worker_params(params)
      params.permit(:admission_date_start, :admission_date_end, :education_date,
        :sendoff_education, :occupation_id, :job_description,
        :foreign_work_place, :foreign_date_start, :foreign_date_end,
        :foreign_job, :foreign_job_description, { proper_management_licenses: [] })
    end

    def age_check?(params, worker)
      country = worker.content['country']
      birthday = Date.parse(worker.content['birth_day_on'])
      str_date = Date.parse(params[:admission_date_start])
      age = (str_date - birthday).to_i / 365
      if country == '日本'
        if birthday.present? && (age < 18 || age >= 65)
          return true
        else
          return false
        end
      end
      false
    end

    def flash_message(message)
      "<div class=\"alert alert-danger\">#{ERB::Util.html_escape(message)}</div>".html_safe
    end
  end
end
