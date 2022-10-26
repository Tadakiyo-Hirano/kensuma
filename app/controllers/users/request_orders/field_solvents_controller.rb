module Users::RequestOrders
  class FieldSolventsController < Users::Base
    before_action :set_request_order
    before_action :set_field_solvent, only: :destroy
    before_action :set_field_solvents, only: %i[index edit_solvents update_solvents]

    def index
      field_solvent_ids = @field_solvents.map { |field_solvent| field_solvent.content['id'] }
      @solvent = current_business.solvents.where.not(id: field_solvent_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:solvent_ids].each do |solvent_id|
          @request_order.field_solvents.create!(
            solvent_name: Solvent.find(solvent_id).name,
            content:      solvent_info(Solvent.find(solvent_id))
          )
        end
        flash[:success] = "#{params[:solvent_ids].count}件追加しました。"
        redirect_to users_request_order_field_solvents_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_request_order_field_solvents_url
    end

    def destroy
      @field_solvent.destroy!
      flash[:danger] = "#{@field_solvent.solvent_name}を削除しました"
      redirect_to users_request_order_field_solvents_url
    end

    def edit_solvents; end

    def update_solvents
      field_solvents_params.each do |id, item|
        field_solvent = FieldSolvent.find(id)
        field_solvent.update(item)
      end
      flash[:success] = '溶剤情報を更新しました'
      redirect_to users_request_order_field_solvents_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_solvent
      @field_solvent = @request_order.field_solvents.find_by(uuid: params[:uuid])
    end

    def set_field_solvents
      @field_solvents = @request_order.field_solvents
    end

    def field_solvents_params
      params.require(:request_order).permit(
        field_solvents: %i[
          solvent_name carried_quantity using_location storing_place using_tool
          usage_period_start usage_period_end working_process sds ventilation_control
        ]
      )[:field_solvents]
    end
  end
end