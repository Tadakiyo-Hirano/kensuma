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
      worker_params = params[:order][:field_workers]
      worker_params.each do |key, worker_params|
        worker = FieldWorker.find(key)
        display_required_field?(worker)
        worker.update(field_worker_params(worker_params))
      end
      flash[:success] = '作業員情報を更新しました'
      redirect_to users_order_field_workers_url
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
                    :foreign_job, :foreign_job_description, { proper_management_licenses: [] }).merge(required_fields: @required_fields)
    end
    
    
    def field_workers_params_old
      params.require(:order).permit(:order_site_uu_id, field_workers_attributes: [:id, :admission_date_start, :admission_date_end, :education_date,
                                                    :sendoff_education, :occupation_id, :job_description,
                                                    :foreign_work_place, :foreign_date_start, :foreign_date_end,
                                                    :foreign_job, :foreign_job_description, { proper_management_licenses: [] }])##[:field_workers]
    end
    
  end
end
