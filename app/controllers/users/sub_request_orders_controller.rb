module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order
    before_action :order_restriction_after_approved, only: %i[new create]

    def index; end

    def new
      @businesses = Business.where.not(id: current_business)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:business_ids].each do |business_id|
          request_order = @request_order.order.request_orders.create!(business_id: business_id, parent_id: @request_order.id)
          create_documents!(request_order)
        end
        flash[:success] = "#{params[:business_ids].count}件の下請発注情報を作成しました。"
        redirect_to users_request_order_url(@request_order)
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '下請発注情報に失敗しました。再度作成してください。'
      redirect_to new_users_request_order_sub_request_order_path
    end

    def update; end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def create_documents!(request_order)
      Document::OPERATABLE_DOC_TYPE.each do |document_type|
        request_order.documents.create!(document_type: document_type, business_id: request_order.business_id)
      end
    end

    def order_restriction_after_approved
      request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
      if request_order.status == 'approved'
        flash[:danger] = '承認されているため依頼できません'
        redirect_to users_request_order_url(uuid: params[:request_order_uuid])
      end
    end
  end
end
