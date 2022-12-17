module Users::RequestOrders
  class FieldSpecialVehiclesController < Users::Base
    before_action :set_request_order
    before_action :set_field_special_vehicle, only: :destroy
    before_action :set_field_special_vehicles, only: %i[index edit_special_vehicles update_special_vehicles]

    def index
      field_special_vehicle_ids = @field_special_vehicles.map { |field_special_vehicle| field_special_vehicle.content['id'] }
      @special_vehicle = current_business.special_vehicles.where.not(id: field_special_vehicle_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:special_vehicle_ids].each do |special_vehicle_id|
          @request_order.field_special_vehicles.create!(
            vehicle_name: SpecialVehicle.find(special_vehicle_id).name,
            content:      special_vehicle_info(SpecialVehicle.find(special_vehicle_id))
          )
        end
        flash[:success] = "#{params[:special_vehicle_ids].count}件追加しました。"
        redirect_to users_request_order_field_special_vehicles_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_request_order_field_special_vehicles_url
    end

    def destroy
      @field_special_vehicle.destroy!
      flash[:danger] = "#{@field_special_vehicle.vehicle_name}を削除しました"
      redirect_to users_request_order_field_special_vehicles_url
    end

    def edit_special_vehicles
      @carry_on_companies = @field_special_vehicles.distinct.pluck(:carry_on_company_name)
      @owning_companies = @field_special_vehicles.distinct.pluck(:owning_company_name)
      @use_companies = @field_special_vehicles.distinct.pluck(:use_company_name)
    end

    def update_special_vehicles
      field_special_vehicles_params.each do |id, item|
        unless item[:driver_worker_id].blank?
          item[:driver_name] = Worker.find(item[:driver_worker_id]).name
          item[:driver_license] = Worker.find(item[:driver_worker_id]).worker_licenses.map { |worker_license| License.find(worker_license.license_id).name }.to_s.gsub(/,|"|\[|\]/) { '' }
        end
        unless item[:sub_driver_worker_id].blank?
          item[:sub_driver_name] = Worker.find(item[:sub_driver_worker_id]).name
          item[:sub_driver_license] = Worker.find(item[:sub_driver_worker_id]).worker_licenses.map { |worker_license| License.find(worker_license.license_id).name }.to_s.gsub(/,|"|\[|\]/) { '' }
        end
        field_special_vehicle = FieldSpecialVehicle.find(id)
        field_special_vehicle.update(item)
      end
      flash[:success] = '特殊車両情報を更新しました'
      redirect_to users_request_order_field_special_vehicles_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_special_vehicle
      @field_special_vehicle = @request_order.field_special_vehicles.find_by(uuid: params[:uuid])
    end

    def set_field_special_vehicles
      @field_special_vehicles = @request_order.field_special_vehicles
    end

    def field_special_vehicles_params
      params.require(:request_order).permit(
        field_special_vehicles: %i[
          driver_worker_id driver_name driver_licence
          sub_driver_worker_id sub_driver_name sub_driver_licence
          vehicle_name vehicle_type carry_on_company_name owning_company_name
          use_company_name carry_on_date carry_out_date use_place lease_type contact_prevention precautions
        ]
      )[:field_special_vehicles]
    end
  end
end
