module Users
  class SpecialVehiclesController < Users::Base
    before_action :set_special_vehicle, except: %i[index new create]

    def index
      @special_vehicles = current_business.special_vehicles
    end

    def show; end

    def new
      @special_vehicle = current_business.special_vehicles.new(
        # テスト用デフォルト値 ==========================
        name:                    'コンテナ用セミトレーラ1',
        maker:                   '三菱',
        standards_performance:   '幅2.5M',
        year_manufactured:       Date.today.ago(3.years),
        control_number:          SecureRandom.hex(5),
        check_exp_date_year:     Date.today.since(2.years),
        check_exp_date_month:    Date.today.since(2.years).since(3.month),
        check_exp_date_specific: Date.today.since(2.years).since(6.month),
        check_exp_date_machine:  Date.today.since(3.years),
        check_exp_date_car:      Date.today.since(5.years),
        personal_insurance:      1,
        objective_insurance:     2,
        passenger_insurance:     3,
        other_insurance:         4,
        exp_date_insurance:      Date.today.since(5.years)
        # ============================================
      )
    end

    def create
      @special_vehicle = current_business.special_vehicles.build(special_vehicle_params)
      if @special_vehicle.save
        redirect_to users_special_vehicle_url(@special_vehicle)
      else
        render :new
      end
    end

    def edit; end

    def update
      if @special_vehicle.update(special_vehicle_params)
        flash[:success] = '更新しました'
        redirect_to users_special_vehicle_url
      else
        render 'edit'
      end
    end

    def destroy
      @special_vehicle.destroy!
      flash[:danger] = "#{@special_vehicle.name}を削除しました"
      redirect_to users_special_vehicles_url
    end

    private

    def set_special_vehicle
      @special_vehicle = current_business.special_vehicles.find_by(uuid: params[:uuid])
    end

    def special_vehicle_params
      params.require(:special_vehicle).permit(:name, :maker, :standards_performance,
        :year_manufactured, :control_number, :check_exp_date_year, :check_exp_date_month,
        :check_exp_date_specific, :check_exp_date_machine, :check_exp_date_car,
        :personal_insurance, :objective_insurance, :passenger_insurance, :other_insurance,
        :exp_date_insurance
      )
    end
  end
end
