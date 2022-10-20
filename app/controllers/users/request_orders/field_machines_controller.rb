module Users::RequestOrders
  class FieldMachinesController < Users::Base
    before_action :set_request_order
    before_action :set_field_machine, only: :destroy
    before_action :set_field_machines, only: %i[index edit_machines update_machines]
    
    def index
      field_machine_ids = @field_machines.map { |field_machine| field_machine.content['id'] }
      @machine = current_business.machines.where.not(id: field_machine_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:machine_ids].each do |machine_id|
          @request_order.field_machines.create!(
            machine_name: Machine.find(machine_id).name,
            content:  machine_info(Machine.find(machine_id))
          )
        end
        flash[:success] = "#{params[:machine_ids].count}件追加しました。"
        redirect_to users_request_order_field_machines_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_request_order_field_machines_url
    end

    def destroy
      @field_machine.destroy!
      flash[:danger] = "#{@field_machine.machine_name}を削除しました"
      redirect_to users_request_order_field_machines_url
    end

    def edit_machines; end

    def update_machines
      field_machines_params.each do |id, item|
        field_machine = FieldMachine.find(id)
        field_machine.update(item)
      end
      flash[:success] = '機械情報を更新しました'
      redirect_to users_request_order_field_machines_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_machine
      @field_machine = @request_order.field_machines.find_by(uuid: params[:uuid])
    end

    def set_field_machines
      @field_machines = @request_order.field_machines
    end

    def field_machines_params
      params.require(:request_order).permit(
        field_machines: %i[
          machine_name carry_on_date carry_out_date precautions
        ]
      )[:field_machines]
    end
  end
end
