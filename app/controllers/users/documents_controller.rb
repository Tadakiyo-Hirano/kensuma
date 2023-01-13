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
            :older_work_1st,
            :occupation_2nd,
            :older_work_2nd,
            :occupation_3rd,
            :older_work_3rd,
            :occupation_4th,
            :older_work_4th,
            :occupation_5th,
            :older_work_5th,
            :occupation_6,
            :older_work_6,
            :occupation_7,
            :older_work_7,
            :occupation_8,
            :older_work_8,
            :occupation_9,
            :older_work_9,
            :occupation_10,
            :older_work_10,
            :occupation_11,
            :older_work_11,
            :occupation_12,
            :older_work_12,
            :occupation_13,
            :older_work_13,
            :occupation_14,
            :older_work_14,
            :occupation_15,
            :older_work_15,
            :occupation_16,
            :older_work_16,
            :occupation_17,
            :older_work_17,
            :occupation_18,
            :older_work_18,
            :occupation_19,
            :older_work_19,
            :occupation_20,
            :older_work_20,
            :occupation_21,
            :older_work_21,
            :occupation_22,
            :older_work_22,
            :occupation_23,
            :older_work_23,
            :occupation_24,
            :older_work_24
          ]
        )
      end
    end
  end
end
