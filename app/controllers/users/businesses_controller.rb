# rubocop:disable all
module Users
  class BusinessesController < Users::Base
    before_action :set_business, except: %i[new create]
    before_action :set_business_workers_name, only: %i[edit update]
    before_action :business_present_access, only: %i[new create]
    skip_before_action :business_nil_access, only: %i[new create]

    def new
      if Rails.env.development?
        @business = Business.new(
          # テスト用デフォルト値 ==========================
          name:                                                        'test企業',
          name_kana:                                                   'テストキギョウ',
          branch_name:                                                 'test支店',
          # branch_address:                                              'test支店住所',
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
          business_employment_insurance_join_status:                   0, # 雇用保険(加入状況)
          business_employment_insurance_number:                        '01234567890', # 雇用保険(番号)
          business_retirement_benefit_mutual_aid_status:               0, # 退職金共済制度(加入状況)
          construction_license_status:                                 0 # 建設許可証(取得状況)
          # =============================================
        )
        @business.business_occupations.build
      else
        @business = Business.new
      end
    end

    def create
      @business = Business.new(business_params_with_converted)
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
      if @business.update(business_params_with_converted)
        flash[:success] = '更新しました'
        redirect_to users_business_url
      else
        render 'edit'
      end
    end

    def show; end

    # ajax
    def occupation_select
      @occupations = Occupation.where(industry_id: params[:industry_id]).pluck(:short_name, :id)
      render partial: 'occupation-select', locals: { occupations: @occupations }
    end

    def update_stamp_images
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

    def update_career_up_card_copy
      # 残りcareer_up_card_copyを定義
      remain_career_up_card_copy = @business.career_up_card_copy
      # career_up_card_copyを削除する
      deleted_career_up_card_copy = remain_career_up_card_copy.delete_at(params[:index].to_i)
      deleted_career_up_card_copy.try(:remove!)
      # 削除した後のscareer_up_card_copyをupdateする
      @business.update!(career_up_card_copy: remain_career_up_card_copy)
      flash[:danger] = '削除しました'
      redirect_to edit_users_business_url
    end

    private

    def set_business
      @business = current_user.business || current_user.admin_user.business
    end

    def business_params_with_converted
      converted_params = business_params.dup
      # 半角スペースがある場合、全角スペースに変換
      converted_params[:representative_name] = business_params[:representative_name].gsub(/[\s　]+/, ' ')
      # ハイフンを除外
      %i[post_code phone_number fax_number business_health_insurance_office_number business_welfare_pension_insurance_office_number
         business_employment_insurance_number].each do |key|
        next unless converted_params[key]

        converted_params[key] = converted_params[key].to_s.gsub(/[-ー]/, '')
      end
      converted_params
    end

    def business_params
      params.require(:business).permit(
        :uuid, :name, :name_kana, :branch_name, :representative_name, :address, :post_code,
        :phone_number, :fax_number, :email, :career_up_id, { career_up_card_copy: [] }, :business_type, { stamp_images: [] }, :employment_manager_name, :user_id,
        :business_health_insurance_status, :business_health_insurance_association,
        :business_health_insurance_office_number, :business_welfare_pension_insurance_join_status,
        :business_welfare_pension_insurance_office_number,
        :business_employment_insurance_join_status, :business_employment_insurance_number,
        :business_retirement_benefit_mutual_aid_status,
        :construction_license_status, :foreign_work_status_exist, :specific_skilled_foreigners_exist,
        :foreign_construction_workers_exist, :foreign_technical_intern_trainees_exist, :foreigners_employment_manager,
        business_industries_attributes: %i[id industry_id construction_license_permission_type_minister_governor
                                           construction_license_governor_permission_prefecture construction_license_permission_type_identification_general
                                           construction_license_number_double_digit construction_license_number_six_digits
                                           construction_license_number construction_license_updated_at _destroy],
        occupation_ids: [], tem_industry_ids: []
      )
    end
  end
end
# rubocop:enable all
