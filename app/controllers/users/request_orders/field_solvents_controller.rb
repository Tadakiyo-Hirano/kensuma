module Users::RequestOrders
  class FieldSolventsController < Users::Base
    before_action :set_request_order
    before_action :set_field_solvent, only: %i[show edit update destroy]

    def show; end

    def new
      if @request_order.field_solvents.present?
        redirect_to users_request_order_field_solvent_path(@request_order, @request_order.field_solvents.first)
      else
        @field_solvent = @request_order.field_solvents.new
      end
    end

    def set_solvent_name_one
      if params[:solvent_name_one].present?
        solvent = Solvent.where(business_id: @request_order.business_id)
        @solvent_classification_one = solvent.find_by(name: params[:solvent_name_one]).classification
        @solvent_ingredients_one = solvent.find_by(name: params[:solvent_name_one]).ingredients
      else
        @solvent_classification_one = ''
        @solvent_ingredients_one = ''
      end
      respond_to do |format|
        format.js
      end
    end

    def set_solvent_name_two
      if params[:solvent_name_two].present?
        solvent = Solvent.where(business_id: @request_order.business_id)
        @solvent_classification_two = solvent.find_by(name: params[:solvent_name_two]).classification
        @solvent_ingredients_two = solvent.find_by(name: params[:solvent_name_two]).ingredients
      else
        @solvent_classification_two = ''
        @solvent_ingredients_two = ''
      end
      respond_to do |format|
        format.js
      end
    end

    def set_solvent_name_three
      if params[:solvent_name_three].present?
        solvent = Solvent.where(business_id: @request_order.business_id)
        @solvent_classification_three = solvent.find_by(name: params[:solvent_name_three]).classification
        @solvent_ingredients_three = solvent.find_by(name: params[:solvent_name_three]).ingredients
      else
        @solvent_classification_three = ''
        @solvent_ingredients_three = ''
      end
      respond_to do |format|
        format.js
      end
    end

    def set_solvent_name_four
      if params[:solvent_name_four].present?
        solvent = Solvent.where(business_id: @request_order.business_id)
        @solvent_classification_four = solvent.find_by(name: params[:solvent_name_four]).classification
        @solvent_ingredients_four = solvent.find_by(name: params[:solvent_name_four]).ingredients
      else
        @solvent_classification_four = ''
        @solvent_ingredients_four = ''
      end
      respond_to do |format|
        format.js
      end
    end

    def set_solvent_name_five
      if params[:solvent_name_five].present?
        solvent = Solvent.where(business_id: @request_order.business_id)
        @solvent_classification_five = solvent.find_by(name: params[:solvent_name_five]).classification
        @solvent_ingredients_five = solvent.find_by(name: params[:solvent_name_five]).ingredients
      else
        @solvent_classification_five = ''
        @solvent_ingredients_five = ''
      end
      respond_to do |format|
        format.js
      end
    end

    def create
      @field_solvent = @request_order.field_solvents.build(field_solvent_params)
      if @field_solvent.save
        flash[:success] = '溶剤情報を登録しました。'
        redirect_to users_request_order_field_solvent_url(@request_order, @field_solvent)
      else
        render :new
      end
    end

    def destroy
      @field_solvent.destroy!
      flash[:danger] = '溶剤情報を削除しました'
      redirect_to users_request_order_url(@request_order)
    end

    def edit; end

    def update
      if @field_solvent.update(field_solvent_params)
        flash[:success] = '溶剤情報を更新しました'
        redirect_to users_request_order_field_solvent_url(@request_order, @field_solvent)
      else
        render 'edit'
      end
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_solvent
      @field_solvent = @request_order.field_solvents.find_by(uuid: params[:uuid])
    end

    def set_field_solvents
      @field_solvents = @request_order.field_solvents
    end

    def field_solvent_params
      params.require(:field_solvent).permit(
        :solvent_name_one, :solvent_name_two, :solvent_name_three, :solvent_name_four, :solvent_name_five,
        :carried_quantity_one, :carried_quantity_two, :carried_quantity_three, :carried_quantity_four, :carried_quantity_five,
        :solvent_classification_one, :solvent_classification_two, :solvent_classification_three, :solvent_classification_four,
        :solvent_classification_five,
        :solvent_ingredients_one, :solvent_ingredients_two, :solvent_ingredients_three, :solvent_ingredients_four,
        :solvent_ingredients_five, :date_submitted,
        :using_location, :storing_place, :using_tool, :usage_period_start, :usage_period_end, :working_process, :sds, :ventilation_control
      )
    end
  end
end
