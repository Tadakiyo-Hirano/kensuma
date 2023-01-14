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
          case @document.document_type
          when 'cover_document', 'table_of_contents_document',
                'doc_3rd', 'doc_6th', 'doc_7th', 'doc_9th', 'doc_10th', 'doc_11th', 'doc_12th', 'doc_15th', 'doc_16th',
                'doc_17th', 'doc_19th', 'doc_21st', 'doc_22nd', 'doc_23rd', 'doc_24th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A4'
          when 'doc_4th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { bottom: 2 }, orientation: 'Landscape'
          when 'doc_5th', 'doc_13th', 'doc_14th', 'doc_18th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', orientation: 'Landscape'
          when 'doc_8th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { top: 0 }, orientation: 'Landscape'
          when 'doc_20th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { bottom: 2 }
          end
        end
      end
    end

    def edit
      @error_msg_for_doc_14th = nil
    end

    def update
      @error_msg_for_doc_14th = @document.error_msg_for_doc_14th(document_params(@document))
      if @error_msg_for_doc_14th.blank?
        if @document.update(document_params(@document))
          redirect_to users_request_order_document_url, success: "保存に成功しました"
        else
          flash[:danger] = '保存に失敗しました'
          render action: :edit 
        end
      else
        flash[:danger] = @error_msg_for_doc_14th.first
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

    def document_params(document)
      case document.document_type
      when 'doc_3rd', 'doc_17th'
        params.require(:document).permit.merge(
          content: {
            date_submitted: params.dig(:document, :content, :date_submitted)
          }
        )
      when 'doc_14th'
        params.require(:document).permit(content:
          [
            :date_submitted,
            :precautions,
            :prime_contractor_confirmation,
            :reception_confirmation_date
          ]
        )
      end
    end
  end
end
