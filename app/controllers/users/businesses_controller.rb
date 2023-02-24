module Users
  class BusinessesController < Users::Base
    before_action :set_business, except: %i[new create]
    before_action :business_present_access, only: %i[new create]
    skip_before_action :business_nil_access, only: %i[new create]

    def new
      if Rails.env.development?
        @business = Business.new(
          # テスト用デフォルト値 ==========================
          uuid:                                                        '1',
          name:                                                        'test企業',
          name_kana:                                                   'テストキギョウ',
          branch_name:                                                 'test支店',
          representative_name:                                         'test代表',
          email:                                                       'test@email.com',
          address:                                                     'test',
          post_code:                                                   '0123456',
          phone_number:                                                '01234567898',
          career_up_id:                                                1,
          business_type:                                               0,
          business_health_insurance_status:                            0, # 健康保険(加入状況)
          business_health_insurance_association:                       'テスト健康保険組合', # 健康保険(組合名)
          business_health_insurance_office_number:                     '01234567', # 健康保険(事業所整理記号及び事業所番号)
          business_welfare_pension_insurance_join_status:              0, # 厚生年金保険(加入状況)
          business_welfare_pension_insurance_office_number:            '01234567890123', # 厚生年金保険(事業所整理記号)
          business_pension_insurance_join_status:                      0, # 年金保険(加入状況)
          business_employment_insurance_join_status:                   0, # 雇用保険(加入状況)
          business_employment_insurance_number:                        '01234567890', # 雇用保険(番号)
          business_retirement_benefit_mutual_aid_status:               0, # 退職金共済制度(加入状況)
          construction_license_status:                                 0, # 建設許可証(取得状況)
          construction_license_permission_type_minister_governor:      0, # 建設許可証(種別)
          construction_license_governor_permission_prefecture:         0, # 建設許可証(都道府県)
          construction_license_permission_type_identification_general: 0, # 建設許可証(種別)
          construction_license_number_double_digit:                    29, # 建設許可証(番号)
          construction_license_number_six_digits:                      5000, # 建設許可証(番号)
          construction_license_number:                                 '国土交通大臣(特－29)第5000号', # 建設許可証(建設許可番号)
          construction_license_updated_at:                             Date.today # 建設許可証(更新日)
          # industry_ids:                                                'test'
          # =============================================
        )
        @business.business_occupations.build
      else
        @business = Business.new
      end
    end

    def create
      @business = Business.new(business_params)
      if @business.save
        redirect_to users_orders_url
      else
        render :new
      end
    end

    def edit
      @business.business_occupations.build
    end

    def update
      if @business.update(business_params)
        flash[:success] = '更新しました'
        redirect_to users_business_url
      else
        render 'edit'
      end
    end

    def show; end

    def update_images
      # 残りstamp_imageを定義
      remain_stamp_images = @business.stamp_images
      # stamp_imageを削除する
      deleted_stamp_image = remain_stamp_images.delete_at(params[:index].to_i)
      deleted_stamp_image.try(:remove!)
      # 削除した後のstamp_imageをupdateする
      @business.update!(stamp_images: remain_stamp_images)
      flash[:danger] = '削除しました'
      redirect_to edit_users_business_url
    end

    private

    def set_business
      @business = current_user.business || current_user.admin_user.business
    end

    def business_params
      params.require(:business).permit(
        :uuid, :name, :name_kana, :branch_name, :representative_name, :email, :address, :post_code,
        :phone_number, :career_up_id, :business_type, { stamp_images: [] }, :user_id,
        :business_health_insurance_status, :business_health_insurance_association,
        :business_health_insurance_office_number, :business_welfare_pension_insurance_join_status,
        :business_welfare_pension_insurance_office_number, :business_pension_insurance_join_status,
        :business_employment_insurance_join_status, :business_employment_insurance_number,
        :business_retirement_benefit_mutual_aid_status,
        :construction_license_status, :construction_license_permission_type_minister_governor,
        :construction_license_governor_permission_prefecture, :construction_license_permission_type_identification_general,
        :construction_license_number_double_digit, :construction_license_number_six_digits,
        :construction_license_number, :construction_license_updated_at,
        occupation_ids: [], industry_ids: []
      )
    end
  end
end
