module Users::RequestOrders
  class FieldWorkersController < Users::Base
    before_action :set_request_order
    before_action :set_field_worker, only: :destroy
    before_action :set_field_workers, only: %i[index edit_workers update_workers]

    def index
      field_worker_ids = @field_workers.map { |field_worker| field_worker.content['id'] }
      @worker = current_business.workers.where.not(id: current_user).where.not(id: field_worker_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:worker_ids].each do |worker_id|
          @request_order.field_workers.create!(
            admission_worker_name: Worker.find(worker_id).name,
            content:               worker_info(Worker.find(worker_id))
          )
        end
        flash[:success] = "#{params[:worker_ids].count}名追加しました。"
        redirect_to users_request_order_field_workers_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_request_order_field_workers_url
    end

    def destroy
      @field_worker.destroy!
      flash[:danger] = "#{@field_worker.admission_worker_name}を削除しました"
      redirect_to users_request_order_field_workers_url
    end

    def edit_workers; end

    def update_workers
      field_workers_params.each do |id, item|
        field_worker = FieldWorker.find(id)
        field_worker.update(item)
      end
      flash[:success] = '作業員情報を更新しました'
      redirect_to users_request_order_field_workers_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_worker
      @field_worker = @request_order.field_workers.find_by(uuid: params[:uuid])
    end

    def set_field_workers
      @field_workers = @request_order.field_workers
    end

    def field_workers_params
      params.require(:request_order).permit(field_workers: %i[admission_date_start admission_date_end education_date])[:field_workers]
    end
  end
end
