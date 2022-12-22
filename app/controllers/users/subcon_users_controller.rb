module Users
  class SubconUsersController < Users::Base
    before_action :set_subcon_users

    def index
    end

    def set_subcon_users
      @subcon_users = User.where(invited_by_id: current_user)
    end
  end
end
