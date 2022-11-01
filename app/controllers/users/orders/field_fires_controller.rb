module Users::Orders
  class FieldFiresController < Users::Base
    before_action :set_order
    before_action :set_field_fire, only: %i[show edit update destroy]
    before_action :set_field_fires, only: %i[index]

    def index; end

    def show; end

    def new
      @field_fire = @order.field_fires.new
    end

    def create
      @field_fire = @order.field_fires.build(field_fire_params)
      if @field_fire.save
        flash[:success] = "火気情報を登録しました。"
        redirect_to users_order_field_fires_url
      else
        render :new
      end
    end

    def edit; end

    def update
      if @field_fire.update(field_fire_params)
        flash[:success] = '更新しました'
        redirect_to users_order_field_fire_path
      else
        render 'edit'
      end
    end

    def destroy
      @field_fire.destroy!
      flash[:danger] = "火気情報を削除しました"
      redirect_to users_order_field_fires_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_fire
      @field_fire = @order.field_fires.find_by(uuid: params[:uuid])
    end

    def set_field_fires
      @field_fires = @order.field_fires
    end

    def field_fire_params
      params.require(:field_fire).permit(
        :use_place, :usage, {other_usages: []}, :usage_period_start, :usage_period_end, :usage_time_start, :usage_time_end,
        :type_of_fire, :management_method, :precautions, :fire_origin_responsible, :fire_use_responsible
      )
    end
  end
end
