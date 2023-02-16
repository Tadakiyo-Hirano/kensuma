module Users
  class SubconUsersController < Users::Base
    before_action :approval_pending_user_ids, only: :index
    before_action :set_subcon_user, only: :destroy

    def index
      @invitation_requests = User.invitation_sent_to(current_user)
    end

    def destroy
      @subcon_user.destroy!
      flash[:danger] = "#{@subcon_user.name}を削除しました"
      redirect_to users_subcon_users_url
    end

    private

    def approval_pending_user_ids
      @approval_pending_user_ids = current_user.invitation_sent_user_ids
    end

    def set_subcon_user
      @subcon_user = User.where(invited_by_id: current_user).find(params[:id])
    end
  end
end
