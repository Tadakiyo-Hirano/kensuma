module Users::Orders
  class FieldWorkersController < Users::Base
    before_action :set_order
    before_action :set_field_worker, only: :destroy
    before_action :set_field_workers, only: %i[index edit_workers update_workers]

    def index
      field_worker_ids = @field_workers.map { |field_worker| field_worker.content['id'] }
      @worker = current_business.workers.where.not(id: current_user).where.not(id: field_worker_ids)
    end

    def new; end

    def create
      ActiveRecord::Base.transaction do
        params[:worker_ids].each do |worker_id|
          @order.field_workers.create!(
            admission_worker_name: Worker.find(worker_id).name,
            content:               worker_info(Worker.find(worker_id))
          )
        end
        flash[:success] = "#{params[:worker_ids].count}名追加しました。"
        redirect_to users_order_field_workers_url
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度登録してください。'
      redirect_to users_order_field_workers_url
    end

    def destroy
      @field_worker.destroy!
      flash[:danger] = "#{@field_worker.admission_worker_name}を削除しました"
      redirect_to users_order_field_workers_url
    end

    def edit_workers; end

    def update_workers
      field_workers_params.each do |id, item|
        field_worker = FieldWorker.find(id)
        field_worker.update(item)
      end
      redirect_to users_order_field_workers_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def set_field_worker
      @field_worker = @order.field_workers.find_by(uuid: params[:uuid])
    end

    def set_field_workers
      @field_workers = @order.field_workers
    end

    def field_workers_params
      params.require(:order).permit(field_workers: %i[admission_date_start admission_date_end education_date])[:field_workers]
    end

    def worker_info(worker)
      JSON.parse(
        worker.to_json(
          except:  %i[uuid images created_at updated_at], # 作業員
          include: {
            worker_medical:            {
              except: %i[id worker_id created_at updated_at], # 作業員の健康情報
              include: {
                worker_exams: {
                  except: %i[id worker_medical_id images created_at updated_at] # 中間テーブル(特別健康診断種類マスタ))
                }
              }
            },
            worker_insurance:          {
              except: %i[id worker_id created_at updated_at] # 保険情報
            },
            worker_skill_trainings:    {
              only: [:skill_training_id] # 中間テーブル(技能講習マスタ)
            },
            worker_special_educations: {
              only: [:special_education_id] # 中間テーブル(特別教育マスタ)
            },
            worker_licenses:           {
              only: [:license_id] # 中間テーブル(免許マスタ)
            }
          }
        )
      )
    end
  end
end
