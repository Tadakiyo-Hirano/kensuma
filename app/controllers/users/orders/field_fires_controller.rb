module Users::Orders
  class FieldFiresController < Users::Base
    before_action :set_order
    before_action :set_field_fire, only: :destroy
    before_action :set_field_fires, only: %i[index edit_fires update_fires]

    def index
      # field_fire_ids = @field_fires.map { |field_fire| field_fire.content['id'] }
      # @fire = current_business.fires.where.not(id: field_fire_ids)
    end

    def create
    #   ActiveRecord::Base.transaction do
    #     params[:fire_ids].each do |fire_id|
    #       @order.field_fires.create!(
    #         fire_name: Fire.find(fire_id).vehicle_name,
    #         content:  fire_info(Fire.find(fire_id))
    #       )
    #     end
    #     flash[:success] = "#{params[:fire_ids].count}件追加しました。"
    #     redirect_to users_order_field_fires_url
    #   end
    # rescue ActiveRecord::RecordInvalid
    #   flash[:danger] = '登録に失敗しました。再度登録してください。'
    #   redirect_to users_order_field_fires_url
    end

    def destroy
      # @field_fire.destroy!
      # flash[:danger] = "#{@field_fire.fire_name}を削除しました"
      # redirect_to users_order_field_fires_url
    end

    def edit_fires; end

    def update_fires
      # field_fires_params.each do |id, item|
      #   unless item[:driver_worker_id].blank?
      #     item[:driver_name] = Worker.find(item[:driver_worker_id]).name
      #     item[:driver_address] = Worker.find(item[:driver_worker_id]).my_address
      #     item[:driver_birth_day_on] = Worker.find(item[:driver_worker_id]).birth_day_on
      #   end
      #   field_fire = FieldFire.find(id)
      #   field_fire.update(item)
      # end
      # flash[:success] = '火気情報を更新しました'
      # redirect_to users_order_field_fires_url
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

    def field_fires_params
      params.require(:order).permit(
        field_fires: %i[

        ]
      )
    end
  end
end
