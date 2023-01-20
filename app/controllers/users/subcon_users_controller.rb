module Users
  class SubconUsersController < Users::Base
    before_action :set_subcon_users, only: :index
    before_action :set_subcon_user, only: :destroy

    def index; end

    def destroy
      @subcon_user.destroy!
      flash[:danger] = "#{@subcon_user.name}を削除しました"
      redirect_to users_subcon_users_url
    end

    private

    def set_subcon_users
      @subcon_users = User.where(invited_by_id: current_user)
    end

    def set_subcon_user
      @subcon_user = User.where(invited_by_id: current_user).find(params[:id])
    end
  end
end
