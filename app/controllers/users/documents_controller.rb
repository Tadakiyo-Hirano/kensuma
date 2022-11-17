module Users
  class DocumentsController < Users::Base
    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする

    def index; end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
          @order = Order.find(request_order.order_id)
          case @document.document_type
          when 'cover_document', 'table_of_contents_document',
                'doc_3rd', 'doc_6th', 'doc_7th', 'doc_9th', 'doc_10th', 'doc_11th', 'doc_12th', 'doc_15th', 'doc_16th',
                'doc_17th', 'doc_18th', 'doc_19th', 'doc_20th', 'doc_21st', 'doc_22nd', 'doc_23rd', 'doc_24th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A4'
          when 'doc_4th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { bottom: 2 }, orientation: 'Landscape'
          when 'doc_5th', 'doc_13th', 'doc_14th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', orientation: 'Landscape'
          when 'doc_8th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { top: 0 }, orientation: 'Landscape'
          end
        end
      end

      request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
      @order = Order.find(request_order.order_id)
    end

    def edit
      request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
      @order = Order.find(request_order.order_id)
      @workers = current_business.workers
      @sub_workers = request_order.children.map{|sub_request_order| Business.find_by(id:sub_request_order.id).workers}
    end

    def update
      binding.pry
      if @document.update(document_params)
        redirect_to users_request_order_document_url, success: "保存に成功しました"
      else
        flash[:danger] = '失敗しました'
        render action: :edit 
      end
    end

    private

    def set_documents
      @documents = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.order(id: :asc)
    end

    def set_document
      @document = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.find_by(uuid: params[:uuid])
    end

    def document_params
      params.require(:document).permit(content:[])
    end
  end
end
