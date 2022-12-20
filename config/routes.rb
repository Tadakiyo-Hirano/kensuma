# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # admin関連=========================================================
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # =================================================================

  # user関連==========================================================
  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  namespace :users do
    resources :cars, param: :uuid
    resources :special_vehicles, param: :uuid
    resources :cars, except: %i[index create new show edit update destroy] do
      patch 'update_images'
    end
    resources :general_users
    resources :dash_boards, only: [:index]
    resources :articles, only: %i[index show]
    resources :news, only: %i[index show], param: :uuid
    resource :profile, except: %i[create new]
    resources :machines, param: :uuid
    resources :solvents, param: :uuid
    resource :business, except: %i[index destroy] do
      patch 'update_images'
    end
    resources :workers, param: :uuid
    resources :workers, except: %i[index create new show edit update destroy] do
      patch 'update_workerlicense_images'
      patch 'update_workerskilltraining_images'
      patch 'update_workerspecialeducation_images'
      patch 'update_workerexam_images'
    end
    resources :orders, param: :site_uu_id do
      resources :field_cars, except: %i[new show edit update], module: :orders, param: :uuid do
        collection do
          get 'edit_cars'
          patch 'update_cars'
        end
      end
      resources :field_fires, except: :index, module: :orders, param: :uuid
      resources :field_machines, except: %i[new show edit update], module: :orders, param: :uuid do
        collection do
          get 'edit_machines'
          patch 'update_machines'
        end
      end
      resources :field_solvents, except: :index, module: :orders, param: :uuid do
        get 'set_solvent_name_one', to: 'field_solvents#set_solvent_name_one'
        get 'set_solvent_name_two', to: 'field_solvents#set_solvent_name_two'
        get 'set_solvent_name_three', to: 'field_solvents#set_solvent_name_three'
        get 'set_solvent_name_four', to: 'field_solvents#set_solvent_name_four'
        get 'set_solvent_name_five', to: 'field_solvents#set_solvent_name_five'
        collection do
          get 'set_solvent_name_one'
          get 'set_solvent_name_two'
          get 'set_solvent_name_three'
          get 'set_solvent_name_four'
          get 'set_solvent_name_five'
        end
      end
      resources :field_special_vehicles, except: %i[new show edit update], module: :orders, param: :uuid do
        collection do
          get 'edit_special_vehicles'
          patch 'update_special_vehicles'
        end
      end
      resources :field_workers, except: %i[new show edit update], module: :orders, param: :uuid do
        collection do
          get 'edit_workers'
          patch 'update_workers'
        end
      end
    end
    # get 'orders/:order_site_uu_id/field_solvents/:uuid/set_solvent_name_one', to: 'users/orders/field_solvents#edit_set_solvent_name_one', as: :set_solvent_name_one_users_order_field_solvents
    resources :request_orders, only: %i[index show edit update], param: :uuid do
      resources :sub_request_orders, except: %i[edit destroy show], param: :uuid do
        resources :documents, only: %i[index show edit update], param: :uuid, controller: 'sub_request_orders/documents'
      end
      resources :documents, only: %i[index show edit update], param: :uuid
      resources :field_cars, except: %i[new show edit update], module: :request_orders, param: :uuid do
        collection do
          get 'edit_cars'
          patch 'update_cars'
        end
      end
      resources :field_fires, except: :index, module: :request_orders, param: :uuid
      resources :field_machines, except: %i[new show edit update], module: :request_orders, param: :uuid do
        collection do
          get 'edit_machines'
          patch 'update_machines'
        end
      end
      resources :field_solvents, except: :index, module: :request_orders, param: :uuid do
        get 'set_solvent_name_one', to: 'field_solvents#set_solvent_name_one'
        get 'set_solvent_name_two', to: 'field_solvents#set_solvent_name_two'
        get 'set_solvent_name_three', to: 'field_solvents#set_solvent_name_three'
        get 'set_solvent_name_four', to: 'field_solvents#set_solvent_name_four'
        get 'set_solvent_name_five', to: 'field_solvents#set_solvent_name_five'
        collection do
          get 'set_solvent_name_one'
          get 'set_solvent_name_two'
          get 'set_solvent_name_three'
          get 'set_solvent_name_four'
          get 'set_solvent_name_five'
        end
      end
      resources :field_special_vehicles, except: %i[new show edit update], module: :request_orders, param: :uuid do
        collection do
          get 'edit_special_vehicles'
          patch 'update_special_vehicles'
        end
      end
      resources :field_workers, except: %i[new show edit update], module: :request_orders, param: :uuid do
        collection do
          get 'edit_workers'
          patch 'update_workers'
        end
      end
    end
    post 'request_orders/:uuid/submit', to: 'request_orders#submit', as: :request_order_submit
    post 'request_orders/:uuid/sub_request_orders/:sub_request_uuid/fix_request', to: 'request_orders#fix_request', as: :request_order_fix_request
    post 'request_orders/:uuid/sub_request_orders/:sub_request_uuid/approve', to: 'request_orders#approve', as: :request_order_approve
  end
  # =================================================================

  # manager関連=======================================================
  # devise_for :managers, controllers: {
  #   sessions:      'managers/sessions',
  #   passwords:     'managers/passwords',
  #   confirmations: 'users/confirmations',
  #   registrations: 'managers/registrations'
  # }

  # =================================================================

  # system==============================================================
  # 利用規約
  get 'use' => 'system#use'
  # 特商法
  get 'law' => 'system#law'
  # プライバシーポリシー
  get 'privacy_policy' => 'system#privacy_policy'
  # =================================================================
end
