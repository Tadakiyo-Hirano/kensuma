module Users::RequestOrders
  class FieldCarsController < Users::Base
    before_action :set_request_order
    before_action :set_business_workers_name, only: %i[edit_cars update_cars]
    before_action :set_field_car, only: :destroy
    before_action :set_field_cars, only: %i[index edit_cars update_cars]
    before_action :check_status_request_order

    def index
      field_car_ids = @field_cars.map { |field_car| field_car.content['id'] }
      @car = current_business.cars.where.not(id: field_car_ids)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:car_ids].each do |car_id|
          @request_order.field_cars.create!(
            car_name: Car.find(car_id).vehicle_name,
            content:  car_info(Car.find(car_id))
          )
        end
        flash[:success] = "#{params[:car_ids].count}件追加しました。"
        redirect_to users_request_order_field_cars_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_request_order_field_cars_url
    end

    def destroy
      @field_car.destroy!
      flash[:danger] = "#{@field_car.car_name}を削除しました"
      redirect_to users_request_order_field_cars_url
    end

    def edit_cars; end

    def update_cars
      field_cars_params.each do |id, item|
        unless item[:driver_worker_id].blank?
          item[:driver_name] = Worker.find(item[:driver_worker_id]).name
          item[:driver_address] = Worker.find(item[:driver_worker_id]).my_address
          item[:driver_birth_day_on] = Worker.find(item[:driver_worker_id]).birth_day_on
          item[:driver_licences] = Worker.find(item[:driver_worker_id]).driver_licences
          item[:driver_licence_number] = Worker.find(item[:driver_worker_id]).driver_licence_number
        end
        field_car = FieldCar.find(id)
        field_car.update(item)
      end
      flash[:success] = '車両情報を更新しました'
      redirect_to users_request_order_field_cars_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_car
      @field_car = @request_order.field_cars.find_by(uuid: params[:uuid])
    end

    def set_field_cars
      @field_cars = @request_order.field_cars
    end

    def field_cars_params
      params.require(:request_order).permit(
        field_cars: %i[
          car_name driver_name usage_period_start usage_period_end
          starting_point waypoint_first waypoint_second arrival_point
          driver_worker_id driver_address driver_birth_day_on
        ]
      )[:field_cars]
    end
  end
end
