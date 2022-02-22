# frozen_string_literal: true

module Users
  class Base < ApplicationController
    before_action :authenticate_user!
    before_action :business_nil_access
    layout 'users'

    # 事業所が登録してあればダッシュボードへ
    def business_present_access
      redirect_to users_dash_boards_path if current_user.business.present?
    end

    # 事業所が登録してなければ事業所登録画面へ
    def business_nil_access
      redirect_to new_users_business_path, flash: { danger: '事業所を登録して下さい' } if current_user.business.nil?
    end

    # 現在のユーザーの事業所を取得
    def current_business
      if current_user.admin_user_id.nil?
        @current_business ||= current_user&.business
      elsif current_user.admin_user_id.present?
        @current_business ||= current_user&.admin_user&.business
      end
    end
  end
end
