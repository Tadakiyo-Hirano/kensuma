module Users::SubRequestOrders
  class DocumentsController < Users::Base
    # before_action :set_document
    layout 'documents'

    def index
      sub_request_order = validate_request_order!

      @documents = sub_request_order.documents
      render 'users/documents/index'
    end

    def show
      sub_request_order = validate_request_order!
      @documents = sub_request_order.documents
      @document = @documents.find_by!(uuid: params[:uuid])

      respond_to do |format|
        format.html
        format.pdf do
          case @document.document_type
          when 'cover_document', 'table_of_contents_document',
                'doc_3rd', 'doc_6th', 'doc_7th', 'doc_9th', 'doc_10th', 'doc_11th', 'doc_12th', 'doc_15th',
                'doc_16th', 'doc_17th', 'doc_19th', 'doc_20th', 'doc_21st', 'doc_22nd', 'doc_23rd', 'doc_24th'
            return render template: 'users/documents/show', pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A4'
          when 'doc_4th'
            return render template: 'users/documents/show', pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { bottom: 2 }, orientation: 'Landscape'
          when 'doc_5th', 'doc_13th', 'doc_14th', 'doc_18th'
            return render template: 'users/documents/show', pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', orientation: 'Landscape'
          when 'doc_8th'
            return render template: 'users/documents/show', pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { top: 5 }, orientation: 'Landscape'
          end
        end
      end
      render 'users/documents/show'
    end

    def edit
      sub_request_order = validate_request_order!
      @documents = sub_request_order.documents
      @document = @documents.find_by!(uuid: params[:uuid])

      render 'users/documents/edit'
    end

    def update
      sub_request_order = validate_request_order!
      @documents = sub_request_order.documents
      @document = @documents.find_by!(uuid: params[:uuid])
      
      case @document.document_type
      when 'doc_16th'
        if @document.update(document_params(@document))
          redirect_to users_request_order_sub_request_order_document_url, success: '保存に成功しました'
        else
          flash[:danger] = '更新に失敗しました'
          render :edit
        end
      end
    end

    private

    def validate_request_order!
      request_order = current_business.request_orders.find_by!(uuid: params[:request_order_uuid])
      sub_request_order = RequestOrder.find_by!(uuid: params[:sub_request_order_uuid])
      unless sub_request_order.child_of?(request_order) || sub_request_order.descendant_of?(request_order)
        raise 'だめ'
      end

      sub_request_order
    end

    def document_params(document)
      case document.document_type
      when 'doc_16th'
        params.require(:document).permit(content: 
          [
            :fire_permit_number,
            :fire_permit_date,
            :fire_prevention_manager,
            :manager,
            :permit_criteria
          ]
        )
      end
    end

    def set_document
      # @document = RequestOrder.find_by(uuid: params[:sub_request_order_uuid]).documents.find_by(uuid: params[:uuid])
    end
  end
end
