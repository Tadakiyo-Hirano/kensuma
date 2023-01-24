# rubocop:disable all
module Users
  class DocumentsController < Users::Base
    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする
    before_action :set_workers, only: %i[show edit update] # 2次下請以下の作業員を定義する

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
      case @document.document_type
      when 'doc_14th'
        @error_msg_for_doc_14th = nil
      when 'doc_19th'
        @error_msg_for_doc_19th = nil
      end
    end

    def update
      case @document.document_type
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_16th', 'doc_17th'
        if @document.update(document_params(@document))
          redirect_to users_request_order_document_url, success: '保存に成功しました'
        else
          flash[:danger] = '更新に失敗しました'
          render :edit
        end
      when 'doc_14th'
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
      when 'doc_19th'
        @error_msg_for_doc_19th = @document.error_msg_for_doc_19th(document_params(@document))
        if @error_msg_for_doc_19th.blank?
          if @document.update(document_params(@document))
            redirect_to users_request_order_document_url, success: '保存に成功しました'
          else
            flash[:danger] = '保存に失敗しました'
            render action: :edit
          end
        else
          flash[:danger] = '保存に失敗しました'
          render action: :edit
        end

      when 'doc_10th', 'doc_11th' #現場作業員データも更新
        j = 1
        case @document.document_type
        when 'doc_10th'
          focus_workers = document_info.field_workers.where(id: age_border(65))
        when 'doc_11th'
          focus_workers = document_info.field_workers.where(id: age_border(18))
        end
        update_workers = []
        focus_workers.each do |focus_worker|
          focus_worker.content = focus_worker.content
          focus_worker.content["occupation"] = params[:document][:content]["occupation_#{j.ordinalize}".to_sym]
          focus_worker.content["work_notice"] = params[:document][:content]["work_notice_#{j.ordinalize}".to_sym]
          update_workers.push(focus_worker)
          j += 1
        end
        FieldWorker.import update_workers, on_duplicate_key_update: [:content]

        if @document.update(document_params(@document))
          redirect_to users_request_order_document_url, success: '保存に成功しました'
        else
          flash[:danger] = '保存に失敗しました'
          render action: :edit
          flash[:danger] = '更新に失敗しました'
          render :edit
        end
      end
    end

    private

    def set_documents
      @documents = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.order(id: :asc)
    end

    def set_document
      @document = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.find_by(uuid: params[:uuid])
    end

    def set_workers
      case current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.find_by(uuid: params[:uuid]).document_type
      when 'doc_19th'
        request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
        workers = []
        # 元請が資料を確認、作成するとき
        if request_order.parent_id.nil?
          request_order.children.each do |first_request_order|
            @second_workers = first_request_order.children.map { |second_request_order|
              Business.find_by(id: second_request_order.business_id).workers
            }.flatten!
            workers.push(@second_workers).flatten!
            first_request_order.children.each do |second_request_order|
              @third_workers = second_request_order.children.map { |third_request_order|
                Business.find_by(id: third_request_order.business_id).workers
              }.flatten!
              workers.push(@third_workers).flatten!
              second_request_order.children.each do |third_request_order|
                @forth_workers = third_request_order.children.map { |forth_request_order|
                  Business.find_by(id: forth_request_order.business_id).workers
                }.flatten!
                workers.push(@forth_workers).flatten!
              end
            end
          end
        # 1次下請けが資料を確認、作成するとき
        else
          request_order.children.each do |second_request_order|
            @second_workers = request_order.children.map { |second_request_order_sub|
              Business.find_by(id: second_request_order_sub.business_id).workers
            }.flatten!
            workers.push(@second_workers).flatten!
            second_request_order.children.each do |third_request_order|
              @third_workers = second_request_order.children.map { |third_request_order_sub|
                Business.find_by(id: third_request_order_sub.business_id).workers
              }.flatten!
              @forth_workers = third_request_order.children.map { |forth_request_order_sub|
                Business.find_by(id: forth_request_order_sub.business_id).workers
              }.flatten!
              workers.push(@third_workers).flatten!
              workers.push(@forth_workers).flatten!
            end
          end
        end
        merge_workers = workers&.map { |sub_worker| { sub_worker&.name => sub_worker&.uuid } }
        @workers_name_uuid = {}.merge(*merge_workers)
      end
    end

    def document_params(document)
      case document.document_type
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_10th', 'doc_11th', 'doc_16th', 'doc_17th'
        params.require(:document).permit(content:
          [
            :date_submitted
          ]
        )
      when 'doc_14th'
        params.require(:document).permit(content:
        %i[
            date_submitted
            reception_number1
            reception_number2
            reception_number3
            reception_number4
            reception_number5
            reception_number6
            reception_number7
            reception_number8
            reception_number9
            reception_number10
            precautions
            prime_contractor_confirmation
            reception_confirmation_date
            inspection_date
          ]
        )
      when 'doc_19th'
        params.require(:document).permit(content:
          %i[
            prime_contractor_confirmation
            company_name
            date_created
            safety_and_health_construction_policy
            safety_and_health_construction_objective
            construction_type_1st_period_month_1st
            construction_type_1st_period_month_2st
            construction_type_1st_period_month_3rd
            carry_on_machine
            construction_type_period_month_1st
            construction_type_period_week_one_1st
            construction_type_period_week_two_1st
            construction_type_period_week_three_1st
            construction_type_period_week_four_1st
            construction_type_period_week_five_1st
            construction_type_period_month_2nd
            construction_type_period_week_one_2nd
            construction_type_period_week_two_2nd
            construction_type_period_week_three_2nd
            construction_type_period_week_four_2nd
            construction_type_period_week_five_2nd
            construction_type_period_month_3rd
            construction_type_period_week_one_3rd
            construction_type_period_week_two_3rd
            construction_type_period_week_three_3rd
            construction_type_period_week_four_3rd
            construction_type_period_week_five_3rd
            construction_type_1st
            construction_type_1st_period_1st
            construction_type_1st_period_2nd
            construction_type_1st_period_3rd
            daily_safety_and_health_activity
            construction_type_2nd
            construction_type_2nd_period_1st
            construction_type_2nd_period_2nd
            construction_type_2nd_period_3rd
            construction_type_3rd
            construction_type_3rd_period_1st
            construction_type_3rd_period_2nd
            construction_type_3rd_period_3rd
            construction_type_4th
            construction_type_4th_period_1st
            construction_type_4th_period_2nd
            construction_type_4th_period_3rd
            construction_type_5th
            construction_type_5th_period_1st
            construction_type_5th_period_2nd
            construction_type_5th_period_3rd
            main_machine_equipment
            main_tool
            main_material
            protective_equipment
            qualified_staff
            work_classification_1st
            predicted_disaster_1st
            risk_reduction_measures_1st
            predicted_disaster_2nd
            risk_reduction_measures_2nd
            work_classification_2nd
            predicted_disaster_3rd
            risk_reduction_measures_3rd
            work_classification_3rd
            risk_reduction_measures_4th
            predicted_disaster_4th
            risk_reduction_measures_5th
            predicted_disaster_5th
            predicted_disaster_6th
            risk_reduction_measures_6th
            predicted_disaster_7th
            risk_reduction_measures_7th
            predicted_disaster_8th
            risk_reduction_measures_8th
            construction_manager
            subcontractor_construction_workers_position_1st
            subcontractor_construction_workers_name_1st
            subcontractor_company_name_1st
            subcontractor_construction_workers_position_2nd
            subcontractor_construction_workers_name_2nd
            subcontractor_company_name_2nd
            subcontractor_construction_workers_position_3rd
            subcontractor_construction_workers_name_3rd
            subcontractor_company_name_3rd
            subcontractor_construction_workers_position_4th
            subcontractor_construction_workers_name_4th
            subcontractor_company_name_4th
            safety_and_health_manager
            subcontractor_construction_workers_position_5th
            subcontractor_construction_workers_name_5th
            subcontractor_company_name_5th
            subcontractor_construction_workers_position_6th
            subcontractor_construction_workers_name_6th
            subcontractor_company_name_6th
            subcontracting_notice
            subcontractor_organization_chart
            worker_list
            use_notification
            use_notification_for_mobile_crane
            use_notification_for_vehicle_construction_machine
            use_notification_for_use_notification_for_electric_tool
            use_notification_for_electric_welder
            use_notification_for_construction_vehicle
            use_notification_for_organic_solvent_and_specific_chemical_substance
            use_notification_for_fire
            use_notification_for_others_1st
            use_notification_name_for_others_1st
            sending_education_report
            new_entry_education_report
            use_notification_for_others_2nd
            use_notification_name_for_others_2nd
            use_notification_for_others_3rd
            use_notification_name_for_others_3rd
            work_plan_1st
            work_plan_name_1st
            work_plan_2nd
            work_plan_name_2nd
            work_plan_3rd
            work_plan_name_3rd
            work_plan_4th
            work_plan_name_4th
            safety_and_health_plan
            use_notification_for_others_4th
            use_notification_name_for_others_4th
            use_notification_for_others_5th
            use_notification_name_for_others_5th
            use_notification_for_others_6th
            use_notification_name_for_others_6th
            risk_possibility_1st
            risk_possibility_2nd
            risk_possibility_3rd
            risk_possibility_4th
            risk_possibility_5th
            risk_possibility_6th
            risk_possibility_7th
            risk_possibility_8th
            risk_seriousness_1st
            risk_seriousness_2nd
            risk_seriousness_3rd
            risk_seriousness_4th
            risk_seriousness_5th
            risk_seriousness_6th
            risk_seriousness_7th
            risk_seriousness_8th
          ]
                                        )
      end
    end
  end
  # rubocop:enable all
end