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
      @sub_workers = request_order.children.map{|sub_request_order| Business.find_by(id:sub_request_order.business_id).workers}
    end

    def update
      if @document.update(document_params(@document))
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

    def document_params(document)
      case document.document_type
      when 'doc_19th'
        params.require(:document).permit(content: 
          [
            :prime_contractor_confirmation,
            :company_name,
            :date_created,
            :safety_and_health_construction_policy,
            :safety_and_health_construction_objective,
            :construction_type_1st_period_month_1st,
            :construction_type_1st_period_month_2st,
            :construction_type_1st_period_month_3rd,
            :carry_on_machine,
            :construction_type_1st_period_month_1st,
            :construction_type_period_week_one_1st,
            :construction_type_period_week_two_1st,
            :construction_type_period_week_three_1st,
            :construction_type_period_week_four_1st,
            :construction_type_period_week_five_1st,
            :construction_type_1st_period_month_2st,
            :construction_type_period_week_one_2nd,
            :construction_type_period_week_two_2nd,
            :construction_type_period_week_three_2nd,
            :construction_type_period_week_four_2nd,
            :construction_type_period_week_five_2nd,
            :construction_type_1st_period_month_3rd,
            :construction_type_period_week_one_3rd,
            :construction_type_period_week_two_3rd,
            :construction_type_period_week_three_3rd,
            :construction_type_period_week_four_3rd,
            :construction_type_period_week_five_3rd,
            :construction_type_1st,
            :construction_type_1st_period_1st,
            :construction_type_1st_period_2nd,
            :construction_type_1st_period_3rd,
            :daily_safety_and_health_activity,
            :construction_type_2nd,
            :construction_type_2nd_period_1st,
            :construction_type_2nd_period_2nd,
            :construction_type_2nd_period_3rd,
            :construction_type_3rd,
            :construction_type_3rd_period_1st,
            :construction_type_3rd_period_2nd,
            :construction_type_3rd_period_3rd,
            :construction_type_4th,
            :construction_type_4th_period_1st,
            :construction_type_4th_period_2nd,
            :construction_type_4th_period_3rd,
            :construction_type_5th,
            :construction_type_5th_period_1st,
            :construction_type_5th_period_2nd,
            :construction_type_5th_period_3rd,
            :main_machine_equipment,
            :main_tool,
            :main_material,
            :protective_equipment,
            :qualified_staff,
            :work_classification_1st,
            :predicted_disaster_1st,
            :risk_reduction_measures_1st,
            :predicted_disaster_2nd,
            :risk_reduction_measures_2nd,
            :work_classification_2nd,
            :predicted_disaster_3rd,
            :risk_reduction_measures_3rd,
            :work_classification_3rd,
            :risk_reduction_measures_4th,
            :work_classification_4th,
            :risk_reduction_measures_5th,
            :work_classification_5th,
            :work_classification_6th,
            :risk_reduction_measures_6th,
            :work_classification_7th,
            :risk_reduction_measures_7th,
            :work_classification_8th,
            :risk_reduction_measures_8th,
            :construction_manager,
            :subcontractor_construction_workers_position_1st,
            :subcontractor_construction_workers_name_1st,
            :subcontractor_company_name_1st,
            :subcontractor_construction_workers_position_2nd,
            :subcontractor_construction_workers_name_2nd,
            :subcontractor_company_name_2nd,
            :subcontractor_construction_workers_position_3rd,
            :subcontractor_construction_workers_name_3rd,
            :subcontractor_company_name_3rd,
            :subcontractor_construction_workers_position_4th,
            :subcontractor_construction_workers_name_4th,
            :subcontractor_company_name_4th,
            :safety_and_health_manager,
            :subcontractor_construction_workers_position_5th,
            :subcontractor_construction_workers_name_5th,
            :subcontractor_company_name_5th,
            :subcontractor_construction_workers_position_6th,
            :subcontractor_construction_workers_name_6th,
            :subcontractor_company_name_6th,
            :subcontracting_notice,
            :subcontractor_organization_chart,
            :worker_list,
            :use_notification,
            :use_notification_for_mobile_crane,
            :use_notification_for_vehicle_construction_machine,
            :use_notification_for_use_notification_for_electric_tool,
            :use_notification_for_electric_welder,
            :use_notification_for_construction_vehicle,
            :use_notification_for_organic_solvent_and_specific_chemical_substance,
            :use_notification_for_fire,
            :use_notification_for_others_1st,
            :use_notification_name_for_others_1st,
            :sending_education_report,
            :new_entry_education_report,
            :use_notification_for_others_2nd,
            :use_notification_name_for_others_2nd,
            :use_notification_for_others_3rd,
            :use_notification_name_for_others_3rd,
            :work_plan_1st,
            :work_plan_name_1st,
            :work_plan_2nd,
            :work_plan_name_2nd,
            :work_plan_3rd,
            :work_plan_name_3rd, 
            :work_plan_4th,
            :work_plan_name_4th,
            :safety_and_health_plan,
            :use_notification_for_others_4th,
            :use_notification_name_for_others_4th,
            :use_notification_for_others_5th,
            :use_notification_name_for_others_5th,
            :use_notification_for_others_6th,
            :use_notification_name_for_others_6th,
            :risk_possibility_1st,
            :risk_possibility_2nd,
            :risk_possibility_3rd,
            :risk_possibility_4th,
            :risk_possibility_5th,
            :risk_possibility_6th,
            :risk_possibility_7th,
            :risk_possibility_8th,
            :risk_seriousness_1st,
            :risk_seriousness_2nd,
            :risk_seriousness_3rd,
            :risk_seriousness_4th,
            :risk_seriousness_5th,
            :risk_seriousness_6th,
            :risk_seriousness_7th,
            :risk_seriousness_8th
          ]
        )
      end
    end
  end
end
