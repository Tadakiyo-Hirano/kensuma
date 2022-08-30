module Users
  class RequestOrdersController < Users::Base
    before_action :set_business_workers_name, only: %i[edit update]
    before_action :set_request_order, except: :index
    before_action :set_sub_request_order, only: %i[fix_request approve]
    before_action :exclude_prime_contractor, only: %i[edit update]

    def index
      @request_orders = current_business.request_orders
    end

    def show
      @sub_request_orders = @request_order.children
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
        @request_order.approved!
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
        :registered_core_engineer_name
      )
    end
  end
end
