module Users::RequestOrders
  class FieldFiresController < Users::Base
    before_action :set_request_order
    before_action :set_business_workers_name, only: %i[new create edit update]
    before_action :set_field_fire, only: %i[show edit update destroy]

    def show; end

    def new
      if @request_order.field_fires.present?
        redirect_to users_request_order_field_fire_path(@request_order, @request_order.field_fires.first)
      else
        @field_fire = @request_order.field_fires.new
      end
    end

    def create
      @field_fire = @request_order.field_fires.build(field_fire_params)
      if @field_fire.save
        other_use_target_reset(@field_fire.fire_use_targets, @field_fire)
        other_fire_type_reset(@field_fire.fire_types, @field_fire)
        flash[:success] = '火気情報を登録しました。'
        redirect_to users_request_order_field_fire_url(@request_order, @field_fire)
      else
        render :new
      end
    end

    def edit; end

    def update
      if @field_fire.update(field_fire_params)
        other_use_target_reset(@field_fire.fire_use_targets, @field_fire)
        other_fire_type_reset(@field_fire.fire_types, @field_fire)
        flash[:success] = '更新しました'
        redirect_to users_request_order_field_fire_url(@request_order, @field_fire)
      else
        render 'edit'
      end
    end

    def destroy
      @field_fire.destroy!
      flash[:danger] = '火気情報を削除しました'
      redirect_to users_request_order_url(@request_order)
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_fire
      @field_fire = @request_order.field_fires.find_by(uuid: params[:uuid])
    end

    # その他のcheckを外した場合はその他の入力用カラムをnilにする。
    def other_use_target_reset(others, field_fire)
      unless others.map { |other| other.id }.include?(9)
        field_fire.update(other_use_target: nil)
      end
    end

    def other_fire_type_reset(others, field_fire)
      unless others.map { |other| other.id }.include?(7)
        field_fire.update(other_fire_type: nil)
      end
    end

    def field_fire_params
      params.require(:field_fire).permit(
        :use_place, :other_use_target, :usage_period_start, :usage_period_end, :other_fire_type,
        :usage_time_start, :usage_time_end, :precautions, :fire_origin_responsible, :fire_use_responsible,
        { fire_use_target_ids: [], fire_type_ids: [], fire_management_ids: [] }
      )
    end
  end
end
