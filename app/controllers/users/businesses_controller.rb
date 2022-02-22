module Users
  class BusinessesController < Users::Base
    before_action :set_business, except: %i[new create]
    before_action :business_present_access, only: %i[new create]
    skip_before_action :business_nil_access, only: %i[new create]

    def new
      @business = Business.new(
        uuid:                '1',
        name:                'test企業',
        name_kana:           'テストキギョウ',
        branch_name:         'test支店',
        representative_name: 'test代表',
        email:               'test@email.com',
        address:             'test',
        post_code:           '0123456',
        phone_number:        '01234567898',
        carrier_up_id:       'test',
        business_type:       0
      )
    end

    def create
      @business = Business.new(business_params)
      if @business.save
        redirect_to users_dash_boards_url
      else
        render :new
      end
    end

    def edit; end

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
      @business = current_user.business
    end

    def business_params
      params.require(:business).permit(:uuid, :name, :name_kana, :branch_name, :representative_name, :email, :address, :post_code,
        :phone_number, :carrier_up_id, :business_type, { stamp_images: [] }, :user_id)
    end
  end
end
