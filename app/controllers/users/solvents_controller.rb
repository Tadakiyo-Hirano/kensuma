module Users
  class Users::SolventsController < Users::Base
    before_action :set_solvent, except: %i[index new create]

    def index
      @solvents = current_business.solvents
    end

    def new
      if Rails.env.development?
        @solvent = current_business.solvents.new(
          # テスト用デフォルト値 =====================
          name:           'テスト塗料液　硬化剤',
          maker:          '三菱化学',
          classification: 'エポキシ塗料',
          ingredients:    'アシン類'
          # =======================================
        )
      else
        @solvent = current_business.solvents.new
      end
    end

    def create
      @solvent = current_business.solvents.build(solvent_params)
      if @solvent.save
        redirect_to users_solvent_url(@solvent)
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if @solvent.update(solvent_params)
        flash[:success] = '更新しました'
        redirect_to users_solvent_url
      else
        render 'edit'
      end
    end

    def destroy
      @solvent.destroy!
      flash[:danger] = "#{@solvent.name}を削除しました"
      redirect_to users_solvents_url
    end

    private

    def set_solvent
      @solvent = current_business.solvents.find_by(uuid: params[:uuid])
    end

    def solvent_params
      params.require(:solvent).permit(:name, :maker, :classification, :ingredients)
    end
  end
end
