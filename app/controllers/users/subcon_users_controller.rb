module Users
  class SubconUsersController < Users::Base
    before_action :set_subcon_users, only: :index
    before_action :set_subcon_user, only: :destroy
    before_action :set_q, only: [:index, :search]

    def index
      @users = User.all
    end

    def show
    end

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

    def search
      @results = @q.result
    end
  
    def set_q
      @q = User.ransack(params[:q])
    end
  end
end
