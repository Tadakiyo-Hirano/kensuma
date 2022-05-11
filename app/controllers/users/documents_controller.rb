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
          when 'cover_document', 'table_of_contents_document', 'doc_2nd'
            render pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4'
          when 'doc_5th'
            render pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4',
              margin: { top: 0 },
              orientation: 'Landscape'
          end
        end
      end
    end

    def edit
      @workers = Worker.all
    end

    def update
      if update_document(@document)
        flash[:success] = '更新に成功しました'
        redirect_to users_request_order_document_url
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

    # 更新書類の判定
    def update_document(document)
      case document.document_type
      when 'cover_document'
        document.update(cover_params)
      when 'doc_2nd'
        document.update(doc_2nd_params)
      when 'doc_5th'
        document.update(doc_5th_params)
      end
    end

    # 表紙
    def cover_params
      params.require(:document).permit.merge(
        content: {
          business_name: params[:document][:content][0],
          submitted_on:  params[:document][:content][1]
        })
    end

    # 施工体制台帳作成建設工事の通知
    def doc_2nd_params
      params.require(:document).permit.merge(
        content: {
          submitted_on:           params[:document][:content][0],
          prime_contractor_name:  params[:document][:content][1],
          site_name:              params[:document][:content][2],
          business_name:          params[:document][:content][3],
          orderer_name:           params[:document][:content][4],
          construction_name:      params[:document][:content][5],
          supervisor_name:        params[:document][:content][6],
          apply:                  params[:document][:content][7],
          submission_destination: params[:document][:content][8]
        }
      )
    end

    # 作業員名簿
    def doc_5th_params
      params.require(:document).permit(
        content: []
          # doc5_8_001_business_name:         params.dig(:document, :content, :doc5_8_001_business_name),
          # doc5_8_002_site_id:               params.dig(:document, :content, :doc5_8_002_site_id),
          # doc5_8_003_site_agent:            params.dig(:document, :content, :doc5_8_003_site_agent),
          # doc5_8_004_created_date:          params.dig(:document, :content, :doc5_8_004_created_date),
          # doc5_8_005_primary_business_name: params.dig(:document, :content, :doc5_8_005_primary_business_name),
          # doc5_8_006_primary_business_id:   params.dig(:document, :content, :doc5_8_006_primary_business_id),
          # doc5_8_007_hierarchy:             params.dig(:document, :content, :doc5_8_007_hierarchy),
          # doc5_8_009_my_business_name:      params.dig(:document, :content, :doc5_8_009_my_business_name),
          # doc5_8_010_my_business_id:        params.dig(:document, :content, :doc5_8_010_my_business_id),
          # doc5_8_011_submitted_on:          params.dig(:document, :content, :doc5_8_011_submitted_on),
          # doc5_8_042_confirmation:          params.dig(:document, :content, :doc5_8_042_confirmation),
          # worker:                           {
          #   doc5_8_012_furigana:                        params.dig(:document, :content),
          #   doc5_8_013_worker_name:                     params.dig(:document, :content, :worker, :doc5_8_013_worker_name),
          #   doc5_8_014_skilled_person_id:               params.dig(:document, :content, :worker, :doc5_8_014_skilled_person_id),
          #   doc5_8_015_occupation:                      params.dig(:document, :content, :worker, :doc5_8_015_occupation),
          #   doc5_8_016_symbol:                          params.dig(:document, :content, :worker, :doc5_8_016_symbol),
          #   doc5_8_017_employment_date:                 params.dig(:document, :content, :worker, :doc5_8_017_employment_date),
          #   doc5_8_018_years_of_experience:             params.dig(:document, :content, :worker, :doc5_8_018_years_of_experience),
          #   doc5_8_019_birthday:                        params.dig(:document, :content, :worker, :doc5_8_019_birthday),
          #   doc5_8_020_age:                             params.dig(:document, :content, :worker, :doc5_8_020_age),
          #   doc5_8_021_address:                         params.dig(:document, :content, :worker, :doc5_8_021_address),
          #   doc5_8_022_family_contact_address:          params.dig(:document, :content, :worker, :doc5_8_022_family_contact_address),
          #   doc5_8_023_telephone_number:                params.dig(:document, :content, :worker, :doc5_8_023_telephone_number),
          #   doc5_8_024_family_telephone_number:         params.dig(:document, :content, :worker, :doc5_8_024_family_telephone_number),
          #   doc5_8_025_health_check_date:               params.dig(:document, :content, :worker, :doc5_8_025_health_check_date),
          #   doc5_8_026_maximum_blood_pressure:          params.dig(:document, :content, :worker, :doc5_8_026_maximum_blood_pressure),
          #   doc5_8_027_minimum_blood_pressure:          params.dig(:document, :content, :worker, :doc5_8_027_minimum_blood_pressure),
          #   doc5_8_028_blood_type:                      params.dig(:document, :content, :worker, :doc5_8_028_blood_type),
          #   doc5_8_029_special_health_examination_date: params.dig(:document, :content, :worker,
          #     :doc5_8_029_special_health_examination_date),
          #   doc5_8_030_special_health_check_type:       params.dig(:document, :content, :worker, :doc5_8_030_special_health_check_type),
          #   doc5_8_031_health_insurance:                params.dig(:document, :content, :worker, :doc5_8_031_health_insurance),
          #   doc5_8_032_pension_insurance:               params.dig(:document, :content, :worker, :doc5_8_032_pension_insurance),
          #   doc5_8_033_employment_insurance_number:     params.dig(:document, :content, :worker, :doc5_8_033_employment_insurance_number),
          #   doc5_8_034_severance_pay:                   params.dig(:document, :content, :worker, :doc5_8_034_severance_pay),
          #   doc5_8_035_severance_pay_businesses:        params.dig(:document, :content, :worker, :doc5_8_035_severance_pay_businesses),
          #   doc5_8_036_special_education:               params.dig(:document, :content, :worker, :doc5_8_036_special_education),
          #   doc5_8_037_skill_training:                  params.dig(:document, :content, :worker, :doc5_8_037_skill_training),
          #   doc5_8_038_licence:                         params.dig(:document, :content, :worker, :doc5_8_038_licence),
          #   doc5_8_039_beginning:                       params.dig(:document, :content, :worker, :doc5_8_039_beginning),
          #   doc5_8_040_new_education:                   params.dig(:document, :content, :worker, :doc5_8_040_new_education),
          #   doc5_8_041_notebook:                        params.dig(:document, :content, :worker, :doc5_8_041_notebook)
          # }
        # }
      )
    end
  end
end
