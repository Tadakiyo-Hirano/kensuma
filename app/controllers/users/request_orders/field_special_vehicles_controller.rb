module Users::RequestOrders
  class FieldSpecialVehiclesController < Users::Base
    before_action :set_request_order
    before_action :set_field_special_vehicle, only: :destroy
    before_action :set_field_special_vehicles, only: %i[index edit_special_vehicles update_special_vehicles]
    before_action :check_status_order

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
      @use_companies = @field_special_vehicles.distinct.pluck(:use_company_name)
      @use_company_representatives = @field_special_vehicles.distinct.pluck(:use_company_representative_name)
    end

    def update_special_vehicles
      error = 0
      field_special_vehicles_params.each do |id, item|
        item[:driver_licenses] = params[:request_order][:field_special_vehicles][id][:driver_licenses]
        item[:sub_driver_licenses] = params[:request_order][:field_special_vehicles][id][:sub_driver_licenses]

        %i[driver_licenses sub_driver_licenses].each do |key|
          if item[key].reject(&:blank?).empty?
            error += 1
          end
        end

        unless item[:driver_worker_id].blank?
          item[:driver_name] = Worker.find(item[:driver_worker_id]).name
          # item[:driver_license] = Worker.find(item[:driver_worker_id]).worker_licenses.map { |worker_license| License.find(worker_license.license_id).name }.to_s.gsub(/,|"|\[|\]/) { '' }
        end
        unless item[:sub_driver_worker_id].blank?
          item[:sub_driver_name] = Worker.find(item[:sub_driver_worker_id]).name
          # item[:sub_driver_license] = Worker.find(item[:sub_driver_worker_id]).worker_licenses.map { |worker_license| License.find(worker_license.license_id).name }.to_s.gsub(/,|"|\[|\]/) { '' }
        end
        field_special_vehicle = FieldSpecialVehicle.find(id)
        field_special_vehicle.update(item)
      end

      if error.positive?
        flash.now[:error] = flash_message('運転資格を選択してください')
        render :edit_special_vehicles
      else
        flash[:success] = '特殊車両情報を更新しました'
        redirect_to users_request_order_field_special_vehicles_url
      end
    end

    # ajax
    def dr_license_select
      worker = Worker.find_by(id: params[:worker_id])
      if worker.present?
        skill_tr_table = worker.skill_trainings.where(driving_related: 1).pluck(:name)
        sp_education_table = worker.special_educations.where(driving_related: 1).pluck(:name)
        dr_license_table = worker.driver_licence.split(' ')
        driver_table = skill_tr_table + sp_education_table + dr_license_table
      end
      render partial: 'dr-license-select', locals: { dr_licenses: driver_table }
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
          driver_worker_id driver_name
          sub_driver_worker_id sub_driver_name sub_driver_licenses
          vehicle_name vehicle_type carry_on_company_name owning_company_name owning_company_representative_name
          use_company_name use_company_representative_name carry_on_date carry_out_date
          use_place lease_type contact_prevention precautions
        ], driver_licenses: []
      )[:field_special_vehicles]
    end

    def flash_message(message)
      "<div class=\"alert alert-danger\">#{ERB::Util.html_escape(message)}</div>".html_safe
    end
  end
end
