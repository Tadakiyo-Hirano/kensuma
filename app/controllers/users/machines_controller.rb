module Users
  class MachinesController < Users::Base
    before_action :set_machine, except: %i[index new create]
    before_action :set_business_workers_name, only: %i[new create edit update]

    def index
      @machines = current_business.machines
    end

    def new
      @machine = current_business.machines.new(
        # テスト用デフォルト値 ==========================
        name:                  1,
        standards_performance: 'サンプル規格・性能',
        control_number:        'サンプル管理番号',
        inspector:             'サンプル管理者',
        handler:               'サンプル取扱者',
        # ============================================
      )
    end

    def create
      @machine = current_business.machines.build(machine_params)
      extra_item = [].append(
        params[:machine][:extra_inspection_item1], params[:machine][:extra_inspection_item2],
        params[:machine][:extra_inspection_item3], params[:machine][:extra_inspection_item4],
        params[:machine][:extra_inspection_item5], params[:machine][:extra_inspection_item6]
      ).flatten.compact_blank.uniq
      i = 1
      extra_item.each do |extra|
        @machine.send("extra_inspection_item#{i}=", extra)
        i += 1
      end
      while i <= 6
        @machine.send("extra_inspection_item#{i}=", '')
        i += 1
      end
      if @machine.save
        flash[:success] = '持込機械情報を登録しました'
        redirect_to users_machines_url(@machine)
      else
        render :new
      end
    end

    def show
      @machine = Machine.find(@machine.id)
      j = 1
      i = 0
      while j <= 6
        extra_count = @machine.send("extra_inspection_item#{j}")
        extra_count.present? ? i += 1 : i
        j += 1
      end
      @count = i
    end

    def edit; end

    def update
      extra_item = [].append(
        params[:machine][:extra_inspection_item1], params[:machine][:extra_inspection_item2],
        params[:machine][:extra_inspection_item3], params[:machine][:extra_inspection_item4],
        params[:machine][:extra_inspection_item5], params[:machine][:extra_inspection_item6]
      ).flatten.compact_blank.uniq
      i = 1
      extra_item.each do |extra|
        @machine.send("extra_inspection_item#{i}=", extra)
        i += 1
      end
      while i <= 6
        @machine.send("extra_inspection_item#{i}=", '')
        i += 1
      end
      if @machine.update(machine_update_params)
        flash[:success] = '更新しました'
        redirect_to users_machines_url
      else
        render 'edit'
      end
    end

    def destroy
      @machine.destroy!
      flash[:danger] = "#{@machine.name}を削除しました"
      redirect_to users_machines_url
    end

    private

    def set_machine
      @machine = current_business.machines.find_by(uuid: params[:uuid])
    end

    def machine_params
      params.require(:machine).permit(
        :id, :name, :standards_performance, :control_number, :inspector, :handler,
        :inspection_date, :inspection_check,
        :extra_inspection_item1, :extra_inspection_item2, :extra_inspection_item3,
        :extra_inspection_item4, :extra_inspection_item5, :extra_inspection_item6, tag_ids: []
      )
    end

    def machine_update_params
      params.require(:machine).permit(
        :id, :name, :standards_performance, :control_number, :inspector, :handler,
        :inspection_date, :inspection_check, tag_ids: []
      )
    end
  end
end
