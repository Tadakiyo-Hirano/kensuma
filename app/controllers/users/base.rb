# frozen_string_literal: true

module Users
  class Base < ApplicationController
    before_action :authenticate_user!
    before_action :business_nil_access
    before_action :unread_news_count
    layout 'users'

    # 事業所が登録してあればダッシュボードへ
    def business_present_access
      redirect_to users_dash_boards_path if current_user.business.present?
    end

    # 事業所が登録してなければ事業所登録画面へ
    def business_nil_access
      redirect_to new_users_business_path, flash: { danger: '事業所を登録して下さい' } if current_user.business.nil? && current_user.admin?
    end

    def unread_news_count
      @unread_news_count = News.unread(current_user).count
    end

    # 現在のユーザーの事業所を取得
    def current_business
      if current_user.admin_user_id.nil?
        @current_business ||= current_user&.business
      elsif current_user.admin_user_id.present?
        @current_business ||= current_user&.admin_user&.business
      end
    end

    # 自社(事業所)の作業員名を取得
    def set_business_workers_name
      @business_workers_name = current_business.workers.pluck(:name)
    end

    # 書類に反映させる作業員情報
    def worker_info(worker)
      JSON.parse(
        worker.to_json(
          except:  %i[uuid images created_at updated_at], # 作業員
          include: {
            worker_medical:            {
              except:  %i[id worker_id created_at updated_at], # 作業員の健康情報
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

    # 書類に反映させる車両情報
    def car_info(car)
      json =
        JSON.parse(
          car.to_json(
            except:  %i[uuid images created_at updated_at], # 車両
            include: {
              car_voluntary_insurances: {
                except: %i[id created_at updated_at] # 任意保険
              }
            }
          )
        )

      insurance_company = { car_insurance_company: CarInsuranceCompany.find(json['car_insurance_company_id']).name }
      voluntary_insurance_company = { voluntary_insurance_company: CarInsuranceCompany.find(json['car_voluntary_insurances'][0]['car_voluntary_id']).name }

      json.merge(insurance_company, voluntary_insurance_company)
    end
  end
end
