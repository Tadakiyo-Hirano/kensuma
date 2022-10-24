module Users::Orders
  class FieldSolventsController < Users::Base
    before_action :set_order
    before_action :set_field_solvent, only: :destroy
    before_action :set_field_solvents, only: %i[index edit_solvents update_solvents]

    def index
    end

    def create
    end

    def destroy
    end

    def edit_solvents; end

    def update_solvents
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_solvent
      @field_solvent = @order.field_solvents.find_by(uuid: params[:uuid])
    end

    def set_field_solvents
      @field_solvents = @order.field_solvents
    end
  end
end