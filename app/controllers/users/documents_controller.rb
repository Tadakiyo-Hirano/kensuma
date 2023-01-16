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

    def edit; end

    def update
      if @document.update(document_params(@document))
        redirect_to users_request_order_document_url, success: '保存に成功しました'
      else
        flash[:danger] = '更新に失敗しました'
        render :edit
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
      when 'doc_3rd'
        params.require(:document).permit.merge(
          content: {
            date_submitted: params.dig(:document, :content, :date_submitted)
          }
        )
        
        when 'doc_10th'
        params.require(:document).permit(content: 
          [
            :date_submitted,
            :occupation_1st,
            :work_notice_1st,
            :occupation_2nd,
            :work_notice_2nd,
            :occupation_3rd,
            :work_notice_3rd,
            :occupation_4th,
            :work_notice_4th,
            :occupation_5th,
            :work_notice_5th,
            :occupation_6th,
            :work_notice_6th,
            :occupation_7th,
            :work_notice_7th,
            :occupation_8th,
            :work_notice_8th,
            :occupation_9th,
            :work_notice_9th,
            :occupation_10th,
            :work_notice_10th,
            :occupation_11th,
            :work_notice_11th,
            :occupation_12th,
            :work_notice_12th,
            :occupation_13th,
            :work_notice_13th,
            :occupation_14th,
            :work_notice_14th,
            :occupation_15th,
            :work_notice_15th,
            :occupation_16th,
            :work_notice_16th,
            :occupation_17th,
            :work_notice_17th,
            :occupation_18th,
            :work_notice_18th,
            :occupation_19th,
            :work_notice_19th,
            :occupation_20th,
            :work_notice_20th,
            :occupation_21st,
            :work_notice_21st,
            :occupation_22nd,
            :work_notice_22nd,
            :occupation_23rd,
            :work_notice_23rd,
            :occupation_24th,
            :work_notice_24th,
            :occupation_25th,
            :work_notice_25th,
            :occupation_26th,
            :work_notice_26th,
            :occupation_27th,
            :work_notice_27th,
            :occupation_28th,
            :work_notice_28th
          ]
        )
      end
    end
  end
end
