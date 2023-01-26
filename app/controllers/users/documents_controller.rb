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
          when 'doc_5th', 'doc_13rd', 'doc_14th', 'doc_18th'
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
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_13rd', 'doc_16th', 'doc_17th'
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
      when 'doc_3rd', 'doc_6th', 'doc_7th', 'doc_16th', 'doc_17th'
        params.require(:document).permit(content: 
          %i[
            date_submitted
          ]
        )
      when 'doc_13rd'
        field_special_vehicle_ids = @document.request_order.field_special_vehicles.ids
        field_special_vehicle_keys = field_special_vehicle_ids.map{|field_special_vehicle_id|"field_special_vehicle_#{field_special_vehicle_id}"}

        params.require(:document).permit(content: 
          [
            date_submitted:                field_special_vehicle_keys, # 13-001 提出日(西暦)
            a_over_winding_prevention:     field_special_vehicle_keys, # 13-111 (a)Aクレーン部 安全装置         巻過防止装置
            a_overload_protector:          field_special_vehicle_keys, # 13-112 (a)Aクレーン部 安全装置         過負荷防止装置
            a_anti_slip_hook:              field_special_vehicle_keys, # 13-113 (a)Aクレーン部 安全装置         フックのはずれ
            a_control_of_hoisting_device:  field_special_vehicle_keys, # 13-114 (a)Aクレーン部 安全装置         起伏装置制御
            a_swivel_warning_device:       field_special_vehicle_keys, # 13-115 (a)Aクレーン部 安全装置         旋回警報装置
            a_main_supplemental:           field_special_vehicle_keys, # 13-116 (a)Aクレーン部 制御装置･作業装置 主巻･補巻
            a_up_down_turning:             field_special_vehicle_keys, # 13-117 (a)Aクレーン部 制御装置･作業装置 起伏･旋回
            a_clutch:                      field_special_vehicle_keys, # 13-118 (a)Aクレーン部 制御装置･作業装置 クラッチ
            a_brake_lock:                  field_special_vehicle_keys, # 13-119 (a)Aクレーン部 制御装置･作業装置 ブレーキ･ロック
            a_jib:                         field_special_vehicle_keys, # 13-120 (a)Aクレーン部 制御装置･作業装置 ジブ
            a_pulley:                      field_special_vehicle_keys, # 13-121 (a)Aクレーン部 制御装置･作業装置 滑車
            a_hook_bucket:                 field_special_vehicle_keys, # 13-122 (a)Aクレーン部 制御装置･作業装置 フック･バケット
            a_wire_rope_chain:             field_special_vehicle_keys, # 13-123 (a)Aクレーン部 制御装置･作業装置 ワイヤロープ･チェーン
            a_slinging_tool:               field_special_vehicle_keys, # 13-124 (a)Aクレーン部 制御装置･作業装置 玉掛用具
            a_control_unit:                field_special_vehicle_keys, # 13-125 (a)Aクレーン部 その他           操作装置
            a_performance_indication:      field_special_vehicle_keys, # 13-126 (a)Aクレーン部 その他           性能表示
            a_lighting:                    field_special_vehicle_keys, # 13-127 (a)Aクレーン部 その他           照明
            b_clutch:                      field_special_vehicle_keys, # 13-129 (a)B車両部　　 走行部　　       クラッチ
            b_brake:                       field_special_vehicle_keys, # 13-129 (a)B車両部　　 走行部　　       ブレーキ
            b_handle:                      field_special_vehicle_keys, # 13-130 (a)B車両部　　 走行部　　       ハンドル
            b_tire:                        field_special_vehicle_keys, # 13-131 (a)B車両部　　 走行部　　       タイヤ
            b_crawler:                     field_special_vehicle_keys, # 13-132 (a)B車両部　　 走行部　　       クローラ
            b_alarm_device:                field_special_vehicle_keys, # 13-133 (a)B車両部　　 安全装置等       警報装置
            b_various_mirrors:             field_special_vehicle_keys, # 13-134 (a)B車両部　　 安全装置等       各種ミラー
            b_direction_indicator:         field_special_vehicle_keys, # 13-135 (a)B車両部　　 安全装置等       方向指示器
            b_headlights:                  field_special_vehicle_keys, # 13-136 (a)B車両部　　 安全装置等       前後照灯
            b_left_turn_protector:         field_special_vehicle_keys, # 13-137 (a)B車両部　　 安全装置等       左折プロテクター
            b_outrigger:                   field_special_vehicle_keys, # 13-138 (a)B車両部　　 安全装置等       アウトリガー
            b_elevator:                    field_special_vehicle_keys, # 13-139 (a)B車両部　　 安全装置等       昇降装置
            b_vessel:                      field_special_vehicle_keys, # 13-140 (a)B車両部　　 安全装置等       ベッセル
            b_rearward_monitoring_devices: field_special_vehicle_keys, # 13-141 (a)B車両部　　 安全装置等       後方監視装置
            c_piercing:                    field_special_vehicle_keys, # 13-142 (a)Cゴンドラ　                 突りょう
            c_workbench:                   field_special_vehicle_keys, # 13-143 (a)Cゴンドラ　                 作業床
            c_elevator:                    field_special_vehicle_keys, # 13-144 (a)Cゴンドラ　                 昇降装置
            c_electrical_equipment:        field_special_vehicle_keys, # 13-145 (a)Cゴンドラ　                 電気装置
            c_wire_lifeline:               field_special_vehicle_keys, # 13-146 (a)Cゴンドラ　                 ワイヤ･ライフライン
            d_turning:                     field_special_vehicle_keys, # 13-147 (a)D安全装置　 各種ロック       旋回
            d_bucket:                      field_special_vehicle_keys, # 13-148 (a)D安全装置　 各種ロック       バケット
            d_boom_arm:                    field_special_vehicle_keys, # 13-149 (a)D安全装置　 各種ロック       ブーム･アーム
            d_add_item_1:                  field_special_vehicle_keys, # 13-150 (a)D安全装置　 各種ロック       追加項目1(13-103)
            d_add_item_2:                  field_special_vehicle_keys, # 13-151 (a)D安全装置　 各種ロック       追加項目2(13-104)
            d_add_item_3:                  field_special_vehicle_keys, # 13-152 (a)D安全装置　 各種ロック       追加項目3(13-105)
            d_alarm_device:                field_special_vehicle_keys, # 13-153 (a)D安全装置　                 警報装置
            d_outrigger:                   field_special_vehicle_keys, # 13-154 (a)D安全装置　                 アウトリガー
            d_head_guard:                  field_special_vehicle_keys, # 13-155 (a)D安全装置　                 ヘッドガード
            d_lighting:                    field_special_vehicle_keys, # 13-156 (a)D安全装置　                 照明
            e_control_unit:                field_special_vehicle_keys, # 13-157 (a)E作業装置　                 操作装置
            e_bucket_blade:                field_special_vehicle_keys, # 13-158 (a)E作業装置　                 バケット･ブレード
            e_boom_arm:                    field_special_vehicle_keys, # 13-159 (a)E作業装置　                 ブーム･アーム
            e_jib:                         field_special_vehicle_keys, # 13-160 (a)E作業装置　                 ジブ
            e_reader:                      field_special_vehicle_keys, # 13-161 (a)E作業装置　                 リーダ
            e_hammer_auger__vibro:         field_special_vehicle_keys, # 13-162 (a)E作業装置　                 ハンマ･オーガ･バイブロ
            e_hydraulic_drive_unit:        field_special_vehicle_keys, # 13-163 (a)E作業装置　                 油圧駆動装置
            e_wire_rope_chain:             field_special_vehicle_keys, # 13-164 (a)E作業装置　                 ワイヤロープ･チェーン
            e_hanger:                      field_special_vehicle_keys, # 13-165 (a)E作業装置　                 吊り具等
            e_pulley:                      field_special_vehicle_keys, # 13-166 (a)E作業装置　                 滑車
            f_brake:                       field_special_vehicle_keys, # 13-167 (a)F走行部　                   ブレーキ
            f_parking_brake:               field_special_vehicle_keys, # 13-168 (a)F走行部　                   駐車ブレーキ
            f_brake_lock:                  field_special_vehicle_keys, # 13-169 (a)F走行部　                   ブレーキロック
            f_clutch:                      field_special_vehicle_keys, # 13-170 (a)F走行部　                   クラッチ
            f_control_unit:                field_special_vehicle_keys, # 13-171 (a)F走行部　                   操縦装置
            f_tires_iron_wheel:            field_special_vehicle_keys, # 13-172 (a)F走行部　                   タイヤ･鉄輪
            f_crawler:                     field_special_vehicle_keys, # 13-173 (a)F走行部　                   クローラ
            g_switchboard:                 field_special_vehicle_keys, # 13-174 (a)G電気装置　                 配電盤
            g_wiring:                      field_special_vehicle_keys, # 13-175 (a)G電気装置　                 配線
            g_isolation:                   field_special_vehicle_keys, # 13-176 (a)G電気装置　                 絶縁
            g_earth:                       field_special_vehicle_keys, # 13-177 (a)G電気装置　                 アース
            h_add_item_4:                  field_special_vehicle_keys, # 13-178 (a)Hその他　                   追加項目4(13-106)
            h_add_item_5:                  field_special_vehicle_keys, # 13-179 (a)Hその他　                   追加項目5(13-107)
            h_add_item_6:                  field_special_vehicle_keys, # 13-180 (a)Hその他　                   追加項目6(13-108)
            h_add_item_7:                  field_special_vehicle_keys, # 13-181 (a)Hその他　                   追加項目7(13-109)
            h_add_item_8:                  field_special_vehicle_keys, # 13-182 (a)Hその他　                   追加項目8(13-110)
            inspection_date:               field_special_vehicle_keys, # 13-255 (a)点検年月日
            inspector:                     field_special_vehicle_keys  # 13-256 (a)点検者
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
