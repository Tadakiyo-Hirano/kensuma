module Users::Orders
  class FieldMachinesController < Users::Base
    before_action :set_order
    
    def index; end

    def create; end

    def destroy; end

    def edit_machines; end

    def updte_machines; end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end
  end
end
