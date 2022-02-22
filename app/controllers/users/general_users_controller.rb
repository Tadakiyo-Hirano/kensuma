module Users
  class GeneralUsersController < Users::Base
    before_action :set_general_user, except: %i[index new create]

    def index
      @general_users = current_user.general_users
    end

    def new
      @general_user = current_user.general_users.new
    end

    def create
      @general_user = current_user.general_users.new(general_user_params)
      @general_user.skip_confirmation! # email認証スキップ
      if @general_user.save
        redirect_to users_general_user_url(@general_user)
      else
        render :new
      end
    end

    def edit; end

    def update
      if @general_user.update(general_user_params)
        flash[:success] = '更新しました'
        redirect_to users_general_user_url(@general_user)
      else
        render 'edit'
      end
    end

    def show; end

    def destroy
      @general_user.destroy
      flash[:danger] = "#{@general_user.name}を削除しました"
      redirect_to users_general_users_url
    end

    private

    def set_general_user
      @general_user = current_user.general_users.find(params[:id])
    end

    def general_user_params
      params.require(:user).permit(:name, :email, :age, :gender, :password)
    end
  end
end
