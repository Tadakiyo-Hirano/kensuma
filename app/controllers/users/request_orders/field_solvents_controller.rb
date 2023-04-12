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
        @field_solvent.working_process = 1
        @field_solvent.sds = 1
      end
    end

    def create
      @field_solvent = @request_order.field_solvents.build(field_solvent_params)

      # 溶剤1〜5の種別,含有成分を自動登録させる
      @field_solvent.solvent_classification_one,
      @field_solvent.solvent_ingredients_one = get_solvent_properties(params[:field_solvent][:solvent_name_one])
      @field_solvent.solvent_classification_two,
      @field_solvent.solvent_ingredients_two = get_solvent_properties(params[:field_solvent][:solvent_name_two])
      @field_solvent.solvent_classification_three,
      @field_solvent.solvent_ingredients_three = get_solvent_properties(params[:field_solvent][:solvent_name_three])
      @field_solvent.solvent_classification_four,
      @field_solvent.solvent_ingredients_four = get_solvent_properties(params[:field_solvent][:solvent_name_four])
      @field_solvent.solvent_classification_five,
      @field_solvent.solvent_ingredients_five = get_solvent_properties(params[:field_solvent][:solvent_name_five])

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
      # 溶剤1〜5の種別,含有成分を自動更新させる
      @field_solvent.solvent_classification_one,
      @field_solvent.solvent_ingredients_one = get_solvent_properties(params[:field_solvent][:solvent_name_one])
      @field_solvent.solvent_classification_two,
      @field_solvent.solvent_ingredients_two = get_solvent_properties(params[:field_solvent][:solvent_name_two])
      @field_solvent.solvent_classification_three,
      @field_solvent.solvent_ingredients_three = get_solvent_properties(params[:field_solvent][:solvent_name_three])
      @field_solvent.solvent_classification_four,
      @field_solvent.solvent_ingredients_four = get_solvent_properties(params[:field_solvent][:solvent_name_four])
      @field_solvent.solvent_classification_five,
      @field_solvent.solvent_ingredients_five = get_solvent_properties(params[:field_solvent][:solvent_name_five])

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

    # 溶剤1〜5の種別,含有成分を自動登録・更新させる
    def get_solvent_properties(solvent_name)
      solvent = Solvent.find_by(name: solvent_name)
      if solvent.present?
        classification = solvent.classification
        ingredients = solvent.ingredients
        [classification, ingredients]
      end
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
