module Users::Orders
  class FieldSpecialVehiclesController < Users::Base
    before_action :set_order
    before_action :set_field_special_vehicle, only: :destroy
    before_action :set_field_special_vehicles, only: %i[index edit_special_vehicles update_special_vehicles]

    def index
      field_special_vehicle_ids = @field_special_vehicles.map { |field_special_vehicle| field_special_vehicle.content['id'] }
      @special_vehicle = current_business.special_vehicles
    end

    def create
      ActiveRecord::Base.transaction do
        params[:special_vehicle_ids].each do |special_vehicle_id|
          @order.field_special_vehicles.create!(
            # special_vehicle_name: FieldSpecialVehicle.find(special_vehicle_id).name,
            content:  special_vehicle_info(SpecialVehicle.find(special_vehicle_id))
          )
        end
        flash[:success] = "#{params[:special_vehicle_ids].count}件追加しました。"
        redirect_to users_order_field_special_vehicles_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_order_field_special_vehicles_url
    end

    def destroy; end

    def edit_special_vehicles; end

    def update_special_vehicles; end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_special_vehicle
      @field_special_vehicle = @order.field_special_vehicles.find_by(uuid: params[:uuid])
    end

    def set_field_special_vehicles
      @field_special_vehicles = @order.field_special_vehicles
    end

    def field_special_vehicles_params
      params.require(:order).permit(
        field_special_vehicles: %i[
          
        ]
      )[:field_special_vehicles]
    end
  end
end
