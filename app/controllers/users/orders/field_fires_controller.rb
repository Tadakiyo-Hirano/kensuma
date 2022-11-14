module Users::Orders
  class FieldFiresController < Users::Base
    before_action :set_order
    before_action :set_business_workers_name, only: %i[new create edit update]
    before_action :set_field_fire, only: %i[show edit update destroy]

    def show; end

    def index; end

    def new
      if @order.field_fires.present?
        redirect_to users_order_field_fire_path(@order, @order.field_fires.first)
      else
        @field_fire = @order.field_fires.new
      end
    end

    def create
      @field_fire = @order.field_fires.build(field_fire_params)
      if @field_fire.save
        other_use_target_reset(@field_fire.fire_use_targets, @field_fire)
        other_fire_type_reset(@field_fire.fire_types, @field_fire)
        flash[:success] = '火気情報を登録しました。'
        redirect_to users_order_field_fire_url(@order, @field_fire)
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
        redirect_to users_order_field_fire_url(@order, @field_fire)
      else
        render 'edit'
      end
    end

    def destroy
      @field_fire.destroy!
      flash[:danger] = '火気情報を削除しました'
      redirect_to users_order_url(@order)
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_fire
      @field_fire = @order.field_fires.find_by(uuid: params[:uuid])
    end

    # その他のcheckを外した場合はその他の入力用カラムをnilにする。
    def other_use_target_reset(others, field_fire)
      unless others.map(&:id).include?(9)
        field_fire.update(other_use_target: nil)
      end
    end

    def other_fire_type_reset(others, field_fire)
      unless others.map(&:id).include?(7)
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
