module Users
  class RequestOrdersController < Users::Base
    before_action :set_business_workers_name, only: %i[edit update]
    before_action :set_request_order, except: :index
    before_action :set_sub_request_order, only: %i[fix_request approve]
    before_action :exclude_prime_contractor, only: %i[edit update]
    before_action :redirect_unless_prime_contractor, only: %i[update_approval_status edit_approval_status]

    def show
      @sub_request_orders = @request_order.children
      @genecon_documents = RequestOrder.find_by(uuid: @request_order.uuid).documents.genecon_documents_type
      @first_subcon_documents = RequestOrder.find_by(uuid: @request_order.uuid).documents.first_subcon_documents_type
      @second_subcon_documents = RequestOrder.find_by(uuid: @request_order.uuid).documents.second_subcon_documents_type
      @third_or_later_subcon_documents = RequestOrder.find_by(uuid: @request_order.uuid).documents.third_or_later_subcon_documents_type
    end

    def edit
      # テスト用デフォルト値 ==========================
      if Rails.env.development? && @request_order.construction_name.nil?
        @request_order.tap do |r|
          r.construction_name =                  'テスト工事名'
          r.construction_details =               'テスト工事内容'
          r.start_date =                         '2022-02-01'
          r.end_date =                           '2022-02-28'
          r.contract_date =                      '2022-01-01'
          r.supervisor_name =                    'テスト監督員名'
          r.supervisor_apply =                   'テスト申出方法'
          r.professional_engineer_name =         'テスト専門技術者名'
          r.professional_engineer_details =      'テスト担当工事内容'
          r.professional_construction =          0
          r.construction_manager_name =          'テスト工事担当責任者名'
          r.construction_manager_position_name = 'テスト工事担当責任者役職名'
          r.site_agent_name =                    'テスト現場代理人名'
          r.site_agent_apply =                   'テスト現場申出方法'
          r.lead_engineer_name =                 'テスト主任技術者名'
          r.lead_engineer_check =                0
          r.work_chief_name =                    'テスト作業主任者名'
          r.work_conductor_name =                'テスト作業指揮者名'
          r.safety_officer_name =                'テスト安全衛生担当責任者名'
          r.safety_manager_name =                'テスト安全衛生責任者名'
          r.safety_promoter_name =               'テスト安全推進者名'
          r.foreman_name =                       'テスト職長名'
          r.registered_core_engineer_name =      'テスト登録基幹技能者名'
        end
      end
      # =============================================
    end

    def update
      if @request_order.update(request_order_params)
        flash[:success] = '更新しました'
        redirect_to users_request_order_url
      else
        render :edit
      end
    end

    def submit
      if @request_order.parent_id.nil? && @request_order.children.all? { |r| r.status == 'approved' }
        @request_order.update_column(:status, 'approved')
        flash[:success] = '下請発注情報を承認しました'
      elsif @request_order.children.all? { |r| r.status == 'approved' }
        @request_order.submitted!
        flash[:success] = '下請発注情報を提出済にしました'
      else
        flash[:danger] = '下請けの書類がまだ未承認です'
      end
      redirect_to users_request_order_path(@request_order)
    end

    def fix_request
      @sub_request_order.fix_requested!
      flash[:warning] = "#{@sub_request_order.business.name}の書類を差し戻ししました"
      redirect_to users_request_order_path(@request_order)
    end

    def approve
      @sub_request_order.approved!
      flash[:success] = "#{@sub_request_order.business.name}の書類を承認しました"
      redirect_to users_request_order_path(@request_order)
    end

    def edit_approval_status; end

    def update_approval_status
      if params[:resecission_uuid].present?
        request_order = RequestOrder.find_by(uuid: params[:resecission_uuid])
        request_order.update_column(:status, 'requested')
        if request_order.parent_id.present?
          loop do
            request_order = request_order.parent
            request_order.update_column(:status, 'requested')
            break if request_order.parent_id.nil?
          end
        end
        flash[:success] = '承認取り消しに成功しました！'
        redirect_to users_request_order_url(@request_order)
      else
        flash[:danger] = '承認を取り消すものを選んでください'
        render :edit_approval_status
      end
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:uuid])
    end

    def set_sub_request_order
      @sub_request_order = RequestOrder.find_by(uuid: params[:sub_request_uuid])
    end

    # 元請けは除外
    def exclude_prime_contractor
      redirect_to users_request_order_url if @request_order.parent_id.nil?
    end

    def redirect_unless_prime_contractor
      redirect_to users_request_order_url unless @request_order.parent_id.nil?
    end

    def request_order_params
      params.require(:request_order).permit(
        :primary_subcontractor,
        :sub_company,
        :construction_name,
        :construction_details,
        :start_date,
        :end_date,
        :contract_date,
        :supervisor_name,
        :supervisor_apply,
        :professional_engineer_name,
        :professional_engineer_skill_training_id,
        :professional_engineer_details,
        :professional_construction,
        :construction_manager_name,
        :construction_manager_position_name,
        :site_agent_name,
        :site_agent_apply,
        :lead_engineer_name,
        :lead_engineer_check,
        :work_chief_name,
        :work_conductor_name,
        :safety_officer_name,
        :safety_manager_name,
        :safety_promoter_name,
        :foreman_name,
        :registered_core_engineer_name,
        content:
                 %i[
                   professional_engineer_skill_training_id
                   lead_engineer_skill_training_id
                   registered_core_engineer_skill_training_id
                 ]
      ).merge(
        content: {
          # このrubocop除外設定はのちに修正されます,Layout/LineLength一行の文字数140を超えている
          professional_engineer_skill_training_id:        params[:request_order][:content][:professional_engineer_skill_training_id],
          lead_engineer_skill_training_id:                params[:request_order][:content][:lead_engineer_skill_training_id],
          registered_core_engineer_skill_training_id:     params[:request_order][:content][:registered_core_engineer_skill_training_id],
          subcon_name:                                    current_business.name, # 会社名
          subcon_branch_name:                             current_business.branch_name,                                      # 支店･営業所名
          subcon_address:                                 current_business.address,                                          # 会社住所
          subcon_post_code:                               current_business.post_code,                                        # 会社郵便番号
          subcon_phone_number:                            current_business.phone_number,                                     # 会社電話番号
          subcon_fax_number:                              current_business.fax_number,                                       # 会社FAX番号
          subcon_career_up_id:                            current_business.career_up_id,                                     # 事業所ID(キャリアアップ)
          subcon_representative_name:                     current_business.representative_name,                              # 代表者名
          subcon_health_insurance_status:                 current_business.business_health_insurance_status,                 # 健康保険加入状況
          subcon_health_insurance_association:            current_business.business_health_insurance_association,            # 健康保険会社
          subcon_health_insurance_office_number:          current_business.business_health_insurance_office_number,          # 健康保険番号
          subcon_welfare_pension_insurance_join_status:   current_business.business_welfare_pension_insurance_join_status,   # 厚生年金加入状況
          subcon_welfare_pension_insurance_office_number: current_business.business_welfare_pension_insurance_office_number, # 厚生年金番号
          subcon_employment_insurance_join_status:        current_business.business_employment_insurance_join_status,        # 雇用保険加入状況
          subcon_employment_insurance_number:             current_business.business_employment_insurance_number,             # 雇用保険番号
          # subcon_occupation:                                                  Occupation.find(current_business.business_occupations.first.occupation_id).name, # 業種
          # subcon_construction_license_permission_type_minister_governor:      current_business.construction_license_permission_type_minister_governor_i18n,      # 建設業許可種別(大臣,知事)
          # subcon_construction_license_permission_type_identification_general: current_business.construction_license_permission_type_identification_general_i18n, # 建設業許可種別(特定,一般)
          # subcon_construction_construction_license_number_double_digit:       current_business.construction_license_number_double_digit,                         # 建設業許可番号(2桁)
          # subcon_construction_license_number_six_digits:                      current_business.construction_license_number_six_digits,                           # 建設業許可番号(5桁)
          # subcon_construction_license_number:                                 current_business.construction_license_number,                                      # 建設業許可番号(合成)
          subcon_employment_manager_name:                 current_business.employment_manager_name,                                          # 雇用管理責任者名
          subcon_specific_skilled_foreigners_exist:       current_business.specific_skilled_foreigners_exist_i18n,                           # 一号特定技能外国人の従事の状況(有無)
          subcon_foreign_construction_workers_exist:      current_business.foreign_construction_workers_exist_i18n,                          # 外国人建設就労者の従事の状況(有無)
          subcon_foreign_technical_intern_trainees_exist: current_business.foreign_technical_intern_trainees_exist_i18n # 外国人技能実習生の従事の状況(有無)
          # subcon_construction_license_updated_at:                             current_business.construction_license_updated_at                                   # 建設許可証(更新日)
        }
      )
    end
  end
end
