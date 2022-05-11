module Users
  class OrdersController < Users::Base
    before_action :set_order, except: %i[index new create]

    def index
      @orders = current_business.orders
    end

    def show; end

    def new
      @order = current_business.orders.new(
        # テスト用デフォルト値 ==========================
        site_name:  current_business.name,
        order_name: current_user.name
        # order_post_code: current_business.post_code,
        # order_address:   current_business.address
        # =============================================
      )
    end

    def create
      ActiveRecord::Base.transaction do
        @order = current_business.orders.build(order_params)
        request_order = @order.request_orders.build(business: current_business)
        # 表紙
        request_order.documents.build(
          document_type: 0,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            'business_name': '', # 1-1
            'submitted_on':  ''  # 1-2
          },
          business:      current_business
        )

        # 目次
        request_order.documents.build(
          document_type: 1,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {},
          business:      current_business
        )

        # 施工体制台帳作成建設工事の通知
        request_order.documents.build(
          document_type: 2,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            'submitted_on':           '', # 3-1
            'prime_contractor_name':  '', # 3-2
            'site_name':              '', # 3-3
            'business_name':          '', # 3-4
            'orderer_name':           '', # 3-5
            'construction_name':      '', # 3-6
            'supervisor_name':        '', # 3-7
            'apply':                  '', # 3-8
            'submission_destination': ''  # 3-9
          },
          business:      current_business
        )

        # 作業員名簿
        request_order.documents.build(
          document_type: 5,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {},
            # doc5_8_001_business_name: '', doc5_8_002_site_id: '', doc5_8_003_site_agent: '', doc5_8_004_created_date: '', doc5_8_005_primary_business_name: '',
            # doc5_8_006_primary_business_id: '', doc5_8_007_hierarchy: '', doc5_8_009_my_business_name: '', doc5_8_010_my_business_id: '', doc5_8_011_submitted_on: '', doc5_8_042_confirmation: '',
            # worker: {
            #   doc5_8_012_furigana: [''], doc5_8_013_worker_name: [''], doc5_8_014_skilled_person_id: [''], doc5_8_015_occupation: [''], doc5_8_016_symbol: [''],
            #   doc5_8_017_employment_date: [''], doc5_8_018_years_of_experience: [''], doc5_8_019_birthday: [''], doc5_8_020_age: [''], doc5_8_021_address: [''],
            #   doc5_8_022_family_contact_address: [''], doc5_8_023_telephone_number: [''], doc5_8_024_family_telephone_number: [''], doc5_8_025_health_check_date: [''], doc5_8_026_maximum_blood_pressure: [''],
            #   doc5_8_027_minimum_blood_pressure: [''], doc5_8_028_blood_type: [''], doc5_8_029_special_health_examination_date: [''], doc5_8_030_special_health_check_type: [''], doc5_8_031_health_insurance: [''],
            #   doc5_8_032_pension_insurance: [''], doc5_8_033_employment_insurance_number: [''], doc5_8_034_severance_pay: [''], doc5_8_035_severance_pay_businesses: [''], doc5_8_036_special_education: [''],
            #   doc5_8_037_skill_training: [''], doc5_8_038_licence: [''], doc5_8_039_beginning: [''], doc5_8_040_new_education: [''], doc5_8_041_notebook: ['']
            # }
          # },
          business:      current_business
        )

        if @order.save!
          redirect_to users_order_url(@order)
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度作成してください。'
      redirect_to new_users_order_path
    end

    def edit; end

    def update
      if @order.update(order_params)
        flash[:success] = '更新しました'
        redirect_to users_order_url
      else
        render :edit
      end
    end

    def destroy
      @order.destroy!
      flash[:danger] = "#{@order.site_uu_id}を削除しました"
      redirect_to users_orders_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:site_uu_id])
    end

    def order_params
      params.require(:order).permit(:status, :site_name, :order_name, :order_post_code, :order_address)
    end
  end
end
