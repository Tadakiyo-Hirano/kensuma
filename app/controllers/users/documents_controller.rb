# rubocop:disable all
module Users
  class DocumentsController < Users::Base
    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする
    before_action :set_workers, only: %i[show edit update] # 2次下請以下の作業員を定義する
    before_action :set_workers1, only: %i[edit update] # 作業員の名前を取得する

    def index; end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          case @document.document_type
          when 'cover_document', 'table_of_contents_document',
                'doc_3rd', 'doc_6th', 'doc_7th', 'doc_9th', 'doc_10th', 'doc_11th', 'doc_12th', 'doc_15th', 'doc_16th',
                'doc_17th', 'doc_19th', 'doc_21st', 'doc_23rd', 'doc_24th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A4'
          when 'doc_4th'
            render pdf: '書類', layout: 'pdf', encording: 'UTF-8', page_size: 'A3', margin: { bottom: 2 }, orientation: 'Landscape'
          when 'doc_5th', 'doc_13th', 'doc_14th', 'doc_18th', 'doc_22nd'
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
      @error_msg_for_doc_19th = nil
      @error_msg_for_doc_20th = nil
    end

    def update
      case @document.document_type
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_17th'
        if @document.update(document_params(@document))
          redirect_to users_request_order_document_url, success: '保存に成功しました'
        else
          flash[:danger] = '更新に失敗しました'
          render :edit
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

      when 'doc_20th'
        # date_selectのデータ取得形式に合わせるため年月を結合
        params[:document][:content][:term] = term_join
        params[:document][:content][:planning_period_beginning] = planning_period_beginning_join
        params[:document][:content][:planning_period_final_stage] = planning_period_final_stage_join
        # 現場人数取得のバリデーションのため
        @error_msg_for_doc_20th = @document.error_msg_for_doc_20th(document_params(@document), params[:request_order_uuid], params[:sub_request_order_uuid])
        if @error_msg_for_doc_20th.blank?
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
      when 'doc_22nd'
        @error_msg_for_doc_22nd = @document.error_msg_for_doc_22nd(document_params(@document))
        if @error_msg_for_doc_22nd.blank?
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
      end
    end

    def set_safety_officer_name
      if params[:safety_officer_name].present?
        @safety_officer_post = Worker.find_by(name: params[:safety_officer_name]).job_title
      else
        @safety_officer_post = ''
      end
      respond_to do |format|
        format.js do
          render 'users/documents/doc_20th/set_safety_officer_name'
        end
      end
    end

    def set_general_manager_name
      if params[:general_manager_name].present?
        @general_manager_post = Worker.find_by(name: params[:general_manager_name]).job_title
      else
        @general_manager_post = ''
      end
      respond_to do |format|
        format.js do
          render 'users/documents/doc_20th/set_general_manager_name'
        end
      end
    end

    def set_safety_manager_name
      if params[:safety_manager_name].present?
        @safety_manager_post = Worker.find_by(name: params[:safety_manager_name]).job_title
      else
        @safety_manager_post = ''
      end
      respond_to do |format|
        format.js do
          render 'users/documents/doc_20th/set_safety_manager_name'
        end
      end
    end

    def set_hygiene_manager_name
      if params[:hygiene_manager_name].present?
        @hygiene_manager_post = Worker.find_by(name: params[:hygiene_manager_name]).job_title
      else
        @hygiene_manager_post = ''
      end
      respond_to do |format|
        format.js do
          render 'users/documents/doc_20th/set_hygiene_manager_name'
        end
      end
    end

    def set_health_and_safety_promoter_name
      if params[:health_and_safety_promoter_name].present?
        @health_and_safety_promoter_post = Worker.find_by(name: params[:health_and_safety_promoter_name]).job_title
      else
        @health_and_safety_promoter_post = ''
      end
      respond_to do |format|
        format.js do
          render 'users/documents/doc_20th/set_health_and_safety_promoter_name'
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

    def set_workers1
      request_order = RequestOrder.find_by(uuid: params[:request_order_uuid])
      @order = Order.find(request_order.order_id)
      @workers_name = FieldWorker.where(field_workerable_id: @order.id).pluck(:admission_worker_name)
    end

    #年度パラメータを再セット
    def term_join
      if params[:document][:content][:term]['(1i)'].present?
        Date.new(
          params[:document][:content][:term]['(1i)'].to_i,
          params[:document][:content][:term]['(2i)'].to_i,
          params[:document][:content][:term]['(3i)'].to_i
        )
      end
    end

    #始期パラメータを再セット
    def planning_period_beginning_join
      if params[:document][:content][:planning_period_beginning]['(1i)'].present? && params[:document][:content][:planning_period_beginning]['(2i)'].present?
        Date.new(
          params[:document][:content][:planning_period_beginning]['(1i)'].to_i,
          params[:document][:content][:planning_period_beginning]['(2i)'].to_i,
          params[:document][:content][:planning_period_beginning]['(3i)'].to_i
        )
      end
    end

    #終期パラメータを再セット
    def planning_period_final_stage_join
      if params[:document][:content][:planning_period_final_stage]['(1i)'].present? && params[:document][:content][:planning_period_final_stage]['(2i)'].present?
        Date.new(
          params[:document][:content][:planning_period_final_stage]['(1i)'].to_i,
          params[:document][:content][:planning_period_final_stage]['(2i)'].to_i,
          params[:document][:content][:planning_period_final_stage]['(3i)'].to_i
        )
      end
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
      when 'doc_3rd', 'doc_17th'
        params.require(:document).permit(content: [:date_submitted])
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_17th'
        params.require(:document).permit(content:
          [
            :date_submitted
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
      when 'doc_20th'
        params.require(:document).permit(content:
          %i[
            date_created
            term
            planning_period_beginning
            planning_period_final_stage
            health_and_safety_policy
            health_and_safety_goals
            health_and_safety_issues
            plan_priority_measures_1st
            plan_items_to_be_implemented_1st
            plan_management_goals_1st
            plan_responsible_for_implementation_1st
            schedules_april_june_1st
            schedules_july_september_1st
            schedules_october_december_1st
            schedules_january_march_1st
            schedules_points_to_note_1st
            schedules_remarks_1st
            plan_priority_measures_2nd
            plan_items_to_be_implemented_2nd
            plan_management_goals_2nd
            plan_responsible_for_implementation_2nd
            schedules_april_june_2nd
            schedules_july_september_2nd
            schedules_october_december_2nd
            schedules_january_march_2nd
            schedules_points_to_note_2nd
            schedules_remarks_2nd
            plan_priority_measures_3rd
            plan_items_to_be_implemented_3rd
            plan_management_goals_3rd
            plan_responsible_for_implementation_3rd
            schedules_april_june_3rd
            schedules_july_september_3rd
            schedules_october_december_3rd
            schedules_january_march_3rd
            schedules_points_to_note_3rd
            schedules_remarks_3rd
            plan_priority_measures_4th
            plan_items_to_be_implemented_4th
            plan_management_goals_4th
            plan_responsible_for_implementation_4th
            schedules_april_june_4th
            schedules_july_september_4th
            schedules_october_december_4th
            schedules_january_march_4th
            schedules_points_to_note_4th
            schedules_remarks_4th
            common_to_work_sitespriority_measures_1st
            common_items_to_be_implemented_1st_1st
            common_items_to_be_implemented_1st_2nd
            common_items_to_be_implemented_1st_3rd
            common_to_work_sitespriority_measures_2nd
            common_items_to_be_implemented_2nd_1st
            common_items_to_be_implemented_2nd_2nd
            common_items_to_be_implemented_2nd_3rd
            common_to_work_sitespriority_measures_3rd
            common_items_to_be_implemented_3rd_1st
            common_items_to_be_implemented_3rd_2nd
            common_items_to_be_implemented_3rd_3rd
            common_to_work_sitespriority_measures_4th
            common_items_to_be_implemented_4th_1st
            common_items_to_be_implemented_4th_2nd
            common_items_to_be_implemented_4th_3rd
            events_april
            events_may
            events_jun
            events_july
            events_august
            events_september
            events_october
            events_november
            events_december
            events_january
            events_february
            events_march
            safety_officer_post
            safety_officer_name
            employment_manager_post
            general_manager_post
            general_manager_name
            safety_manager_post
            safety_manager_name
            hygiene_manager_post
            hygiene_manager_name
            health_and_safety_promoter_post
            health_and_safety_promoter_name
            construction_manager_post
            remarks
          ]
                                        )
      when 'doc_22nd'
        params.require(:document).permit(content:
          %i[
            occupation_1st
            required_qualification_1st
            work_content_1st
            risk_prediction_1st
            foreman_confirmation_1st
            implementation_confirmation_1st
            implementation_confirmation_person_1st
            corrective_action_1st
            corrective_action_confirmation_date_1st
            corrective_action_reviewer_1st
            occupation_2nd
            occupation_3rd
            occupation_4th
            occupation_5th
          ]
                                        )
      end
    end
  end
  # rubocop:enable all
end
